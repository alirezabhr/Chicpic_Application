import 'package:flutter/material.dart';

import 'ui/splash/screens/splash_screen.dart';
import 'ui/main/screens/main_screen.dart';
import 'ui/auth/screens/login_screen.dart';
import 'ui/auth/screens/signup_screen.dart';
import 'ui/auth/screens/email_verification_screen.dart';
import 'ui/auth/screens/verification_code_screen.dart';

abstract class AppRouter {
  static const String splash = "/";
  static const String main = "/main";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String emailVerification = "/emailVerification";
  static const String verificationAccount = "/verify";

  static Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case emailVerification:
        return MaterialPageRoute(
            builder: (_) => const EmailVerificationScreen());
      case verificationAccount:
        return MaterialPageRoute(
          builder: (_) => const VerificationCodeScreen(),
          settings: routeSettings,
        );
      default:
        return null;
    }
  }
}
