import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/core/widgets/primary_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      title: 'Seamless Market Tracking',
      description:
          'Stay ahead with real-time data, personalized insights, and comprehensive analysis tools tailored for every investor.',
      imagePath: 'assets/images/onboarding_seamless.png',
    ),
    OnboardingContent(
      title: 'Smart Insights, Smarter Trades',
      description:
          'Gain an edge with AI-powered analysis and personalized stock recommendations tailored to your goals.',
      imagePath: 'assets/images/onboarding_insights.png',
    ),
    OnboardingContent(
      title: 'Empower Your Financial Future',
      description:
          'Take control of your investments with AI-powered insights, real-time data, and personalized portfolio management. SHOCK Stock Market helps you make smarter decisions, faster.',
      imagePath: 'assets/images/onboarding_empower.png',
    ),
  ];

  void _onNext() {
    if (_currentPage < _contents.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to login
      context.go('/login');
    }
  }

  String _getButtonText() {
    if (_currentPage == 0) return 'Continue';
    if (_currentPage == 1) return 'Next';
    return 'Get Started';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          // Background Gradient Element (Subtle)
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryBlue.withOpacity(0.05),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlue.withOpacity(0.15),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: _contents.length,
                    itemBuilder: (context, index) {
                      return OnboardingContentWidget(content: _contents[index]);
                    },
                  ),
                ),

                // Bottom Control Section
                Container(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      // Modern Pill Indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _contents.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _currentPage == index ? 32 : 8,
                            height: 6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: _currentPage == index
                                  ? AppColors.primaryBlue
                                  : AppColors.darkCardBackground,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Full Width Action Button
                      PrimaryButton(
                        text: _getButtonText(),
                        onPressed: _onNext,
                        backgroundColor: AppColors.primaryBlue,
                        textColor: Colors.white,
                        borderRadius: 16,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingContent {
  final String title;
  final String description;
  final String imagePath;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

class OnboardingContentWidget extends StatelessWidget {
  final OnboardingContent content;

  const OnboardingContentWidget({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image Container with Modern Stacking Effect
          Expanded(
            flex: 5,
            child: Container(
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Glow underneath
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryBlue.withOpacity(0.05),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          blurRadius: 60,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    // Ensure image fits beautifully
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 320),
                      child: Image.asset(
                        content.imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 48),

          // Typography
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Text(
                  content.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.darkTextPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  content.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.darkTextSecondary,
                    fontSize: 16,
                    height: 1.6,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
