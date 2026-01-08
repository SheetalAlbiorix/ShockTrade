import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/core/widgets/primary_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  bool _isSuccess = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleReset() {
    // Mock success logic
    if (_emailController.text.isNotEmpty) {
      setState(() {
        _isSuccess = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.darkCardBackground,
              border: Border.all(color: AppColors.darkDivider),
            ),
            child: const Icon(Icons.arrow_back_ios_new,
                size: 16, color: AppColors.darkTextPrimary),
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              if (!_isSuccess) ...[
                // Header
                const Text(
                  'Reset Password',
                  style: TextStyle(
                    color: AppColors.darkTextPrimary,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter your email address and we will send you instructions to reset your password.',
                  style: TextStyle(
                    color: AppColors.darkTextSecondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 48),

                // Email Input
                const Text('Email Address',
                    style: TextStyle(
                        color: AppColors.darkTextSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                      color: AppColors.darkTextPrimary,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: 'name@example.com',
                    hintStyle: TextStyle(
                        color: AppColors.darkTextSecondary.withOpacity(0.5)),
                    filled: true,
                    fillColor: AppColors.darkCardBackground,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    prefixIcon: const Icon(Icons.email_outlined,
                        color: AppColors.darkTextSecondary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: AppColors.darkDivider),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: AppColors.primaryBlue),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Primary Button
                PrimaryButton(
                  text: 'Send Reset Link',
                  onPressed: _handleReset,
                  backgroundColor: AppColors.primaryBlue,
                  textColor: Colors.white,
                  borderRadius: 16,
                ),
              ] else ...[
                // Success State
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.mark_email_read_outlined,
                            size: 40, color: AppColors.primaryBlue),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Check your email',
                        style: TextStyle(
                          color: AppColors.darkTextPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'We have sent a password reset link to your email address.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.darkTextSecondary,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 48),
                      PrimaryButton(
                        text: 'Back to Login',
                        onPressed: () => context.pop(),
                        backgroundColor: AppColors.darkCardBackground,
                        textColor: AppColors.darkTextPrimary,
                        borderRadius: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
