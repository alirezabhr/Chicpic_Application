import 'package:flutter/material.dart';

import 'package:chicpic/ui/splash/screens/splash_screen.dart';
import 'package:chicpic/ui/main/screens/main_screen.dart';
import 'package:chicpic/ui/auth/screens/login_screen.dart';
import 'package:chicpic/ui/auth/screens/signup_screen.dart';
import 'package:chicpic/ui/auth/screens/email_verification_screen.dart';
import 'package:chicpic/ui/auth/screens/verification_code_screen.dart';
import 'package:chicpic/ui/user_additional/screens/user_additional_screen.dart';
import 'package:chicpic/ui/terms_conditions_privacy_policy/screens/privacy_policy.dart';
import 'package:chicpic/ui/terms_conditions_privacy_policy/screens/terms_and_condition.dart';
import 'package:chicpic/ui/category/screens/category_screen.dart';
import 'package:chicpic/ui/shop/screens/shop_screen.dart';
import 'package:chicpic/ui/explore/screens/search_screen.dart';

abstract class AppRouter {
  static const String splash = "/";
  static const String main = "/main";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String emailVerification = "/emailVerification";
  static const String verificationAccount = "/verifyAccount";
  static const String userAdditional = "/userAdditional";
  static const String termsConditions = "/terms";
  static const String privacyPolicy = "/privacy";
  static const String category = "/category";
  static const String shop = "/shop";
  static const String search = "/search";

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
      case userAdditional:
        return MaterialPageRoute(builder: (_) => const UserAdditionalScreen());
      case termsConditions:
        return MaterialPageRoute(builder: (_) => const TermsConditionsScreen());
      case privacyPolicy:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());
      case category:
        return MaterialPageRoute(
          builder: (_) => const CategoryScreen(),
          settings: routeSettings,
        );
      case shop:
        return MaterialPageRoute(
          builder: (_) => const ShopScreen(),
          settings: routeSettings,
        );
      case search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      default:
        return null;
    }
  }
}
