import 'package:flutter/material.dart';

import '../feature/auth/presentation/AuthScreen.dart';
import '../feature/onboarding/onboardingScreen.dart';
import '../feature/onboarding/splashScreen.dart';
import '../feature/profile/profileScreen.dart';
import '../feature/settings/SettingsScreen.dart';
import 'RootScreen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const Splashscreen(),
    onboarding: (context) => OnboardingScreen(),
    auth: (context) => const AuthScreen(),
    home: (context) => const RootScreen(),
    profile: (context) => const ProfileScreen(),
    settings: (context) => const SettingsScreen(),
  };
}