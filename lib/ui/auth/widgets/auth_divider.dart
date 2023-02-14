import 'package:flutter/material.dart';

import 'package:chicpic/statics/insets.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Insets.medium),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 3 / 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Expanded(
              child: Divider(
                thickness: 1,
                color: Colors.black26,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.xSmall),
              child: Text(
                'Or continue with',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 1,
                color: Colors.black26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
