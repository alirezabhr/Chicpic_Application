import 'package:flutter/material.dart';

class ConnectionFailedDialog extends StatelessWidget {
  final Function retry;
  const ConnectionFailedDialog({Key? key, required this.retry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Connection Failed'),
      content: const Text(
          'Poor network connection detected. Please check your connectivity.'),
      actions: [
        TextButton(
          onPressed: () {
            retry();
            Navigator.of(context).pop();
          },
          child: const Text('Try again'),
        ),
      ],
    );
  }
}
