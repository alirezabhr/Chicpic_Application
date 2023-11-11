import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/services/snack_bar.dart';

import 'package:chicpic/bloc/auth/auth_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/auth/reset_password_data.dart';

import 'package:chicpic/ui/auth/widgets/submit_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  bool _obscurePassword = true;
  bool _obscurePassword2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthResetPasswordSuccess) {
            showSnackBar(
              context,
              'Password reset successfully.',
              SnackBarStatus.success,
            );
            Navigator.of(context).pop();
          } else if (state is AuthResetPasswordFailure) {
            showSnackBar(context, state.error, SnackBarStatus.error);
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
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      isDense: true,
                      border: const OutlineInputBorder(),
                      labelText: 'New Password',
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
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          SubmitButton(
                            onPressed: state is AuthLoading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<AuthBloc>(context).add(
                                        AuthResetPassword(
                                          ResetPasswordData(
                                            email: ModalRoute.of(context)!
                                                .settings
                                                .arguments as String,
                                            password: _passwordController.text,
                                            password2:
                                                _passwordController2.text,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                            label: 'Change Password',
                            child: state is AuthLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  )
                                : null,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: Insets.medium),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
