import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/models/auth/gender_choices.dart';
import 'package:chicpic/models/measurements/shoe_size.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/ui/user_additional/widgets/unit_switch.dart';

class ShoeSizeForm extends StatefulWidget {
  const ShoeSizeForm({Key? key}) : super(key: key);

  @override
  State<ShoeSizeForm> createState() => _ShoeSizeFormState();
}

class _ShoeSizeFormState extends State<ShoeSizeForm> {
  late ShoeSize _selectedShoeSize;
  late GenderChoices gender;

  @override
  void initState() {
    super.initState();
    _selectedShoeSize = BlocProvider.of<UserAdditionalBloc>(context).shoeSize;
    gender = BlocProvider.of<UserAdditionalBloc>(context).gender;
  }

  Size get _deviceSize => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        FormField(
          initialValue: _selectedShoeSize,
          validator: (selectedItem) {
            if (!getShoeSizes(gender, _selectedShoeSize.standard)
                .any((element) => element.value == selectedItem?.value)) {
              return 'Select your shoe size.';
            }
            return null;
          },
          builder: (FormFieldState<dynamic> field) {
            return InputDecorator(
              decoration: InputDecoration(
                border: InputBorder.none,
                errorText: field.errorText,
              ),
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxHeight: _deviceSize.height * 0.6),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: screenWidth > 360 ? 6 : 5,
                    mainAxisSpacing: Insets.small,
                    crossAxisSpacing: Insets.xSmall,
                  ),
                  padding: const EdgeInsets.all(Insets.medium),
                  shrinkWrap: true,
                  children: getShoeSizes(gender, _selectedShoeSize.standard)
                      .map((e) => GestureDetector(
                            onTap: () {
                              BlocProvider.of<UserAdditionalBloc>(context)
                                  .shoeSize = e;
                              setState(() {
                                _selectedShoeSize = e;
                              });
                              field.didChange(e);
                            },
                            child: Card(
                              margin: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: e.value == _selectedShoeSize.value
                                      ? Colors.blueAccent
                                      : Colors.black12,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(Insets.xSmall/2),
                                  child: FittedBox(
                                    child: Text(
                                      e.value.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            );
          },
        ),
        UnitSwitch<ShoeSizeStandard>(
          items: ShoeSizeStandard.values,
          initialIndex: ShoeSizeStandard.values.indexOf(
            _selectedShoeSize.standard,
          ),
          itemTextBuilder: (ShoeSizeStandard standard) => standard.abbreviation,
          onChange: (ShoeSizeStandard standard) {
            setState(() {
              _selectedShoeSize.convert(standard);
            });
          },
        ),
      ],
    );
  }
}
