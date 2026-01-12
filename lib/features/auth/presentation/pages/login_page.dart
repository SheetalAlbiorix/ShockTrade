import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (Firebase.apps.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'Firebase is not configured. Authentication is disabled.')),
          );
        }
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final idToken = await userCredential.user?.getIdToken();

      debugPrint('FIREBASE ID TOKEN: $idToken');

      // Check Email Verification
      final isVerified = userCredential.user?.emailVerified ?? false;
      if (!isVerified) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please verify your email address.')),
          );

          // Optionally send verification here if you want:
          // await userCredential.user?.sendEmailVerification();

          context.go('/verify-email');
        }
        return; // Stop here
      }

      // Verification Passed: Exchange for Supabase Token
      if (mounted) {
        try {
          final authService = AuthService(Supabase.instance.client);
          await authService.exchangeTokenAndAuthenticate();
        } catch (e) {
          debugPrint('Supabase Token Exchange Failed: $e');
          // Optional: Show error or continue?
          // For now we continue as the requirement says "Flutter can always send Firebase token...
          // and receive ... to use for DB calls".
          // If it fails, DB calls might fail, but let's not block login if strictly not required,
          // though likely we *should* block or warn.
          // I'll log it.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Supabase Login Failed: $e')),
          );
          return; // Don't navigate to home if Supabase auth fails?
          // User Requirement: "The Flutter app will first authenticate with Firebase, then get a Supabase JWT... and use that..."
          // So failure here should probably stop the flow or warn.
        }
      }

      if (mounted) {
        context.go('/home');
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        String message = 'Authentication failed';
        if (e.code == 'user-not-found') {
          // Auto-register for testing convenience
          try {
            final userCredential =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            );

            final idToken = await userCredential.user?.getIdToken();
            debugPrint('FIREBASE ID TOKEN (NEW USER): $idToken');

            // NOTE: New users are NOT verified by default.
            // Send verification email
            await userCredential.user?.sendEmailVerification();

            if (mounted) {
              context.go('/verify-email');
            }
            return;
          } catch (regError) {
            message = 'Registration failed: $regError';
          }
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided.';
        } else {
          message = e.message ?? message;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e) {
      debugPrint('LOGIN ERROR: $e'); // Added debug print
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Colors from HTML (hardcoded as requested)
    const Color backgroundColor = Color(0xFF101622); // dark:bg-background-dark
    const Color inputBg = Color(0xFF1c1f27); // dark:bg-[#1c1f27]
    const Color inputBorder = Color(0xFF3b4354); // border-[#3b4354]

    // Tailwind Colors (Dark Mode variants)
    const Color textColor = Colors.white; // dark:text-white
    const Color subTextColor = Color(0xFF94a3b8); // dark:text-slate-400

    // Explicit Colors from HTML
    const Color placeholderColor = Color(0xFF9da6b9); // text-[#9da6b9]
    const Color primaryColor = Color(0xFF135bec); // AppColors.primaryBlue

    const Color cardColor = inputBg;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color:
                  backgroundColor.withOpacity(0.9), // sticky header imitation
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  InkWell(
                    onTap: () => context.pop(),
                    borderRadius: BorderRadius.circular(9999),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
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
                  // Title
                  const Text(
                    'ShockTrade',
                    style: TextStyle(
                      fontFamily:
                          'Inter', // Assuming Inter is available or fallback
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.27, // -0.015 * 18
                    ),
                  ),
                  // Help Button
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 40,
                      alignment: Alignment.centerRight,
                      child: const Icon(
                        Icons.help,
                        size: 24,
                        color: placeholderColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Main Content Area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                        height:
                            32), // Spacing to match "justify-center" somewhat

                    // Headlines & Logo
                    Center(
                      child: Column(
                        children: [
                          // App Logo Placeholder / Icon
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                colors: [
                                  primaryColor,
                                  Color(0xFF2563EB)
                                ], // primary to blue-600
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(
                                      19, 91, 236, 0.2), // primary/20
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                )
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.candlestick_chart,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                          const Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: textColor,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              height: 1.1, // leading-tight
                              letterSpacing: -0.42, // -0.015 * 28
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Trade India's Future with confidence",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: subTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Email Field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 4, bottom: 6),
                          child: Text(
                            'Email or Username',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: cardColor,
                            border: Border.all(color: inputBorder),
                            borderRadius: BorderRadius.circular(
                                12), // rounded-xl -> 0.75rem -> 12px
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 12, right: 10),
                                child: Icon(
                                  Icons.person,
                                  color: placeholderColor,
                                  size: 20,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _emailController,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    hintText: 'Enter your email',
                                    hintStyle:
                                        TextStyle(color: placeholderColor),
                                    contentPadding: EdgeInsets.only(
                                        bottom: 2), // Adjust alignment
                                    isDense: true,
                                    filled: true,
                                    fillColor:
                                        Colors.transparent, // Fix white bg
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Password Field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 4, bottom: 6),
                          child: Text(
                            'Password',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: cardColor,
                            border: Border.all(color: inputBorder),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 12, right: 10),
                                child: Icon(
                                  Icons.lock,
                                  color: placeholderColor,
                                  size: 20,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: !_isPasswordVisible,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    hintText: 'Enter your password',
                                    hintStyle:
                                        TextStyle(color: placeholderColor),
                                    contentPadding: EdgeInsets.only(bottom: 2),
                                    isDense: true,
                                    filled: true,
                                    fillColor:
                                        Colors.transparent, // Fix white bg
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: placeholderColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Forgot Password
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 6, bottom: 20), // space-y-5 approx
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.push('/forgot-password');
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Login Button
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 4, // shadow-lg
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          shadowColor: primaryColor.withOpacity(0.25),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Log In',
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

                    // Biometric Option
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Center(
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: placeholderColor,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.fingerprint,
                                size: 24,
                                color:
                                    placeholderColor, // Hover to primary not easily doable in standard flutter without specialized widget or MouseRegion
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Login with Face ID',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Divider
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Row(
                        children: [
                          const Expanded(child: Divider(color: inputBorder)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                color: placeholderColor,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider(color: inputBorder)),
                        ],
                      ),
                    ),

                    // Social Login
                    Row(
                      children: [
                        Expanded(
                          child: _SocialButton(
                            icon: const Text(
                              'G',
                              style: TextStyle(
                                fontFamily: ' sans-serif', // Fallback
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            label: 'Google',
                            onTap: () {},
                            borderColor: inputBorder,
                            cardColor: cardColor,
                            textColor: textColor,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _SocialButton(
                            icon: const Icon(Icons.phone_iphone,
                                size: 22, color: textColor),
                            label: 'Apple',
                            onTap: () {},
                            borderColor: inputBorder,
                            cardColor: cardColor,
                            textColor: textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Footer
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'New to ShockTrade? ',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: placeholderColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/register'),
                    child: const Text(
                      'Create Account',
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
}

class _SocialButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;
  final Color borderColor;
  final Color cardColor;
  final Color textColor;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.borderColor,
    required this.cardColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // For Google 'G', we passed Text widget. For Apple, Icon.
              // We need to ensure text style inside 'G' inherits correctly if not explicit.
              DefaultTextStyle(
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
                child: icon,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
