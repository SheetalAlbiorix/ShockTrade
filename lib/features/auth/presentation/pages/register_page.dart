import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _agreedToTerms = false;

  // Colors from HTML
  static const Color backgroundColor =
      Color(0xFF101622); // dark:bg-background-dark
  static const Color surfaceColor = Color(0xFF1c1f27); // dark:bg-surface-dark
  static const Color borderColor = Color(0xFF3b4354); // dark:border-border-dark
  static const Color primaryColor = Color(0xFF135bec); // primary
  static const Color primaryBlue400 = Color(0xFF60A5FA); // blue-400 approx

  static const Color textColor = Colors.white; // dark:text-white
  static const Color subTextColor = Color(0xFF94a3b8); // dark:text-slate-400
  static const Color placeholderColor = Color(
      0xFF64748b); // dark:placeholder:text-slate-500 (slate-500 is ~#64748b)

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (!_agreedToTerms) return;
    context.go('/login'); // Mock navigation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => context.pop(),
                    borderRadius: BorderRadius.circular(9999),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // hover effect is handled by InkWell's ripple mostly
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          size: 24,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Section
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                              colors: [primaryColor, primaryBlue400],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.show_chart, // material symbol 'show_chart'
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'SHOCKTRADE',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0, // wide tracking
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Create your account',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: textColor,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                        letterSpacing: -0.5, // tight tracking
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Invest in India's future today. Join the fastest growing trading community.",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: subTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Form Section
                    // Email
                    _buildLabel('Email Address'),
                    const SizedBox(height: 8),
                    _buildInputContainer(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _emailController,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                color: textColor,
                                fontSize: 16,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'name@example.com',
                                hintStyle: TextStyle(color: placeholderColor),
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.mail, // filled
                            color: subTextColor, // slate-400
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Password
                    _buildLabel('Password'),
                    const SizedBox(height: 8),
                    _buildInputContainer(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                color: textColor,
                                fontSize: 16,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Create a strong password',
                                hintStyle: TextStyle(color: placeholderColor),
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            child: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: subTextColor,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Confirm Password
                    _buildLabel('Confirm Password'),
                    const SizedBox(height: 8),
                    _buildInputContainer(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _confirmPasswordController,
                              obscureText: !_isConfirmPasswordVisible,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                color: textColor,
                                fontSize: 16,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Repeat your password',
                                hintStyle: TextStyle(color: placeholderColor),
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              });
                            },
                            child: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: subTextColor,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Terms Checkbox
                    InkWell(
                      onTap: () {
                        setState(() {
                          _agreedToTerms = !_agreedToTerms;
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: _agreedToTerms
                                    ? primaryColor
                                    : surfaceColor,
                                border: Border.all(
                                  color: _agreedToTerms
                                      ? primaryColor
                                      : subTextColor, // slate-600 logic
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: _agreedToTerms
                                  ? const Icon(Icons.check,
                                      size: 16, color: Colors.white)
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  color: subTextColor,
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                                children: [
                                  const TextSpan(text: 'I agree to the '),
                                  TextSpan(
                                    text: 'Terms of Service',
                                    style: const TextStyle(
                                      color: primaryColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                  const TextSpan(text: ' and '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: const TextStyle(
                                      color: primaryColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                  const TextSpan(
                                      text: ' regarding SEBI compliance.'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Create Account Button
                    SizedBox(
                      height: 56, // h-14
                      child: ElevatedButton(
                        onPressed: _handleRegister,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          // hover/active states handled by Material
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Create Account',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Divider
                    Row(
                      children: [
                        const Expanded(child: Divider(color: borderColor)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'OR REGISTER WITH',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: subTextColor, // slate-400
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider(color: borderColor)),
                      ],
                    ),
                    const SizedBox(height: 16), // gap-4

                    // Social ButtonsGrid
                    Row(
                      children: [
                        Expanded(
                          child: _SocialButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'G',
                                  style: TextStyle(
                                    fontFamily: 'sans-serif',
                                    color: textColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Google',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: subTextColor.withOpacity(
                                        0.8), // slate-700/200 logic
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _SocialButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.phone_iphone,
                                    size: 22, color: textColor),
                                const SizedBox(width: 8),
                                Text(
                                  'Apple',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: subTextColor.withOpacity(0.8),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: backgroundColor,
                border: Border(
                    top: BorderSide(
                        color: borderColor)), // border-slate-800/50 approx
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already a member? ',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: subTextColor,
                    ),
                  ),
                  InkWell(
                    onTap: () => context.go('/login'),
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Inter',
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildInputContainer({required Widget child}) {
    return Container(
      height: 56, // h-14
      padding: const EdgeInsets.symmetric(horizontal: 16), // px-4
      decoration: BoxDecoration(
        color: surfaceColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12), // rounded-xl
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}

class _SocialButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const _SocialButton({required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48, // h-12
      decoration: BoxDecoration(
        color: _RegisterPageState.surfaceColor,
        border: Border.all(color: _RegisterPageState.borderColor),
        borderRadius: BorderRadius.circular(8), // rounded-lg
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Center(child: child),
        ),
      ),
    );
  }
}
