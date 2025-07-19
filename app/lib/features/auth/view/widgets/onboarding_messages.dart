import 'dart:async';

import 'package:app/core/constants.dart';
import 'package:app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingMessages extends StatefulWidget {
  const OnboardingMessages({super.key});

  @override
  State<OnboardingMessages> createState() => _OnboardingMessagesState();
}

class _OnboardingMessagesState extends State<OnboardingMessages> {
  final _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  void _startAutoSwipe() {
    _timer?.cancel(); // Cancel timer sebelumnya jika ada
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_pageController.hasClients && mounted) {
        try {
          final nextPage = (_currentPage + 1) % Constants.splashMessages.length;
          _pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          if (mounted) {
            setState(() {
              _currentPage = nextPage;
            });
          }
        } catch (e) {
          print('Error in auto swipe: $e');
          timer.cancel();
        }
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Tunggu frame berikutnya untuk memastikan PageView sudah ter-build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoSwipe();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index % Constants.splashMessages.length;
                });
              },
              controller: _pageController,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [
                      Text(
                        Constants.splashMessages[_currentPage]['title']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        Constants.splashMessages[_currentPage]['subtitle']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SmoothPageIndicator(
            controller: _pageController,
            count: Constants.splashMessages.length,
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Palette.accentColor,
              dotColor: Colors.grey.shade300,
            ),
            onDotClicked: (index) {
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel timer untuk mencegah memory leak
    _pageController.dispose();
    super.dispose();
  }
}
