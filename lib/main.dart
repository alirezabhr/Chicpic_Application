import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:chicpic/statics/theme.dart';

import 'package:chicpic/repositories/auth/auth_repository.dart';
import 'package:chicpic/repositories/settings/settings_repository.dart';

import 'package:chicpic/bloc/auth/auth_bloc.dart';
import 'package:chicpic/bloc/signup/signup_bloc.dart';
import 'package:chicpic/bloc/login/login_bloc.dart';
import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';
import 'package:chicpic/bloc/explore/shops/shops_explore_bloc.dart';
import 'package:chicpic/bloc/explore/products/products_explore_bloc.dart';
import 'package:chicpic/bloc/category/category_bloc.dart';
import 'package:chicpic/bloc/shop/shop_bloc.dart';
import 'package:chicpic/bloc/settings/settings_bloc.dart';

import 'app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final isProduction = dotenv.env['IS_PRODUCTION']?.toLowerCase() == 'true';

  await SentryFlutter.init(
    (options) {
      options.dsn = dotenv.env['SENTRY_DSN'];
      options.environment = isProduction ? 'production' : 'development';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => AuthRepository()),
          RepositoryProvider(create: (context) => SettingsRepository()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (BuildContext context) {
                final AuthRepository authRepository =
                    RepositoryProvider.of<AuthRepository>(context);
                return AuthBloc(authRepository)..add(AppLoaded());
              },
            ),
            BlocProvider<SignupBloc>(
              create: (BuildContext context) {
                final AuthRepository authRepository =
                    RepositoryProvider.of<AuthRepository>(context);
                return SignupBloc(authRepository);
              },
            ),
            BlocProvider<LoginBloc>(
              create: (BuildContext context) {
                final AuthRepository authRepository =
                    RepositoryProvider.of<AuthRepository>(context);
                return LoginBloc(authRepository);
              },
            ),
            BlocProvider<UserAdditionalBloc>(
              create: (BuildContext context) {
                final AuthRepository authRepository =
                    RepositoryProvider.of<AuthRepository>(context);
                final SettingsRepository settingsRepository =
                    RepositoryProvider.of<SettingsRepository>(context);
                return UserAdditionalBloc(authRepository, settingsRepository);
              },
            ),
            BlocProvider<ShopsExploreBloc>(
              create: (BuildContext context) {
                return ShopsExploreBloc();
              },
            ),
            BlocProvider<ProductsExploreBloc>(
              create: (BuildContext context) {
                final AuthRepository authRepository =
                    RepositoryProvider.of<AuthRepository>(context);
                final SettingsRepository settingsRepository =
                    RepositoryProvider.of<SettingsRepository>(context);
                return ProductsExploreBloc(authRepository, settingsRepository);
              },
            ),
            BlocProvider<CategoryBloc>(
              create: (BuildContext context) {
                final SettingsRepository settingsRepository =
                    RepositoryProvider.of<SettingsRepository>(context);
                return CategoryBloc(settingsRepository);
              },
            ),
            BlocProvider<ShopBloc>(
              create: (BuildContext context) {
                final SettingsRepository settingsRepository =
                    RepositoryProvider.of<SettingsRepository>(context);
                return ShopBloc(settingsRepository);
              },
            ),
            BlocProvider<SettingsBloc>(
              create: (BuildContext context) {
                final AuthRepository authRepository =
                    RepositoryProvider.of<AuthRepository>(context);
                final SettingsRepository settingsRepository =
                    RepositoryProvider.of<SettingsRepository>(context);
                return SettingsBloc(authRepository, settingsRepository);
              },
            ),
          ],
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String appName = '';

  setAppName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
    });
  }

  @override
  void initState() {
    setAppName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        fontFamily: 'Nunito',
        primarySwatch: CustomTheme.primaryColor,
        disabledColor: CustomTheme.disabledColor,
      ),
      initialRoute: AppRouter.splash,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
