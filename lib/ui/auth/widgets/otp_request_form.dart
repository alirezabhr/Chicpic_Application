import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_validator/email_validator.dart';

import 'package:chicpic/bloc/auth/auth_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/ui/auth/widgets/submit_button.dart';

class OTPRequestForm extends StatelessWidget {
  final String title;
  final Function(String emailAddress) onSuccess;
  final Function? onFailure;

  OTPRequestForm({required this.onSuccess, this.onFailure, Key? key, required this.title})
      : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is VerificationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
          if (onFailure != null) {
            onFailure!();
          }
        } else if (state is VerificationSent) {
          onSuccess(_emailController.text);
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.xLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: Insets.xLarge),
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: Insets.xLarge),
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
              const Spacer(),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: Insets.large),
                    child: SubmitButton(
                      onPressed: state is VerificationLoading
                          ? null
                          : () {
                              BlocProvider.of<AuthBloc>(context).add(
                                AuthRequestVerificationCode(
                                  _emailController.text,
                                ),
                              );
                            },
                      label: 'Continue',
                      child: state is VerificationLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            )
                          : null,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
