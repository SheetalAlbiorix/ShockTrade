import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/core/widgets/primary_button.dart';
import 'package:shock_app/core/widgets/custom_text_field.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _agreedToTerms = false;

  // Password Strength State
  double _strength = 0; // 0 to 1
  String _strengthText = '';
  Color _strengthColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_checkPasswordStrength);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _checkPasswordStrength() {
    String password = _passwordController.text;
    if (password.isEmpty) {
      setState(() {
        _strength = 0;
        _strengthText = '';
        _strengthColor = Colors.grey;
      });
      return;
    }

    // Simple strength logic
    // Weak: < 6 chars
    // Medium: >= 6 chars
    // Strong: >= 8 chars + number + special char (Mock logic for UI matching)

    double newStrength = 0;
    String newText = 'Weak';
    Color newColor = Colors.red;

    if (password.length > 8 && password.contains(RegExp(r'[0-9]'))) {
      newStrength = 1.0;
      newText = 'Strong';
      newColor = Colors.green;
    } else if (password.length >= 6) {
      newStrength = 0.6;
      newText = 'Fair'; // "Fair" or "Medium"
      newColor = Colors.orange;
    } else {
      newStrength = 0.3;
      newText = 'Weak';
      newColor = Colors.red;
    }

    setState(() {
      _strength = newStrength;
      _strengthText = newText;
      _strengthColor = newColor;
    });
  }

  void _handleRegister() {
    if (_agreedToTerms) {
      // Implement registration logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Account created successfully. Please login.')),
      );
      context.go('/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to Terms & Conditions')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Create Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              // Full Name
              const Text('Full Name', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _nameController,
                hintText: 'Enter your full name',
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 16),

              // Email
              const Text('Email', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _emailController,
                hintText: 'Enter your email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Password
              const Text('Password', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _passwordController,
                hintText: 'Create a strong password',
                prefixIcon: Icons.lock_outline, // Keeping consistent with login
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Password Strength Bars
              Row(
                children: [
                  Expanded(child: _buildStrengthBar(1, _strength)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildStrengthBar(2, _strength)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildStrengthBar(3, _strength)),
                ],
              ),
              const SizedBox(height: 6),
              if (_strengthText.isNotEmpty)
                Text(
                  _strengthText,
                  style: TextStyle(
                      color: _strengthColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              if (_strengthText.isEmpty)
                const SizedBox(height: 14), // Placeholder height
              const SizedBox(height: 16),

              // Confirm Password
              const Text('Confirm Password',
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _confirmPasswordController,
                hintText: 'Re-enter your password',
                prefixIcon: Icons.lock_outline,
                obscureText: !_isConfirmPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Terms
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _agreedToTerms,
                      activeColor: AppColors.navActiveColor, // Cyan
                      checkColor: Colors.black,
                      side: const BorderSide(color: Colors.white54),
                      onChanged: (val) {
                        setState(() {
                          _agreedToTerms = val ?? false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'I agree to the ',
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 13),
                        children: [
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: const TextStyle(
                                color: AppColors.navActiveColor,
                                fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(
                                color: AppColors.navActiveColor,
                                fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              PrimaryButton(
                text: 'Create Account',
                onPressed: _handleRegister,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStrengthBar(int index, double currentStrength) {
    // 3 bars total.
    // Index 1, 2, 3.
    // Logic:
    // Weak (0.3) -> Bar 1 filled.
    // Medium (0.6) -> Bar 1, 2 filled.
    // Strong (1.0) -> Bar 1, 2, 3 filled.

    bool isActive = false;
    if (currentStrength >= 0.3 && index == 1) isActive = true;
    if (currentStrength >= 0.6 && index == 2) isActive = true;
    if (currentStrength >= 1.0 && index == 3) isActive = true;

    return Container(
      height: 4,
      decoration: BoxDecoration(
        color: isActive ? _strengthColor : const Color(0xFF2C2C2E), // Dark grey
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
