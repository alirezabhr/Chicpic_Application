import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/statics/insets.dart';
import 'package:chicpic/statics/assets_helper.dart';

import 'package:chicpic/bloc/login/login_bloc.dart';

import 'package:chicpic/models/auth/login_user_data.dart';

import 'package:chicpic/ui/auth/widgets/submit_button.dart';
import 'package:chicpic/ui/auth/widgets/auth_divider.dart';
import 'package:chicpic/ui/auth/widgets/google_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
          if (state is LoginAccountNotVerified) {
            Navigator.of(context).pushReplacementNamed(
              AppRouter.emailVerification,
            );
          }
          if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, AppRouter.main);
          }
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Insets.large,
                vertical: Insets.xLarge,
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
                      labelText: 'Username or Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required.';
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
                      return null;
                    },
                  ),
                  const SizedBox(height: Insets.small),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          SubmitButton(
                            onPressed: state is LoginLoading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      var loginData = LoginUserData(
                                        username: _usernameController.text,
                                        password: _passwordController.text,
                                      );
                                      BlocProvider.of<LoginBloc>(context).add(
                                        LoginWithUsernamePassword(
                                          userData: loginData,
                                        ),
                                      );
                                    }
                                  },
                            label: 'Login',
                            child: state is LoginLoadingWithForm
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  )
                                : null,
                          ),
                          const AuthDivider(),
                          GoogleButton(
                            onPressed: state is LoginLoading ? null : () {},
                            label: 'Sign in with Google',
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: Insets.medium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not registered yet?',
                        style: TextStyle(fontSize: 12),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, AppRouter.signup);
                        },
                        child: Text(
                          'Create an Account',
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
