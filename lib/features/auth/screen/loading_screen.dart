import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:tarkiz/core/constants/strings.dart';
import 'package:tarkiz/core/routing/app_routes.dart';
import 'package:tarkiz/core/theme/palette.dart';
import 'package:tarkiz/features/auth/widget/loading_indicator.dart';

class TarkizLoadingScreen extends StatefulWidget {
  final String? loadingText;

  const TarkizLoadingScreen({super.key, this.loadingText = AppStrings.loading});

  @override
  State<TarkizLoadingScreen> createState() => _TarkizLoadingScreenState();
}

class _TarkizLoadingScreenState extends State<TarkizLoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    // Navigate to success screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go(AppRoute.success.path);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: Palette.loadingGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo
            Image.asset('assets/icons/app_logo.png', height: 150, width: 150),

            const SizedBox(height: 40),

            // Line-based loading spinner
            SizedBox(
              width: 40,
              height: 40,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    painter: LinedCirclePainter(
                      color: Palette.green,
                      progress: _controller.value,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Loading text
            Text(
              widget.loadingText!,
              style: const TextStyle(color: Palette.green, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
