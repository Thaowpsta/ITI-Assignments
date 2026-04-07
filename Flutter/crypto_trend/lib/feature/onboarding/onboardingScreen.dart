import 'package:crypto_trend/feature/onboarding/widgets/CustomBody.dart';
import 'package:crypto_trend/feature/onboarding/widgets/CustomTitle.dart';
import 'package:crypto_trend/utils/AppAssets.dart';
import 'package:crypto_trend/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../utils/AppRoutes.dart';
import '../../utils/widgets/PrimaryButton.dart';
import '../auth/presentation/AuthScreen.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  double index = 0;
  List titles = [
    "Trade anytime anywhere",
    "Save and invest at the same time",
    "Transact fast and easy",
  ];
  List images = [
    AppAssets.onboarding1,
    AppAssets.onboarding2,
    AppAssets.onboarding3,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 0.8,
            colors: [AppColors.teal1, AppColors.darkBackground],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 93.0, horizontal: 29),
          child: Column(
            children: [
              Image.asset(images[index.toInt()]),
              SizedBox(height: 30),
              CustomTitle(title: titles[index.toInt()]),
              SizedBox(height: 20),
              CustomBody(),
              SizedBox(height: 30),
              DotsIndicator(
                dotsCount: 3,
                position: index,
                decorator: DotsDecorator(
                  color: AppColors.darkGrey, // Inactive dot colors
                  activeColor: AppColors.primary, // Àctive dot colors
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50.0,
                  vertical: 16,
                ),
                child: PrimaryButton(
                  text: index < 2 ? "Next" : "Get Started",
                  onPressed: () {
                    setState(() {
                      if (index < 2) {
                        index++;
                      } else {
                        Navigator.pushNamed(context, AppRoutes.auth);
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
