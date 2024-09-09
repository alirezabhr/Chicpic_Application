import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/models/auth/shirt_fit.dart';

class ShirtFitForm extends StatefulWidget {
  const ShirtFitForm({Key? key}) : super(key: key);

  @override
  State<ShirtFitForm> createState() => _ShirtFitFormState();
}

class _ShirtFitFormState extends State<ShirtFitForm> {
  late List<ShirtFit> shirtFits;

  @override
  void initState() {
    super.initState();
    shirtFits = BlocProvider.of<UserAdditionalBloc>(context).shirtFits;
  }

  bool isSelectedItem(ShirtFitType shirtFitType) {
    return shirtFits.map((e) => e.fitType).contains(shirtFitType);
  }

  void addShirtFitItem(ShirtFitType itemType) {
    BlocProvider.of<UserAdditionalBloc>(context)
        .shirtFits
        .add(ShirtFit(fitTypeAbbr: itemType.abbreviation));

    setState(() {
      shirtFits = BlocProvider.of<UserAdditionalBloc>(context).shirtFits;
    });
  }

  void removeShirtFitItem(ShirtFitType itemType) {
    BlocProvider.of<UserAdditionalBloc>(context)
        .shirtFits
        .remove(ShirtFit(fitTypeAbbr: itemType.abbreviation));

    setState(() {
      shirtFits = BlocProvider.of<UserAdditionalBloc>(context).shirtFits;
    });
  }

  Size get _deviceSize => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: _deviceSize.height * 0.6),
      child: GridView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: Insets.xSmall / 2,
          mainAxisSpacing: Insets.xSmall / 2,
          childAspectRatio: 5 / 6,
        ),
        children: ShirtFitType.values
            .map((e) => GestureDetector(
                  onTap: () {
                    if (!isSelectedItem(e)) {
                      addShirtFitItem(e);
                    } else {
                      removeShirtFitItem(e);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: isSelectedItem(e)
                            ? Colors.blueAccent
                            : Colors.black38,
                        width: isSelectedItem(e) ? 2 : 1,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(Insets.xSmall / 2),
                      ),
                    ),
                    child: Stack(
                      children: [
                        isSelectedItem(e)
                            ? const Positioned(
                                right: 5,
                                top: 5,
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.blueAccent,
                                  size: 26,
                                ),
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.all(Insets.small),
                          child: Center(
                            child: Column(
                              children: [
                                Flexible(child: Image.asset(e.image, scale: 10)),
                                const SizedBox(height: Insets.small),
                                FittedBox(
                                  child: Text(
                                    e.humanReadable,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
