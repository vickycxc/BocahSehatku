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

  int _currentPage = 0;

  void _startAutoSwipe() {
    Future.delayed(Duration(seconds: 5), () {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = (_currentPage + 1 % splashMessages.length) - 1;
      });
      _startAutoSwipe();
    });
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () {
      _startAutoSwipe();
    });
    super.initState();
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
                  _currentPage = index % splashMessages.length;
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
                        splashMessages[_currentPage]['title']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        splashMessages[_currentPage]['subtitle']!,
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
            count: splashMessages.length,
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
    _pageController.dispose();
    super.dispose();
  }
}
