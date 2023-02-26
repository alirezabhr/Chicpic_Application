import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';
import 'package:chicpic/statics/insets.dart';
import 'package:chicpic/ui/user_additional/widgets/user_additional_base_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoeSizeForm extends StatefulWidget {
  final VoidCallback? backBtnOnPressed;
  final VoidCallback? continueBtnOnPressed;

  const ShoeSizeForm({
    Key? key,
    this.backBtnOnPressed,
    this.continueBtnOnPressed,
  }) : super(key: key);

  @override
  State<ShoeSizeForm> createState() => _ShoeSizeFormState();
}

class _ShoeSizeFormState extends State<ShoeSizeForm> {
  final List<double> _shoeSizes = [5, 5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10];
  late double _selectedShoeSize;

  @override
  void initState() {
    super.initState();
    _selectedShoeSize =
        BlocProvider.of<UserAdditionalBloc>(context).shoeSize ?? 0;
  }

  Size get _deviceSize => MediaQuery.of(context).size;

  Widget get content => FormField(
        initialValue: _selectedShoeSize,
        validator: (val) {
          if (val == 0 || !_shoeSizes.any((element) => element == val)) {
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
              constraints: BoxConstraints(maxHeight: _deviceSize.height * 0.6),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: Insets.small,
                  crossAxisSpacing: Insets.xSmall,
                ),
                padding: const EdgeInsets.all(Insets.medium),
                shrinkWrap: true,
                children: _shoeSizes
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
                                color: e == _selectedShoeSize
                                    ? Colors.blueAccent
                                    : Colors.black12,
                                width: 2,
                              ),
                              borderRadius:
                                  BorderRadius.circular(4.0), //<-- SEE HERE
                            ),
                            child: Center(
                              child: Text(
                                e.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
      );

  @override
  Widget build(BuildContext context) {
    return createUserAdditionalForm(
      context: context,
      title: 'Shoe Size:',
      helper: '(US/CAN)',
      content: content,
      continueBtnOnPressed: widget.continueBtnOnPressed,
      backBtnOnPressed: widget.backBtnOnPressed,
    );
  }
}
