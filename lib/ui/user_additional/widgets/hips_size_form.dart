import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/models/measurements/length.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/ui/user_additional/widgets/unit_switch.dart';

class HipsSizeForm extends StatefulWidget {
  const HipsSizeForm({Key? key}) : super(key: key);

  @override
  State<HipsSizeForm> createState() => _HipsSizeFormState();
}

class _HipsSizeFormState extends State<HipsSizeForm> {
  final TextEditingController _cmController = TextEditingController();
  final TextEditingController _inchController = TextEditingController();
  final TextEditingController _feetController = TextEditingController();
  late Length hipsSize;

  @override
  void initState() {
    super.initState();
    hipsSize = BlocProvider.of<UserAdditionalBloc>(context).hipsSize;
    _cmController.text = hipsSize.cmValue.toString();
    _feetController.text = hipsSize.feetValue.toString();
    _inchController.text = hipsSize.inchesValue.toString();
  }

  void setHipsSize(Length userHipsSize) {
    BlocProvider.of<UserAdditionalBloc>(context).hipsSize = userHipsSize;
    setState(() {
      hipsSize = userHipsSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        hipsSize.unit == LengthUnit.cm
            ? TextFormField(
                controller: _cmController,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Hips Size (cm)',
                ),
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.number,
                onChanged: (String? value) {
                  hipsSize.cmValue =
                      int.tryParse(value ?? '') ?? hipsSize.cmValue;
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
                        labelText: 'Hips Size (ft)',
                      ),
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.number,
                      onChanged: (String? value) {
                        hipsSize.feetValue =
                            int.tryParse(value ?? '') ?? hipsSize.feetValue;
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
                        labelText: 'Hips Size (inches)',
                      ),
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.number,
                      onChanged: (String? value) {
                        hipsSize.inchesValue =
                            int.tryParse(value ?? '') ?? hipsSize.inchesValue;
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
          initialIndex: LengthUnit.values.indexOf(hipsSize.unit),
          itemTextBuilder: (LengthUnit unit) => unit.abbreviation,
          onChange: (LengthUnit unit) {
            setHipsSize(hipsSize..convert(unit));

            if (unit == LengthUnit.cm) {
              _cmController.text = hipsSize.cmValue.toString();
            } else if (unit == LengthUnit.feetInches) {
              _feetController.text = hipsSize.feetValue.toString();
              _inchController.text = hipsSize.inchesValue.toString();
            }
          },
        ),
      ],
    );
  }
}
