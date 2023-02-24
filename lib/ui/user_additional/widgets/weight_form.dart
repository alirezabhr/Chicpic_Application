import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/models/measurement_units.dart';

import 'package:chicpic/ui/user_additional/widgets/user_additional_base_form.dart';
import 'package:chicpic/ui/user_additional/widgets/unit_switch.dart';

class WeightForm extends StatefulWidget {
  final VoidCallback backBtnOnPressed;
  final VoidCallback continueBtnOnPressed;

  const WeightForm({
    Key? key,
    required this.backBtnOnPressed,
    required this.continueBtnOnPressed,
  }) : super(key: key);

  @override
  State<WeightForm> createState() => _WeightFormState();
}

class _WeightFormState extends State<WeightForm> {
  final TextEditingController _controller = TextEditingController();
  late Mass weight;

  @override
  void initState() {
    super.initState();
    weight = BlocProvider.of<UserAdditionalBloc>(context).weight;
    _controller.text = weight.value.toString();
  }

  Widget get content => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
              labelText: 'Weight',
            ),
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.number,
            onChanged: (String? value) {
              weight.value = int.tryParse(value ?? '') ?? weight.value;
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'This field is required.';
              }
              return null;
            },
          ),
          const SizedBox(height: Insets.xSmall),
          UnitSwitch<MassUnit>(
            items: MassUnit.values,
            initialIndex: MassUnit.values.indexOf(weight.unit),
            itemTextBuilder: (MassUnit unit) => unit.abbreviation,
            onChange: (MassUnit unit) {
              weight.convert(unit);
              _controller.text = weight.value.toString();
            },
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return createUserAdditionalForm(
      context: context,
      title: 'What do you weigh?',
      content: content,
      continueBtnOnPressed: widget.continueBtnOnPressed,
      backBtnOnPressed: widget.backBtnOnPressed,
    );
  }
}
