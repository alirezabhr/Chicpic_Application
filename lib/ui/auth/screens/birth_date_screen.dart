import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/services/snack_bar.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/bloc/auth/auth_bloc.dart';

import 'package:chicpic/ui/auth/widgets/birth_date_form.dart';

class BirthDateScreen extends StatelessWidget {
  const BirthDateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? birthDate;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Extra Information'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRouter.main);
            },
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUpdateUserSuccess) {
            Navigator.pushReplacementNamed(context, AppRouter.main);
          } else if (state is AuthUpdateUserFailure) {
            showSnackBar(context, state.error, SnackBarStatus.error);
          }
        },
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(Insets.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter your birth date',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Text(
                  'To suggest you better products, we need to know more about you.',
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(height: Insets.large),
                BirthDateForm(onSelectDate: (date) {
                  birthDate = date;
                }),
                const SizedBox(height: Insets.large),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: state is AuthUpdateUserLoading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                          AuthUpdateBirthdate(birthDate!),
                                        );
                                  }
                                },
                          child: state is AuthUpdateUserLoading
                              ? const Text('Submitting...')
                              : const Text('Continue'),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
