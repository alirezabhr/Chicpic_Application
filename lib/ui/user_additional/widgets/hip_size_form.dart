import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/models/measurement_units.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/ui/user_additional/widgets/unit_switch.dart';
import 'package:chicpic/ui/user_additional/widgets/user_additional_base_form.dart';

class HipSizeForm extends StatefulWidget {
  final VoidCallback? backBtnOnPressed;
  final VoidCallback? continueBtnOnPressed;

  const HipSizeForm({
    Key? key,
    this.backBtnOnPressed,
    this.continueBtnOnPressed,
  }) : super(key: key);

  @override
  State<HipSizeForm> createState() => _HipSizeFormState();
}

class _HipSizeFormState extends State<HipSizeForm> {
  final TextEditingController _cmController = TextEditingController();
  final TextEditingController _inchController = TextEditingController();
  final TextEditingController _feetController = TextEditingController();
  late Length hipSize;

  @override
  void initState() {
    super.initState();
    hipSize = BlocProvider.of<UserAdditionalBloc>(context).hipSize;
    _cmController.text = hipSize.cmValue.toString();
    _feetController.text = hipSize.feetValue.toString();
    _inchController.text = hipSize.inchesValue.toString();
  }

  void setHipSize(Length userHipSize) {
    BlocProvider.of<UserAdditionalBloc>(context).hipSize = userHipSize;
    setState(() {
      hipSize = userHipSize;
    });
  }

  Widget get content => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      hipSize.unit == LengthUnit.cm
          ? TextFormField(
        controller: _cmController,
        decoration: const InputDecoration(
          isDense: true,
          border: OutlineInputBorder(),
          labelText: 'Hip Size (cm)',
        ),
        enableSuggestions: false,
        autocorrect: false,
        keyboardType: TextInputType.number,
        onChanged: (String? value) {
          hipSize.cmValue =
              int.tryParse(value ?? '') ?? hipSize.cmValue;
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
                labelText: 'Hip Size (ft)',
              ),
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.number,
              onChanged: (String? value) {
                hipSize.feetValue =
                    int.tryParse(value ?? '') ?? hipSize.feetValue;
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
                labelText: 'Hip Size (inches)',
              ),
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.number,
              onChanged: (String? value) {
                hipSize.inchesValue =
                    int.tryParse(value ?? '') ?? hipSize.inchesValue;
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
        initialIndex: LengthUnit.values.indexOf(hipSize.unit),
        itemTextBuilder: (LengthUnit unit) => unit.abbreviation,
        onChange: (LengthUnit unit) {
          setHipSize(hipSize..convert(unit));

          if (unit == LengthUnit.cm) {
            _cmController.text = hipSize.cmValue.toString();
          } else if (unit == LengthUnit.feetInches) {
            _feetController.text = hipSize.feetValue.toString();
            _inchController.text = hipSize.inchesValue.toString();
          }
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return createUserAdditionalForm(
      context: context,
      title: 'Hip Size:',
      content: content,
      continueBtnOnPressed: widget.continueBtnOnPressed,
      backBtnOnPressed: widget.backBtnOnPressed,
    );
  }
}
