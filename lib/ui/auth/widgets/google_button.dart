import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'package:chicpic/bloc/auth/auth_bloc.dart';

import 'package:chicpic/statics/assets_helper.dart';

import 'package:chicpic/statics/insets.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 3 / 5,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return OutlinedButton(
            onPressed: state is AuthLoading
                ? null
                : () {
                    BlocProvider.of<AuthBloc>(context).add(GoogleAuthRequest());
                  },
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: Insets.medium),
              ),
            ),
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AssetsHelper.googleIcon, scale: 2),
                  const SizedBox(width: Insets.xSmall),
                  state is GoogleAuthLoading
                      ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Insets.xLarge),
                        child: CollectionScaleTransition(
                          children: const [
                            Icon(Icons.circle, color: Colors.blue, size: 10),
                            Icon(Icons.circle, color: Colors.green, size: 10),
                            Icon(Icons.circle, color: Colors.orangeAccent, size: 10),
                            Icon(Icons.circle, color: Colors.red, size: 10),
                          ],
                        ),
                      )
                      : const Text(
                          'Continue with Google',
                          style: TextStyle(color: Colors.black),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
