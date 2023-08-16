import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/models/measurement_units.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/ui/user_additional/widgets/unit_switch.dart';
import 'package:chicpic/ui/user_additional/widgets/user_additional_base_form.dart';

class InseamForm extends StatefulWidget {
  final VoidCallback? backBtnOnPressed;
  final VoidCallback? continueBtnOnPressed;

  const InseamForm({
    Key? key,
    this.backBtnOnPressed,
    this.continueBtnOnPressed,
  }) : super(key: key);

  @override
  State<InseamForm> createState() => _InseamFormState();
}

class _InseamFormState extends State<InseamForm> {
  final TextEditingController _cmController = TextEditingController();
  final TextEditingController _inchController = TextEditingController();
  final TextEditingController _feetController = TextEditingController();
  late Length inseam;

  @override
  void initState() {
    super.initState();
    inseam = BlocProvider.of<UserAdditionalBloc>(context).inseam;
    _cmController.text = inseam.cmValue.toString();
    _feetController.text = inseam.feetValue.toString();
    _inchController.text = inseam.inchesValue.toString();
  }

  void setInseam(Length userInseam) {
    BlocProvider.of<UserAdditionalBloc>(context).inseam = userInseam;
    setState(() {
      inseam = userInseam;
    });
  }

  Widget get content => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          inseam.unit == LengthUnit.cm
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
                    inseam.cmValue =
                        int.tryParse(value ?? '') ?? inseam.cmValue;
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
                          inseam.feetValue =
                              int.tryParse(value ?? '') ?? inseam.feetValue;
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
                          inseam.inchesValue = int.tryParse(value ?? '') ??
                              inseam.inchesValue;
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
            initialIndex: LengthUnit.values.indexOf(inseam.unit),
            itemTextBuilder: (LengthUnit unit) => unit.abbreviation,
            onChange: (LengthUnit unit) {
              setInseam(inseam..convert(unit));

              if (unit == LengthUnit.cm) {
                _cmController.text = inseam.cmValue.toString();
              } else if (unit == LengthUnit.feetInches) {
                _feetController.text = inseam.feetValue.toString();
                _inchController.text = inseam.inchesValue.toString();
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
