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
            // TODO: implement Google Sign In for iOS
            // googleSignIn = GoogleSignIn(
            //   clientId: '737870681288-upalmohfmb4utfgj1609mi144l066rdo.apps.googleusercontent.com',
            //   scopes: [
            //     'email',
            //   ],
            // );
          } else { // for Android devices
            googleSignIn = GoogleSignIn(scopes: scopes);
          }

          if (await googleSignIn.isSignedIn()) {
            googleSignIn.signOut();
            print('<<<<< Google Sign OUT >>>>>');
          }

          print('after google sign in');
          GoogleSignInAccount? googleUser;
          try {
             googleUser = await googleSignIn.signIn();
          } catch (error) {
            print('Google Sign In Error: $error');
            showSnackBar(context, 'Google Sign In Failed', SnackBarStatus.error);
            return;
          }
          print('after google user');
          print(googleUser);
          if (googleUser != null) {
            print('before google authentication');
            GoogleSignInAuthentication googleAuth = await googleUser.authentication;
            print('Google Auth access token: ${googleAuth.accessToken}');
          } else {
            print('Google Sign In Failed');
            showSnackBar(context, 'Google Sign In Failed', SnackBarStatus.error);
            return;
          }
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
