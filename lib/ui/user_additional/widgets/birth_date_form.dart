import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/ui/user_additional/widgets/user_additional_base_form.dart';

class BirthDateForm extends StatefulWidget {
  final VoidCallback backBtnOnPressed;
  final VoidCallback continueBtnOnPressed;

  const BirthDateForm({
    Key? key,
    required this.backBtnOnPressed,
    required this.continueBtnOnPressed,
  }) : super(key: key);

  @override
  State<BirthDateForm> createState() => _BirthDateFormState();
}

class _BirthDateFormState extends State<BirthDateForm> {
  final TextEditingController _controller = TextEditingController();
  DateTime? pickedDate;

  bool dateIsBefore({
    required String date,
    int yearsAgo = 0,
    int monthsAgo = 0,
    int daysAgo = 0,
  }) {
    DateTime today = DateTime.now();
    DateTime dateAgo = DateTime(
      today.year - yearsAgo,
      today.month - monthsAgo,
      today.day - daysAgo,
    );
    return DateTime.parse(date).isBefore(dateAgo);
  }

  @override
  void initState() {
    super.initState();
    pickedDate = BlocProvider.of<UserAdditionalBloc>(context).birthDate;
    _controller.text =
        DateFormat('yyyy-MM-dd').format(pickedDate ?? DateTime.now());
  }

  void setBirthDate(DateTime date) {
    BlocProvider.of<UserAdditionalBloc>(context).birthDate = date;
  }

  Widget get content => TextFormField(
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
          if (!dateIsBefore(date: value, yearsAgo: 10)) {
            return 'You must be at least 10 years old.';
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
            setBirthDate(pickedDate!);
            _controller.text = DateFormat('yyyy-MM-dd').format(pickedDate!);
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return createUserAdditionalForm(
      context: context,
      title: 'Birth Date:',
      content: content,
      continueBtnOnPressed: widget.continueBtnOnPressed,
      backBtnOnPressed: widget.backBtnOnPressed,
    );
  }
}
