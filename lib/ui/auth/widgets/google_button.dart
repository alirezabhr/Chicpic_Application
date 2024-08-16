import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:chicpic/services/snack_bar.dart';

import 'package:chicpic/statics/assets_helper.dart';

import 'package:chicpic/statics/insets.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 3 / 5,
      child: OutlinedButton(
        onPressed: () async {
          print('before google sign in click');
          const List<String> scopes = <String>[
            'https://www.googleapis.com/auth/userinfo.email',
            'https://www.googleapis.com/auth/userinfo.profile',
            'openid',
          ];

          late final GoogleSignIn googleSignIn;

          if (Platform.isIOS) {
            googleSignIn = GoogleSignIn(
              clientId: '138232992687-nof5ag56aiiauuuqo3v9o74u5n6l5g13.apps.googleusercontent.com',
              scopes: scopes,
            );
          } else { // for Android devices
            googleSignIn = GoogleSignIn(scopes: scopes);
          }

          if (await googleSignIn.isSignedIn()) {
            googleSignIn.signOut();
            print('<<<<< Google Sign OUT >>>>>');
          }

          print('after google sign in object creation');
          GoogleSignInAccount? googleUser;
          try {
             googleUser = await googleSignIn.signIn();
          } catch (error) {
            print('Google Sign In Error: $error');
            showSnackBar(context, 'Google Sign In Error', SnackBarStatus.error);
            return;
          }
          print('googleUser: $googleUser');
          if (googleUser == null) {
            print('Google Sign In Cancelled');
            showSnackBar(context, 'Google Sign In Cancelled', SnackBarStatus.error);
            return;
          }
          print('before google authentication');
          GoogleSignInAuthentication googleAuth = await googleUser.authentication;
          print('Google Auth access token: ${googleAuth.accessToken}');
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
              const Text(
                'Continue with Google',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
