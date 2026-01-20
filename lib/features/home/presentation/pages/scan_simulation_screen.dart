import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/core/constants/app_routes.dart'; // Ensure it's there if needed, though this file uses pushReplacement with path string? No, used context.pushReplacement(AppRoutes...) or logic? Let's check imports.
import 'package:activity/features/home/constants/home_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScanSimulationScreen extends StatefulWidget {
  const ScanSimulationScreen({super.key});

  @override
  State<ScanSimulationScreen> createState() => _ScanSimulationScreenState();
}

class _ScanSimulationScreenState extends State<ScanSimulationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.1, end: 0.9).animate(_controller);

    // Simulate scan completion after 3 seconds if not cancelled
    /* 
    Timer(const Duration(seconds: 3), () {
      if (mounted) _completeScan();
    });
    */
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Fake Camera View
          Container(
            color: Colors.grey[900],
            child: const Center(
              child: Icon(Icons.camera_alt, color: Colors.white12, size: 80),
            ),
          ),

          // Scanning Overlay
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => context.pop(),
                      ),
                      const Text(
                        HomeStrings.scanReceipt,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.flash_off, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Scan Frame
                Container(
                  width: 300,
                  height: 450,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white54, width: 2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Stack(
                    children: [
                      // Scanning Line
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Positioned(
                            top: 450 * _animation.value,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 2,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryPurple,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryPurple,
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Controls
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          HomeStrings.pointCamera,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Capture Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: GestureDetector(
                    onTap: () {
                      // Simulate capture
                      _controller.stop();
                      context.pushReplacement(
                        AppRoutes.addExpense,
                        extra: false,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(HomeStrings.receiptScanned),
                        ),
                      );
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
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
