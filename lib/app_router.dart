import 'package:flutter/material.dart';

import 'package:chicpic/ui/splash/screens/splash_screen.dart';
import 'package:chicpic/ui/main/screens/main_screen.dart';
import 'package:chicpic/ui/auth/screens/login_screen.dart';
import 'package:chicpic/ui/auth/screens/signup_screen.dart';
import 'package:chicpic/ui/auth/screens/email_verification_screen.dart';
import 'package:chicpic/ui/auth/screens/verification_code_screen.dart';
import 'package:chicpic/ui/auth/screens/forget_password.dart';
import 'package:chicpic/ui/auth/screens/reset_password_verification.dart';
import 'package:chicpic/ui/auth/screens/reset_password.dart';
import 'package:chicpic/ui/auth/screens/birth_date_screen.dart';
import 'package:chicpic/ui/user_additional/screens/user_additional_screen.dart';
import 'package:chicpic/ui/user_additional/screens/size_guide_screen.dart';
import 'package:chicpic/ui/category/screens/category_screen.dart';
import 'package:chicpic/ui/shop/screens/shop_screen.dart';
import 'package:chicpic/ui/shop/screens/shops_explore_screen.dart';
import 'package:chicpic/ui/explore/screens/search_screen.dart';
import 'package:chicpic/ui/profile/screens/saved_variants_screen.dart';
import 'package:chicpic/ui/profile/screens/account_settings_screen.dart';
import 'package:chicpic/ui/profile/screens/delete_account_verification.dart';

abstract class AppRouter {
  static const String splash = "/";
  static const String main = "/main";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String emailVerification = "/emailVerification";
  static const String verificationAccount = "/verifyAccount";
  static const String forgetPassword = "/forgetPassword";
  static const String resetPasswordVerification = "/resetPasswordVerification";
  static const String resetPassword = "/resetPassword";
  static const String birthDate = "/birth-date";
  static const String userAdditional = "/userAdditional";
  static const String sizeGuide = "/size_guide";
  static const String category = "/category";
  static const String shop = "/shop";
  static const String shopsExplore = "/shops-explore";
  static const String search = "/search";
  static const String savedVariants = "/saved-variants";
  static const String accountSettings = "/account-settings";
  static const String deleteAccountVerification =
      "/delete-account-verification";

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
      case forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case resetPasswordVerification:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordVerificationScreen(),
          settings: routeSettings,
        );
      case resetPassword:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(),
          settings: routeSettings,
        );
      case birthDate:
        return MaterialPageRoute(builder: (_) => const BirthDateScreen());
      case userAdditional:
        return MaterialPageRoute(builder: (_) => const UserAdditionalScreen());
      case sizeGuide:
        return MaterialPageRoute(builder: (_) => const SizeGuideScreen());
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
      case shopsExplore:
        return MaterialPageRoute(
          builder: (_) => const ShopsExploreScreen(),
          settings: routeSettings,
        );
      case search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case savedVariants:
        return MaterialPageRoute(
          builder: (_) => const SavedVariantsScreen(),
          settings: routeSettings,
        );
      case accountSettings:
        return MaterialPageRoute(builder: (_) => const AccountSettingsScreen());
      case deleteAccountVerification:
        return MaterialPageRoute(
          builder: (_) => const DeleteAccountVerificationScreen(),
          settings: routeSettings,
        );
      default:
        return null;
    }
  }
}
