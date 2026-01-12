import 'package:activity/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Split Bill with\nFriends & Family',
      'description':
          'Manage your bills with your friends more easily with just this application.',
      'lottie':
          'https://assets5.lottiefiles.com/packages/lf20_5w2szn.json', // Split/Group
      'fallbackIcon': 'group_add_rounded',
    },
    {
      'title': 'Track Your\nExpenses',
      'description':
          'Keep track of your daily expenses and see where your money goes.',
      'lottie':
          'https://assets9.lottiefiles.com/packages/lf20_sF7xnR.json', // Analysis/Chart
      'fallbackIcon': 'bar_chart_rounded',
    },
    {
      'title': 'Easy Payments',
      'description':
          'Settle up with friends instantly using integrated payment options.',
      'lottie':
          'https://assets3.lottiefiles.com/packages/lf20_w51pcehl.json', // Payment
      'fallbackIcon': 'credit_card_rounded',
    },
  ];

  IconData _getIconData(String name) {
    switch (name) {
      case 'group_add_rounded':
        return Icons.group_add_rounded;
      case 'bar_chart_rounded':
        return Icons.bar_chart_rounded;
      case 'credit_card_rounded':
        return Icons.credit_card_rounded;
      default:
        return Icons.image_not_supported_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [const Color(0xFF1E1E2C), const Color(0xFF2D2D44)]
                    : [const Color(0xFFF3E5F5), const Color(0xFFE1F5FE)],
              ),
            ),
          ),

          // Mesh Orbs
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryPurple.withValues(alpha: 0.3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryPurple.withValues(alpha: 0.4),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.peach.withValues(alpha: 0.3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.peach.withValues(alpha: 0.4),
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
                    itemCount: _pages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Lottie / Illustration
                            Container(
                              height: 300,
                              width: double.infinity,
                              decoration:
                                  AppTheme.glassDecoration(
                                    isDark: isDark,
                                    radius: 32,
                                  ).copyWith(
                                    color: isDark
                                        ? AppColors.darkGlassOverlay
                                        : Colors.white.withValues(alpha: 0.5),
                                  ),
                              child: Center(
                                child: Lottie.network(
                                  _pages[index]['lottie']!,
                                  height: 250,
                                  width: 250,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    // Fallback when Offline or URL failed
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          _getIconData(
                                            _pages[index]['fallbackIcon']!,
                                          ),
                                          size: 80,
                                          color: AppColors.primaryPurple
                                              .withValues(alpha: 0.5),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'Animation offline',
                                          style: TextStyle(
                                            color: isDark
                                                ? Colors.white38
                                                : Colors.black26,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 48),
                            Text(
                              _pages[index]['title']!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _pages[index]['description']!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Bottom Section: Indicators & Button
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Page Indicators
                      Row(
                        children: List.generate(
                          _pages.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 8),
                            height: 8,
                            width: _currentPage == index ? 24 : 8,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? AppColors.primaryPurple
                                  : Colors.grey.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                      // Next / Get Started Button
                      GestureDetector(
                        onTap: () async {
                          if (_currentPage < _pages.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            // On Finish, mark as seen and go to Login
                            final prefs = await SharedPreferences.getInstance();
                            if (!context.mounted) return;

                            await prefs.setBool('seenWalkthrough', true);
                            if (!context.mounted) return;

                            context.go('/');
                          }
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: AppColors.primaryPurple,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryPurple.withValues(
                                  alpha: 0.4,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
