import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VerifyEmailPage extends ConsumerStatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  ConsumerState<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends ConsumerState<VerifyEmailPage> {
  bool _isSendingVerification = false;
  bool _isChecking = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Optionally send verification email immediately if not recently sent
    // For now we assume the user might have just registered or logged in
    // _sendVerificationEmail();

    // Auto-check every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      _checkEmailVerified();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        setState(() => _isSendingVerification = true);
        await user.sendEmailVerification();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Verification email sent!')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending email: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSendingVerification = false);
    }
  }

  Future<void> _checkEmailVerified() async {
    // Don't check if we are already doing heavy lifting or navigation
    if (_isChecking) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await user.reload(); // Poll changes from Firebase
      if (user.emailVerified) {
        _timer?.cancel();
        setState(() => _isChecking = true);

        // Exchange Token Flow
        final authService = AuthService(Supabase.instance.client);
        await authService.exchangeTokenAndAuthenticate();

        if (mounted) {
          context.go('/home');
        }
      }
    } catch (e) {
      debugPrint("Verification check failed: $e");
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    // Colors (Matched from LoginPage)
    const Color backgroundColor = Color(0xFF101622);
    // const Color cardColor = Color(0xFF1c1f27); // Unused
    const Color primaryColor = Color(0xFF135bec);
    const Color textColor = Colors.white;
    const Color subTextColor = Color(0xFF94a3b8);
    const Color placeholderColor = Color(0xFF9da6b9);

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.mark_email_unread_outlined,
                size: 80,
                color: primaryColor,
              ),
              const SizedBox(height: 32),
              const Text(
                'Verify your email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: textColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'We\'ve sent a verification email to\n${user?.email ?? "your email address"}.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  color: subTextColor,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please click the link in the email to verify your account.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: subTextColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 48),

              // "I've Verified" Button (Manual Check)
              ElevatedButton(
                onPressed: _checkEmailVerified,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  fixedSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isChecking
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : const Text(
                        'I have verified',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),

              const SizedBox(height: 24),

              // Resend Button
              TextButton(
                onPressed:
                    _isSendingVerification ? null : _sendVerificationEmail,
                style: TextButton.styleFrom(
                  foregroundColor: placeholderColor,
                ),
                child: _isSendingVerification
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text(
                        'Resend Verification Email',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
              ),

              const Spacer(),

              // Sign Out
              TextButton.icon(
                onPressed: _signOut,
                icon: const Icon(Icons.arrow_back, size: 20),
                label: const Text('Back to Login'),
                style: TextButton.styleFrom(
                  foregroundColor: subTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
