import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/models/measurement_units.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/ui/user_additional/widgets/unit_switch.dart';
import 'package:chicpic/ui/user_additional/widgets/user_additional_base_form.dart';

class BustSizeForm extends StatefulWidget {
  final VoidCallback backBtnOnPressed;
  final VoidCallback continueBtnOnPressed;

  const BustSizeForm({
    Key? key,
    required this.backBtnOnPressed,
    required this.continueBtnOnPressed,
  }) : super(key: key);

  @override
  State<BustSizeForm> createState() => _BustSizeFormState();
}

class _BustSizeFormState extends State<BustSizeForm> {
  final TextEditingController _cmController = TextEditingController();
  final TextEditingController _inchController = TextEditingController();
  final TextEditingController _feetController = TextEditingController();
  late Length bustSize;

  @override
  void initState() {
    super.initState();
    bustSize = BlocProvider.of<UserAdditionalBloc>(context).bustSize;
    _cmController.text = bustSize.cmValue.toString();
    _feetController.text = bustSize.feetValue.toString();
    _inchController.text = bustSize.inchesValue.toString();
  }

  void setBustSize(Length userBustSize) {
    BlocProvider.of<UserAdditionalBloc>(context).bustSize = userBustSize;
    setState(() {
      bustSize = userBustSize;
    });
  }

  Widget get content => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          bustSize.unit == LengthUnit.cm
              ? TextFormField(
                  controller: _cmController,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    labelText: 'Bust Size (cm)',
                  ),
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  onChanged: (String? value) {
                    bustSize.cmValue =
                        int.tryParse(value ?? '') ?? bustSize.cmValue;
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
                          labelText: 'Bust Size (ft)',
                        ),
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        onChanged: (String? value) {
                          bustSize.feetValue =
                              int.tryParse(value ?? '') ?? bustSize.feetValue;
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
                          labelText: 'Bust Size (inches)',
                        ),
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        onChanged: (String? value) {
                          bustSize.inchesValue =
                              int.tryParse(value ?? '') ?? bustSize.inchesValue;
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
            initialIndex: LengthUnit.values.indexOf(bustSize.unit),
            itemTextBuilder: (LengthUnit unit) => unit.abbreviation,
            onChange: (LengthUnit unit) {
              setBustSize(bustSize..convert(unit));

              if (unit == LengthUnit.cm) {
                _cmController.text = bustSize.cmValue.toString();
              } else if (unit == LengthUnit.feetInches) {
                _feetController.text = bustSize.feetValue.toString();
                _inchController.text = bustSize.inchesValue.toString();
              }
            },
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return createUserAdditionalForm(
      context: context,
      title: 'Bust Size:',
      content: content,
      continueBtnOnPressed: widget.continueBtnOnPressed,
      backBtnOnPressed: widget.backBtnOnPressed,
    );
  }
}
