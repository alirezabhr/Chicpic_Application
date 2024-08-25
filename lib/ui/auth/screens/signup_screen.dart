import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_validator/email_validator.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/statics/assets_helper.dart';
import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/services/snack_bar.dart';

import 'package:chicpic/bloc/auth/auth_bloc.dart';

import 'package:chicpic/models/auth/signup_user_data.dart';

import 'package:chicpic/ui/auth/widgets/submit_button.dart';
import 'package:chicpic/ui/auth/widgets/auth_divider.dart';
import 'package:chicpic/ui/auth/widgets/google_button.dart';
import 'package:chicpic/ui/terms_conditions_privacy_policy/widgets/terms_conditions_privacy_policy_links.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  bool _obscurePassword = true;
  bool _obscurePassword2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is SignupFailure) {
            showSnackBar(context, state.error, SnackBarStatus.error);
          }
          if (state is SocialAuthFailure) {
            showSnackBar(context, state.error, SnackBarStatus.error);
          }
          if (state is SocialAuthSuccess) {
            Navigator.pushReplacementNamed(context, AppRouter.main);
          }
          if (state is SignupSuccess) {
            BlocProvider.of<AuthBloc>(context).add(
              AuthRequestVerificationCode(_emailController.text),
            );
            Navigator.of(context).pushReplacementNamed(
              AppRouter.verificationAccount,
              arguments: _emailController.text
            );
          }
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Insets.large,
                vertical: Insets.large,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AssetsHelper.logo, scale: 8),
                  const SizedBox(height: Insets.large),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required.';
                      }
                      if (value.contains('@') || value.contains('-')) {
                        return 'Username should not have @ or - characters.';
                      }
                      if (value.length < 2) {
                        return 'Username is too short.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: Insets.small),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required.';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Email is not valid.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: Insets.small),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      isDense: true,
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    obscureText: _obscurePassword,
                    enableSuggestions: false,
                    autocorrect: false,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required.';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: Insets.small),
                  TextFormField(
                    controller: _passwordController2,
                    decoration: InputDecoration(
                      isDense: true,
                      border: const OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword2 = !_obscurePassword2;
                          });
                        },
                        icon: Icon(
                          _obscurePassword2
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    obscureText: _obscurePassword2,
                    enableSuggestions: false,
                    autocorrect: false,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required.';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords are not the same.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: Insets.small),
                  const TermsConditionsPrivacyPolicyLinks(),
                  const SizedBox(height: Insets.xSmall),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          SubmitButton(
                            onPressed: state is AuthLoading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      var signupData = SignupUserData(
                                        username: _usernameController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        password2: _passwordController2.text,
                                      );
                                      BlocProvider.of<AuthBloc>(context).add(
                                        SignupWithCredentials(signupData),
                                      );
                                    }
                                  },
                            label: 'Signup',
                            child: state is SignupLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  )
                                : null,
                          ),
                          const AuthDivider(),
                          const GoogleButton(),
                        ],
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an Account?',
                        style: TextStyle(fontSize: 12),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, AppRouter.login);
                        },
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
