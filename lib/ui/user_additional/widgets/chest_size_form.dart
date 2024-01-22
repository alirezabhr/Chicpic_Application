import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/models/measurements/length.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/ui/user_additional/widgets/unit_switch.dart';

class ChestSizeForm extends StatefulWidget {
  const ChestSizeForm({Key? key}) : super(key: key);

  @override
  State<ChestSizeForm> createState() => _ChestSizeFormState();
}

class _ChestSizeFormState extends State<ChestSizeForm> {
  final TextEditingController _cmController = TextEditingController();
  final TextEditingController _inchController = TextEditingController();
  final TextEditingController _feetController = TextEditingController();
  late Length chestSize;

  @override
  void initState() {
    super.initState();
    final blocProvider = BlocProvider.of<UserAdditionalBloc>(context);
    chestSize = blocProvider.chestSize ?? DefaultUserAdditionalConfig.chestSize;
    _cmController.text = chestSize.cmValue.toString();
    _feetController.text = chestSize.feetValue.toString();
    _inchController.text = chestSize.inchesValue.toString();
  }

  void setChestSize(Length userChestSize) {
    BlocProvider.of<UserAdditionalBloc>(context).chestSize = userChestSize;
    setState(() {
      chestSize = userChestSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        chestSize.unit == LengthUnit.cm
            ? TextFormField(
                controller: _cmController,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Chest Size (cm)',
                ),
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.number,
                onChanged: (String? value) {
                  chestSize.cmValue =
                      int.tryParse(value ?? '') ?? chestSize.cmValue;
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
                        labelText: 'Chest Size (ft)',
                      ),
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.number,
                      onChanged: (String? value) {
                        chestSize.feetValue =
                            int.tryParse(value ?? '') ?? chestSize.feetValue;
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
                        labelText: 'Chest Size (inches)',
                      ),
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.number,
                      onChanged: (String? value) {
                        chestSize.inchesValue =
                            int.tryParse(value ?? '') ?? chestSize.inchesValue;
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
          initialIndex: LengthUnit.values.indexOf(chestSize.unit),
          itemTextBuilder: (LengthUnit unit) => unit.abbreviation,
          onChange: (LengthUnit unit) {
            setChestSize(chestSize..convert(unit));

            if (unit == LengthUnit.cm) {
              _cmController.text = chestSize.cmValue.toString();
            } else if (unit == LengthUnit.feetInches) {
              _feetController.text = chestSize.feetValue.toString();
              _inchController.text = chestSize.inchesValue.toString();
            }
          },
        ),
      ],
    );
  }
}
