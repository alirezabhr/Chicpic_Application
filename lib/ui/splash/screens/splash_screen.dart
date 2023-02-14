import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/bloc/auth/auth_bloc.dart';

import 'package:chicpic/statics/assets_helper.dart';

import 'package:chicpic/ui/splash/widgets/connection_failed_dialog.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  bool _isLoaded = false;
  final int showSplashSeconds = 3;
  final int checkLoadingMilliseconds = 500;

  void startTimer() {
    _isLoaded = false;
    _timer = Timer.periodic(
      Duration(seconds: showSplashSeconds),
      (Timer timer) => setState(
        () {
          _isLoaded = true;
          _timer.cancel();
        },
      ),
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _routeTo(String route) {
    Navigator.of(context).pushReplacementNamed(route);
  }

  Future<void> _waitAndNavigateTo(String route) async {
    while (!_isLoaded) {
      await Future.delayed(Duration(milliseconds: checkLoadingMilliseconds));
    }
    _routeTo(route);
  }

  void _retryAppLoading() {
    if (_isLoaded) {
      startTimer();
    }
    BlocProvider.of<AuthBloc>(context).add(AppLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            _waitAndNavigateTo(AppRouter.main);
          } else if (state is AuthConnectionProblem) {
            showDialog(
              context: context,
              builder: (_) => ConnectionFailedDialog(retry: _retryAppLoading),
            );
          } else if (state is AuthNotAuthenticated) {
            _waitAndNavigateTo(AppRouter.login);
          } else if (state is AuthNotVerified) {
            _waitAndNavigateTo(AppRouter.login);
          }
        },
        builder: (context, state) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetsHelper.logo, scale: 4),
                const SizedBox(height: 20),
                Text(
                  'chicpic',
                  style: TextStyle(
                    fontFamily: 'Dyna Puff',
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Container(
                  child: state is AuthLoading || _isLoaded == false
                      ? JumpingDotsProgressIndicator(
                          fontSize: 80,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Text(
                            '...',
                            style: TextStyle(
                              fontSize: 80,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
