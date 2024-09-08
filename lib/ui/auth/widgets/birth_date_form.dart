import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/auth/auth_bloc.dart';

class BirthDateForm extends StatefulWidget {
  const BirthDateForm({Key? key, required this.onSelectDate}) : super(key: key);
  final Function onSelectDate;

  @override
  State<BirthDateForm> createState() => _BirthDateFormState();
}

class _BirthDateFormState extends State<BirthDateForm> {
  final TextEditingController _controller = TextEditingController();
  DateTime? pickedDate;
  static const int minValidAge = 10; // years

  bool hasValidAge({required String date}) {
    DateTime today = DateTime.now();
    DateTime lastValidDate = DateTime(
      today.year - minValidAge,
      today.month,
      today.day,
    );
    return DateTime.parse(date).isBefore(lastValidDate);
  }

  @override
  void initState() {
    super.initState();
    pickedDate = BlocProvider.of<AuthBloc>(context).user?.birthdate;
    _controller.text =
        DateFormat('yyyy-MM-dd').format(pickedDate ?? DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: const InputDecoration(
        icon: Icon(Icons.calendar_today),
        labelText: "Enter Date",
      ),
      readOnly: true,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Birth date is required.';
        }
        if (!hasValidAge(date: value)) {
          return 'You must be at least $minValidAge years old.';
        }
        return null;
      },
      onTap: () async {
        pickedDate = await showDatePicker(
          context: context,
          initialDate: pickedDate ?? DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
        );

        if (pickedDate != null) {
          _controller.text = DateFormat('yyyy-MM-dd').format(pickedDate!);
          widget.onSelectDate(pickedDate!);
        }
      },
    );
  }
}
