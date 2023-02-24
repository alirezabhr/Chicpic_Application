import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/models/measurement_units.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/ui/user_additional/widgets/unit_switch.dart';
import 'package:chicpic/ui/user_additional/widgets/user_additional_base_form.dart';

class WaistSizeForm extends StatefulWidget {
  final VoidCallback backBtnOnPressed;
  final VoidCallback continueBtnOnPressed;

  const WaistSizeForm({
    Key? key,
    required this.backBtnOnPressed,
    required this.continueBtnOnPressed,
  }) : super(key: key);

  @override
  State<WaistSizeForm> createState() => _WaistSizeFormState();
}

class _WaistSizeFormState extends State<WaistSizeForm> {
  final TextEditingController _cmController = TextEditingController();
  final TextEditingController _inchController = TextEditingController();
  final TextEditingController _feetController = TextEditingController();
  late Length waistSize;

  @override
  void initState() {
    super.initState();
    waistSize = BlocProvider.of<UserAdditionalBloc>(context).waistSize;
    _cmController.text = waistSize.cmValue.toString();
    _feetController.text = waistSize.feetValue.toString();
    _inchController.text = waistSize.inchesValue.toString();
  }

  void setWaistSize(Length userWaistSize) {
    BlocProvider.of<UserAdditionalBloc>(context).waistSize = userWaistSize;
    setState(() {
      waistSize = userWaistSize;
    });
  }

  Widget get content => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      waistSize.unit == LengthUnit.cm
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
          waistSize.cmValue =
              int.tryParse(value ?? '') ?? waistSize.cmValue;
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
                waistSize.feetValue =
                    int.tryParse(value ?? '') ?? waistSize.feetValue;
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
                waistSize.inchesValue =
                    int.tryParse(value ?? '') ?? waistSize.inchesValue;
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
        initialIndex: LengthUnit.values.indexOf(waistSize.unit),
        itemTextBuilder: (LengthUnit unit) => unit.abbreviation,
        onChange: (LengthUnit unit) {
          setWaistSize(waistSize..convert(unit));

          if (unit == LengthUnit.cm) {
            _cmController.text = waistSize.cmValue.toString();
          } else if (unit == LengthUnit.feetInches) {
            _feetController.text = waistSize.feetValue.toString();
            _inchController.text = waistSize.inchesValue.toString();
          }
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return createUserAdditionalForm(
      context: context,
      title: 'Waist Size:',
      content: content,
      continueBtnOnPressed: widget.continueBtnOnPressed,
      backBtnOnPressed: widget.backBtnOnPressed,
    );
  }
}
