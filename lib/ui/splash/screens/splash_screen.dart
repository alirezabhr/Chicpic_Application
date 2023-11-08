import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/services/api_service.dart';

import 'package:chicpic/bloc/auth/auth_bloc.dart';

import 'package:chicpic/statics/assets_helper.dart';

import 'package:chicpic/models/app_version.dart';

import 'package:chicpic/ui/splash/widgets/connection_failed_dialog.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  String appName = '';
  String currentVersion = '';
  bool _isLoaded = false;
  bool _needUpdate = true;
  final int showSplashSeconds = 3;
  final int checkLoadingMilliseconds = 500;

  setAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      currentVersion = packageInfo.version;
    });
  }

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

  showUpgradeDialog(AppVersion version) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('New Version Available'),
        content: Text('Version ${version.version} is available. '
            'Please update the app to continue using it.'),
        actions: [
          TextButton(
            onPressed: () =>
                SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () async {
              await launchUrl(
                Uri.parse(version.url),
                mode: LaunchMode.externalApplication,
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  checkAppVersion() async {
    // Get current platform
    final String platform = Platform.isAndroid ? 'android' : 'ios';

    List<AppVersion> versions = await APIService.getVersions();
    // Sort versions by latest published date time
    versions.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
    // Get latest version for current platform
    AppVersion latestVersion =
        versions.firstWhere((e) => e.platform == platform && e.forceUpdate);

    if (latestVersion.compareVersion(currentVersion) == 1) {
        showUpgradeDialog(latestVersion);
    } else {
      setState(() {
        _needUpdate = false;
      });
    }
  }

  @override
  void initState() {
    setAppInfo();
    startTimer();
    checkAppVersion();
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
    while (!_isLoaded || _needUpdate) {
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
                  appName,
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
                const SizedBox(height: 20),
                Text(
                  'v $currentVersion',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
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
