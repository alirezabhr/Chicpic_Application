import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/models/measurements/length.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/ui/user_additional/widgets/unit_switch.dart';
import 'package:chicpic/ui/user_additional/widgets/user_additional_base_form.dart';

class ShoulderSizeForm extends StatefulWidget {
  final VoidCallback? backBtnOnPressed;
  final VoidCallback? continueBtnOnPressed;

  const ShoulderSizeForm({
    Key? key,
    this.backBtnOnPressed,
    this.continueBtnOnPressed,
  }) : super(key: key);

  @override
  State<ShoulderSizeForm> createState() => _ShoulderSizeFormState();
}

class _ShoulderSizeFormState extends State<ShoulderSizeForm> {
  final TextEditingController _cmController = TextEditingController();
  final TextEditingController _inchController = TextEditingController();
  final TextEditingController _feetController = TextEditingController();
  late Length shoulderSize;

  @override
  void initState() {
    super.initState();
    shoulderSize = BlocProvider.of<UserAdditionalBloc>(context).shoulderSize;
    _cmController.text = shoulderSize.cmValue.toString();
    _feetController.text = shoulderSize.feetValue.toString();
    _inchController.text = shoulderSize.inchesValue.toString();
  }

  void setShoulderSize(Length userShoulderSize) {
    BlocProvider.of<UserAdditionalBloc>(context).shoulderSize = userShoulderSize;
    setState(() {
      shoulderSize = userShoulderSize;
    });
  }

  Widget get content => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          shoulderSize.unit == LengthUnit.cm
              ? TextFormField(
                  controller: _cmController,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    labelText: 'Shoulder Size (cm)',
                  ),
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  onChanged: (String? value) {
                    shoulderSize.cmValue =
                        int.tryParse(value ?? '') ?? shoulderSize.cmValue;
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
                          labelText: 'Shoulder Size (ft)',
                        ),
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        onChanged: (String? value) {
                          shoulderSize.feetValue =
                              int.tryParse(value ?? '') ?? shoulderSize.feetValue;
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
                          labelText: 'Shoulder Size (inches)',
                        ),
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        onChanged: (String? value) {
                          shoulderSize.inchesValue =
                              int.tryParse(value ?? '') ?? shoulderSize.inchesValue;
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
            initialIndex: LengthUnit.values.indexOf(shoulderSize.unit),
            itemTextBuilder: (LengthUnit unit) => unit.abbreviation,
            onChange: (LengthUnit unit) {
              setShoulderSize(shoulderSize..convert(unit));

              if (unit == LengthUnit.cm) {
                _cmController.text = shoulderSize.cmValue.toString();
              } else if (unit == LengthUnit.feetInches) {
                _feetController.text = shoulderSize.feetValue.toString();
                _inchController.text = shoulderSize.inchesValue.toString();
              }
            },
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return createUserAdditionalForm(
      context: context,
      title: 'Shoulder Size:',
      content: content,
      continueBtnOnPressed: widget.continueBtnOnPressed,
      backBtnOnPressed: widget.backBtnOnPressed,
    );
  }
}
