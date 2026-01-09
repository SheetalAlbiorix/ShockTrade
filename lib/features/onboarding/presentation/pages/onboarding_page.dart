import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/core/widgets/primary_button.dart';

class OnboardingData {
  final String imagePath;
  final IconData cardIcon;
  final Color cardIconColor;
  final String cardTitle;
  final String cardBadgeText;
  final Color cardBadgeColor;
  final String cardValue;
  final String? cardBottomRightText; // For "Target: ..."
  final String titlePrefix;
  final String titleHighlight;
  final String description;

  const OnboardingData({
    required this.imagePath,
    required this.cardIcon,
    required this.cardIconColor,
    required this.cardTitle,
    required this.cardBadgeText,
    required this.cardBadgeColor,
    required this.cardValue,
    this.cardBottomRightText,
    required this.titlePrefix,
    required this.titleHighlight,
    required this.description,
  });
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    // Page 1
    const OnboardingData(
      imagePath: 'assets/images/onboarding_hero_3d.png',
      cardIcon: Icons.trending_up,
      cardIconColor: Colors.green,
      cardTitle: 'NIFTY 50',
      cardBadgeText: '+1.45%',
      cardBadgeColor: Colors.green,
      cardValue: '19,425.30',
      titlePrefix: 'Invest with ',
      titleHighlight: 'Confidence',
      description:
          'Access NSE & BSE stocks with lightning-fast execution and pro-level charts.',
    ),
    // Page 2
    const OnboardingData(
      imagePath: 'assets/images/onboarding_hero_3d.png',
      cardIcon: Icons.analytics,
      cardIconColor: Colors.blue,
      cardTitle: 'HDFC Bank',
      cardBadgeText: '+0.95%',
      cardBadgeColor: Colors.green,
      cardValue: '1,512.00',
      titlePrefix: 'Pro-Level ',
      titleHighlight: 'Analytics',
      description:
          'Master the markets with advanced charting tools, 100+ indicators, and real-time insights.',
    ),
    // Page 3
    const OnboardingData(
      imagePath: 'assets/images/onboarding_hero_3d.png',
      cardIcon: Icons.notifications_active,
      cardIconColor: Colors.orange,
      cardTitle: 'Reliance Ind.',
      cardBadgeText: 'Alert Hit',
      cardBadgeColor: Colors.orange,
      cardValue: '₹2,456.80',
      cardBottomRightText: 'Target: ₹2,450',
      titlePrefix: 'Stay Ahead with ',
      titleHighlight: 'Smart Alerts',
      description:
          'Never miss an opportunity. Set custom price triggers and get notified instantly.',
    ),
  ];

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.goNamed('login');
    }
  }

  String _getButtonText() {
    if (_currentPage == 0) return 'Get Started';
    if (_currentPage == _pages.length - 1) return 'Continue to App';
    return 'Next';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation / Brand (Static)
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.primaryBlue.withOpacity(0.2),
                      ),
                    ),
                    child: const Icon(
                      Icons.candlestick_chart,
                      color: AppColors.primaryBlue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'ShockTrade',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Content Area (Sliding)
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final data = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Hero Visual: 3D Abstract Chart
                        Expanded(
                          flex: 6,
                          child: Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(maxHeight: 500),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.05)),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryBlue.withOpacity(0.1),
                                  blurRadius: 25,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                // Main Image (Local Asset)
                                Image.asset(
                                  data.imagePath,
                                  fit: BoxFit.cover,
                                ),

                                // Gradient Overlay (Background Dark to Transparent)
                                Positioned.fill(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          AppColors.darkBackground,
                                          Colors.transparent,
                                          Colors.transparent,
                                        ],
                                        stops: [0.0, 0.4, 1.0],
                                      ),
                                    ),
                                  ),
                                ),

                                // Top Gradient
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          AppColors.primaryBlue
                                              .withOpacity(0.2),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // Floating Stats Card
                                Positioned(
                                  bottom: 24,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 12, sigmaY: 12),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF1c2230)
                                                .withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color:
                                                  Colors.white.withOpacity(0.1),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: data.cardIconColor
                                                      .withOpacity(0.1),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  data.cardIcon,
                                                  color: data.cardIconColor,
                                                  size: 24,
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          data.cardTitle,
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF94a3b8),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            letterSpacing: 0.5,
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 6,
                                                                  vertical: 2),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: data
                                                                .cardBadgeColor
                                                                .withOpacity(
                                                                    0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                          child: Text(
                                                            data.cardBadgeText,
                                                            style: TextStyle(
                                                              color: data
                                                                  .cardBadgeColor,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          data.cardValue,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 0.5,
                                                          ),
                                                        ),
                                                        if (data.cardBottomRightText !=
                                                            null)
                                                          Text(
                                                            data.cardBottomRightText!,
                                                            style:
                                                                const TextStyle(
                                                                    color: Color(
                                                                        0xFF94a3b8), // slate-400
                                                                    fontSize:
                                                                        11,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                          )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Typography
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              height: 1.1,
                              color: Colors.white,
                              fontFamily: 'Inter',
                            ),
                            children: [
                              TextSpan(text: data.titlePrefix),
                              TextSpan(
                                text: data.titleHighlight,
                                style: const TextStyle(
                                    color: AppColors.primaryBlue),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          data.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF94a3b8),
                            fontSize: 16,
                            height: 1.5,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Dots and Bottom Area (Static)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  // Pagination Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (idx) {
                      bool isActive = idx == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isActive ? 32 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.primaryBlue
                              : const Color(0xFF334155),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),

            // Bottom Action Area (Static)
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
              child: Column(
                children: [
                  // Button
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryBlue.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: PrimaryButton(
                      text: _getButtonText(),
                      onPressed: _onNext,
                      backgroundColor: AppColors.primaryBlue,
                      textColor: Colors.white,
                      borderRadius: 8,
                      height: 56,
                      textStyle: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Log in Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                          color: Color(0xFF94a3b8),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.goNamed('login');
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
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
