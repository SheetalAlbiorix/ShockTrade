import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/core/widgets/primary_button.dart';

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
        title: const Text(
          'Create Account',
          style: TextStyle(
            color: AppColors.darkTextPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              // Full Name
              const Text('Full Name',
                  style: TextStyle(
                      color: AppColors.darkTextSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                style: const TextStyle(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: 'Enter your full name',
                  hintStyle: TextStyle(
                      color: AppColors.darkTextSecondary.withOpacity(0.5)),
                  filled: true,
                  fillColor: AppColors.darkCardBackground,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  prefixIcon: const Icon(Icons.person_outline,
                      color: AppColors.darkTextSecondary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.darkDivider),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.primaryBlue),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Email
              const Text('Email',
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
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(
                      color: AppColors.darkTextSecondary.withOpacity(0.5)),
                  filled: true,
                  fillColor: AppColors.darkCardBackground,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  prefixIcon: const Icon(Icons.email_outlined,
                      color: AppColors.darkTextSecondary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.darkDivider),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.primaryBlue),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Password
              const Text('Password',
                  style: TextStyle(
                      color: AppColors.darkTextSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                style: const TextStyle(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: 'Create a strong password',
                  hintStyle: TextStyle(
                      color: AppColors.darkTextSecondary.withOpacity(0.5)),
                  filled: true,
                  fillColor: AppColors.darkCardBackground,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  prefixIcon: const Icon(Icons.lock_outline,
                      color: AppColors.darkTextSecondary),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.darkTextSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.darkDivider),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.primaryBlue),
                  ),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    _strengthText,
                    style: TextStyle(
                        color: _strengthColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              if (_strengthText.isEmpty)
                const SizedBox(height: 14), // Placeholder height
              const SizedBox(height: 16),

              // Confirm Password
              const Text('Confirm Password',
                  style: TextStyle(
                      color: AppColors.darkTextSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: !_isConfirmPasswordVisible,
                style: const TextStyle(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: 'Re-enter your password',
                  hintStyle: TextStyle(
                      color: AppColors.darkTextSecondary.withOpacity(0.5)),
                  filled: true,
                  fillColor: AppColors.darkCardBackground,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  prefixIcon: const Icon(Icons.lock_outline,
                      color: AppColors.darkTextSecondary),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.darkTextSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.darkDivider),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.primaryBlue),
                  ),
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
                      activeColor: AppColors.primaryBlue,
                      checkColor: Colors.white,
                      side:
                          const BorderSide(color: AppColors.darkTextSecondary),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
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
                            color: AppColors.darkTextSecondary, fontSize: 13),
                        children: [
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: const TextStyle(
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(
                                color: AppColors.primaryBlue,
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
                backgroundColor: _agreedToTerms
                    ? AppColors.primaryBlue
                    : AppColors.darkCardBackground,
                textColor:
                    _agreedToTerms ? Colors.white : AppColors.darkTextSecondary,
                borderRadius: 16,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStrengthBar(int index, double currentStrength) {
    bool isActive = false;
    if (currentStrength >= 0.3 && index == 1) isActive = true;
    if (currentStrength >= 0.6 && index == 2) isActive = true;
    if (currentStrength >= 1.0 && index == 3) isActive = true;

    // Use AppColors for strength
    Color activeColor = _strengthColor;
    // If logic uses fixed colors, map them to AppColors
    if (_strengthColor == Colors.red) activeColor = AppColors.bearishRed;
    if (_strengthColor == Colors.orange)
      activeColor = AppColors.chartOrange; // Assuming chartOrange or similar
    if (_strengthColor == Colors.green) activeColor = AppColors.bullishGreen;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 4,
      decoration: BoxDecoration(
        color: isActive ? activeColor : AppColors.darkCardBackground,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
