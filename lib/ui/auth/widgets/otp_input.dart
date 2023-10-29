import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:chicpic/statics/insets.dart';

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  final void Function() onPaste;

  const OtpInput({
    required this.controller,
    this.autoFocus = false,
    required this.onPaste,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Insets.xSmall),
      child: SizedBox(
        height: 50,
        width: 40,
        child: TextField(
          autofocus: autoFocus,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: controller,
          maxLength: 1,
          cursorColor: Theme.of(context).primaryColor,
          decoration: const InputDecoration(
            isDense: true,
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
          contextMenuBuilder: (context, editableTextState) {
            return AdaptiveTextSelectionToolbar.editable(
              anchors: editableTextState.contextMenuAnchors,
              clipboardStatus: ClipboardStatus.pasteable,
              onPaste: onPaste,
              onCopy: null,
              onCut: null,
              onSelectAll: null,
            );
          },
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ),
    );
  }
}
