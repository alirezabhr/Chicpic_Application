import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/models/measurement_units.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/ui/user_additional/widgets/unit_switch.dart';
import 'package:chicpic/ui/user_additional/widgets/user_additional_base_form.dart';

class LegLengthForm extends StatefulWidget {
  final VoidCallback? backBtnOnPressed;
  final VoidCallback? continueBtnOnPressed;

  const LegLengthForm({
    Key? key,
    this.backBtnOnPressed,
    this.continueBtnOnPressed,
  }) : super(key: key);

  @override
  State<LegLengthForm> createState() => _LegLengthFormState();
}

class _LegLengthFormState extends State<LegLengthForm> {
  final TextEditingController _cmController = TextEditingController();
  final TextEditingController _inchController = TextEditingController();
  final TextEditingController _feetController = TextEditingController();
  late Length legLength;

  @override
  void initState() {
    super.initState();
    legLength = BlocProvider.of<UserAdditionalBloc>(context).legLength;
    _cmController.text = legLength.cmValue.toString();
    _feetController.text = legLength.feetValue.toString();
    _inchController.text = legLength.inchesValue.toString();
  }

  void setLegLength(Length userLegLength) {
    BlocProvider.of<UserAdditionalBloc>(context).legLength = userLegLength;
    setState(() {
      legLength = userLegLength;
    });
  }

  Widget get content => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          legLength.unit == LengthUnit.cm
              ? TextFormField(
                  controller: _cmController,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    labelText: 'Inside Leg (cm)',
                  ),
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  onChanged: (String? value) {
                    legLength.cmValue =
                        int.tryParse(value ?? '') ?? legLength.cmValue;
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
                          labelText: 'Inside Leg (ft)',
                        ),
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        onChanged: (String? value) {
                          legLength.feetValue =
                              int.tryParse(value ?? '') ?? legLength.feetValue;
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
                          labelText: 'Inside Leg (inches)',
                        ),
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        onChanged: (String? value) {
                          legLength.inchesValue = int.tryParse(value ?? '') ??
                              legLength.inchesValue;
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
            initialIndex: LengthUnit.values.indexOf(legLength.unit),
            itemTextBuilder: (LengthUnit unit) => unit.abbreviation,
            onChange: (LengthUnit unit) {
              setLegLength(legLength..convert(unit));

              if (unit == LengthUnit.cm) {
                _cmController.text = legLength.cmValue.toString();
              } else if (unit == LengthUnit.feetInches) {
                _feetController.text = legLength.feetValue.toString();
                _inchController.text = legLength.inchesValue.toString();
              }
            },
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return createUserAdditionalForm(
      context: context,
      title: 'Inside Leg:',
      content: content,
      continueBtnOnPressed: widget.continueBtnOnPressed,
      backBtnOnPressed: widget.backBtnOnPressed,
    );
  }
}
