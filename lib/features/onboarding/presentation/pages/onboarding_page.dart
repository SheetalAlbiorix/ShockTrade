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
      backgroundColor: Colors.black, // Dark background as per design
      body: SafeArea(
        child: Column(
          children: [
            // Skip button (optional, but good UX)
            // Align(
            //   alignment: Alignment.topRight,
            //   child: TextButton(
            //     onPressed: () => context.go('/login'),
            //     child: const Text('Skip', style: TextStyle(color: Colors.white70)),
            //   ),
            // ),

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

            // Bottom Section
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Page Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _contents.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? AppColors.navActiveColor
                              : Colors.white24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Button
                  PrimaryButton(
                    text: _getButtonText(),
                    onPressed: _onNext,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  content.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 48),
          // Title
          Text(
            content.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          // Description
          Text(
            content.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
