import 'package:flutter/material.dart';

import 'package:chicpic/ui/base_widgets/filter_dialog.dart';

class FilterButton extends StatelessWidget {
  final Color? iconColor;

  const FilterButton({Key? key, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.tune_rounded,
        color: iconColor ?? Theme.of(context).primaryColor,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const FilterDialog();
          },
        );
      },
    );
  }
}
