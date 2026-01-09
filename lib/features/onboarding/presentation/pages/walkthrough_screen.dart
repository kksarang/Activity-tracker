import 'package:activity/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      'image':
          'https://i.ibb.co/nj0Xh3Z/split-bill-illustration.png', // Placeholder
    },
    {
      'title': 'Track Your\nExpenses',
      'description':
          'Keep track of your daily expenses and see where your money goes.',
      'image': 'https://i.ibb.co/5GzXy0w/track-expenses.png', // Placeholder
    },
    {
      'title': 'Easy Payments',
      'description':
          'Settle up with friends instantly using integrated payment options.',
      'image': 'https://i.ibb.co/vz1Xy0w/easy-payments.png', // Placeholder
    },
  ];

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
                color: AppColors.primaryPurple.withOpacity(0.3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryPurple.withOpacity(0.4),
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
                color: AppColors.peach.withOpacity(0.3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.peach.withOpacity(0.4),
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
                            // Illustration Placeholder
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
                                        : Colors.white.withOpacity(0.5),
                                  ),
                              child: Center(
                                child: Icon(
                                  Icons.receipt_long_rounded,
                                  size: 100,
                                  color: AppColors.primaryPurple.withOpacity(
                                    0.5,
                                  ),
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
                                  : Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                      // Next / Get Started Button
                      GestureDetector(
                        onTap: () {
                          if (_currentPage < _pages.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            context.go('/home'); // Or /login if auth needed
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
                                color: AppColors.primaryPurple.withOpacity(0.4),
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
