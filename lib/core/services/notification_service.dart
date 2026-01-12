import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:shock_app/core/config/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService {
  final SupabaseClient _supabaseClient;
  final FirebaseMessaging _messaging;

  NotificationService(this._supabaseClient)
      : _messaging = FirebaseMessaging.instance;

  /// Initializes the notification service.
  /// Requests permission and sets up listeners.
  Future<void> initialize() async {
    try {
      // 1. Request Permission
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('User granted permission');
      } else {
        debugPrint('User declined or has not accepted permission');
        return; // No point continuing if no permission? Actually token might still be needed for silent push.
        // But usually we respect this.
      }

      // 2. Get Initial Token and Sync
      final token = await _messaging.getToken();
      if (token != null) {
        debugPrint('FCM Token: $token');
        await _syncToken(token);
      }

      // 3. Listen for Token Refresh
      _messaging.onTokenRefresh.listen((newToken) {
        debugPrint('FCM Token Refreshed: $newToken');
        _syncToken(newToken);
      });

      // 4. Handle Foreground Messages (Optional for now)
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('Got a message whilst in the foreground!');
        if (message.notification != null) {
          debugPrint(
              'Message also contained a notification: ${message.notification}');
        }
      });
    } catch (e) {
      debugPrint("Error initializing notifications: $e");
    }
  }

  /// Syncs the FCM token to Supabase via Edge Function.
  Future<void> _syncToken(String token) async {
    try {
      // Manual Auth Header construction (Robust Pattern)
      final authHeader = _supabaseClient.headers['Authorization'];
      if (authHeader == null) {
        debugPrint("Skipping Token Sync: No User Session");
        return;
      }

      String deviceId = 'unknown';
      String deviceType = 'unknown';

      if (kIsWeb) {
        deviceType = 'web';
        deviceId = 'web-session';
      } else {
        deviceType = Platform.operatingSystem;
        final deviceInfo = DeviceInfoPlugin();
        if (Platform.isAndroid) {
          final androidInfo = await deviceInfo.androidInfo;
          deviceId = androidInfo.id; // stable android ID
        } else if (Platform.isIOS) {
          final iosInfo = await deviceInfo.iosInfo;
          deviceId = iosInfo.identifierForVendor ?? 'ios-unknown';
        }
      }

      await _supabaseClient.functions.invoke(
        'sync-fcm-token',
        body: {
          'token': token,
          'device_type': deviceType,
          'device_id': deviceId,
        },
        headers: {
          'Authorization': authHeader,
        },
      );
      debugPrint("✅ FCM Token Synced to Supabase (Device: $deviceId)");
    } catch (e) {
      debugPrint("❌ Failed to sync FCM token: $e");
    }
  }

  /// Deletes the FCM token from Supabase (e.g. on logout).
  Future<void> deleteToken() async {
    try {
      // Ideally, we'd call a 'delete-fcm-token' function or just let it rot?
      // Or delete directly via RLS if we have table access.
      // For now, simpler to just delete instance locally.
      // To be strict, we SHOULD delete it from DB so we don't send to logged-out devices.
      // Let's rely on RLS and direct deletion for now as it's cleaner than another function.

      final token = await _messaging.getToken();
      if (token == null) return;

      await _supabaseClient.from('fcm_tokens').delete().eq('token', token);

      debugPrint("🗑️ FCM Token Deleted from Supabase");
    } catch (e) {
      debugPrint("Failed to delete FCM token: $e");
    }
  }
}
