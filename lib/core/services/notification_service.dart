import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart'; // Required for background handler
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  debugPrint("Handling a background message: ${message.messageId}");
}

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

      // 2. Setup Local Notifications (Android Foreground)
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.max,
      );

      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      // Initialize
      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(),
        ),
      );

      // 3. Apple Foreground Options
      await _messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // 4. Get Initial Token and Sync
      final token = await _messaging.getToken();
      if (token != null) {
        debugPrint('FCM Token: $token');
        await _syncToken(token);
      }

      // 5. Listen for Token Refresh
      _messaging.onTokenRefresh.listen((newToken) {
        debugPrint('FCM Token Refreshed: $newToken');
        _syncToken(newToken);
      });

      // 6. Handle Foreground Messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('Got a message whilst in the foreground!');

        // Show Local Notification
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: android.smallIcon, // Use @mipmap/ic_launcher if null?
                // other properties...
              ),
              iOS: const DarwinNotificationDetails(),
            ),
          );
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
