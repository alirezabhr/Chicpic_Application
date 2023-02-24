import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/models/measurement_units.dart';

import 'package:chicpic/ui/user_additional/widgets/user_additional_base_form.dart';
import 'package:chicpic/ui/user_additional/widgets/unit_switch.dart';

class HeightForm extends StatefulWidget {
  final VoidCallback backBtnOnPressed;
  final VoidCallback continueBtnOnPressed;

  const HeightForm({
    Key? key,
    required this.backBtnOnPressed,
    required this.continueBtnOnPressed,
  }) : super(key: key);

  @override
  State<HeightForm> createState() => _HeightFormState();
}

class _HeightFormState extends State<HeightForm> {
  final TextEditingController _cmController = TextEditingController();
  final TextEditingController _inchController = TextEditingController();
  final TextEditingController _feetController = TextEditingController();
  late Length height;

  @override
  void initState() {
    super.initState();
    height = BlocProvider.of<UserAdditionalBloc>(context).height;
    _cmController.text = height.cmValue.toString();
    _feetController.text = height.feetValue.toString();
    _inchController.text = height.inchesValue.toString();
  }

  void setHeight(Length userHeight) {
    BlocProvider.of<UserAdditionalBloc>(context).height = userHeight;
    setState(() {
      height = userHeight;
    });
  }

  Widget get content => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          height.unit == LengthUnit.cm
              ? TextFormField(
                  controller: _cmController,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    labelText: 'Height (cm)',
                  ),
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  onChanged: (String? value) {
                    height.cmValue =
                        int.tryParse(value ?? '') ?? height.cmValue;
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required.';
                    }
                    return null;
                  },
                )
              : Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _feetController,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          labelText: 'Height (ft)',
                        ),
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        onChanged: (String? value) {
                          height.feetValue =
                              int.tryParse(value ?? '') ?? height.feetValue;
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: Insets.large),
                    Expanded(
                      child: TextFormField(
                        controller: _inchController,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          labelText: 'Height (inches)',
                        ),
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        onChanged: (String? value) {
                          height.inchesValue =
                              int.tryParse(value ?? '') ?? height.inchesValue;
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: Insets.xSmall),
          UnitSwitch<LengthUnit>(
            items: LengthUnit.values,
            initialIndex: LengthUnit.values.indexOf(height.unit),
            itemTextBuilder: (LengthUnit unit) => unit.abbreviation,
            onChange: (LengthUnit unit) {
              setHeight(height..convert(unit));

              if (unit == LengthUnit.cm) {
                _cmController.text = height.cmValue.toString();
              } else if (unit == LengthUnit.feetInches) {
                _feetController.text = height.feetValue.toString();
                _inchController.text = height.inchesValue.toString();
              }
            },
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return createUserAdditionalForm(
      context: context,
      title: 'How tall are you?',
      content: content,
      continueBtnOnPressed: widget.continueBtnOnPressed,
      backBtnOnPressed: widget.backBtnOnPressed,
    );
  }
}
