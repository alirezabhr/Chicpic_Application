import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/bloc/auth/auth_bloc.dart';

import 'package:chicpic/ui/base_widgets/custom_text_icon_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Insets.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi ${BlocProvider.of<AuthBloc>(context).user!.username} 👋',
              style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: Insets.xLarge),
            CustomTextIconButton(
              text: 'Body Size & Fit',
              onPressed: () {
                Navigator.of(context).pushNamed(AppRouter.userAdditional);
              },
              icon: FontAwesomeIcons.shirt,
            ),
            CustomTextIconButton(
              text: 'Saved Items',
              onPressed: () {
                Navigator.of(context).pushNamed(AppRouter.savedVariants);
              },
              icon: FontAwesomeIcons.solidBookmark,
            ),
            CustomTextIconButton(
              text: 'Account Settings',
              onPressed: () {
                Navigator.of(context).pushNamed(AppRouter.accountSettings);
              },
              icon: FontAwesomeIcons.gear,
            ),
            const Spacer(),
            CustomTextIconButton(
              text: 'Logout',
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(AuthLogout());
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRouter.login,
                  (Route<dynamic> route) => false,
                );
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
