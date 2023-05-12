import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/statics/theme.dart';

import 'package:chicpic/repositories/auth/auth_repository.dart';

import 'package:chicpic/bloc/auth/auth_bloc.dart';
import 'package:chicpic/bloc/signup/signup_bloc.dart';
import 'package:chicpic/bloc/login/login_bloc.dart';
import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';
import 'package:chicpic/bloc/explore/shops/shops_explore_bloc.dart';
import 'package:chicpic/bloc/explore/products/products_explore_bloc.dart';
import 'package:chicpic/bloc/category/category_bloc.dart';

import 'app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
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
              return UserAdditionalBloc(authRepository);
            },
          ),
          BlocProvider<ShopsExploreBloc>(
            create: (BuildContext context) {
              return ShopsExploreBloc();
            },
          ),
          BlocProvider<ProductsExploreBloc>(
            create: (BuildContext context) {
              return ProductsExploreBloc();
            },
          ),
          BlocProvider<CategoryBloc>(
            create: (BuildContext context) {
              return CategoryBloc();
            },
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chicpic',
      theme: ThemeData(
        fontFamily: 'Nunito',
        primarySwatch: CustomTheme.primaryColor,
      ),
      initialRoute: AppRouter.splash,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
