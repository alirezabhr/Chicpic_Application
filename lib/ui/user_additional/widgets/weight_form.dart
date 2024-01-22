import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/models/measurements/mass.dart';

import 'package:chicpic/ui/user_additional/widgets/unit_switch.dart';

class WeightForm extends StatefulWidget {
  const WeightForm({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Column(
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
  }
}
