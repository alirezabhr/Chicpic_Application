import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/models/auth/trouser_fit.dart';

import 'package:chicpic/ui/user_additional/widgets/user_additional_base_form.dart';

class TrouserFitForm extends StatefulWidget {
  final VoidCallback? backBtnOnPressed;
  final VoidCallback? continueBtnOnPressed;

  const TrouserFitForm({
    Key? key,
    this.backBtnOnPressed,
    this.continueBtnOnPressed,
  }) : super(key: key);

  @override
  State<TrouserFitForm> createState() => _TrouserFitFormState();
}

class _TrouserFitFormState extends State<TrouserFitForm> {
  late List<TrouserFit> trouserFits;

  @override
  void initState() {
    super.initState();
    trouserFits = BlocProvider.of<UserAdditionalBloc>(context).trouserFits;
  }

  bool isSelectedItem(TrouserFitType trouserFitType) {
    return trouserFits.map((e) => e.fitType).contains(trouserFitType);
  }

  void addTrouserFitItem(TrouserFitType itemType) {
    BlocProvider.of<UserAdditionalBloc>(context)
        .trouserFits
        .add(TrouserFit(fitTypeAbbr: itemType.abbreviation));

    setState(() {
      trouserFits = BlocProvider.of<UserAdditionalBloc>(context).trouserFits;
    });
  }

  void removeTrouserFitItem(TrouserFitType itemType) {
    BlocProvider.of<UserAdditionalBloc>(context)
        .trouserFits
        .remove(TrouserFit(fitTypeAbbr: itemType.abbreviation));

    setState(() {
      trouserFits = BlocProvider.of<UserAdditionalBloc>(context).trouserFits;
    });
  }

  Size get _deviceSize => MediaQuery.of(context).size;

  Widget get content => ConstrainedBox(
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
      children: TrouserFitType.values
          .map((e) => GestureDetector(
        onTap: () {
          if (!isSelectedItem(e)) {
            addTrouserFitItem(e);
          } else {
            removeTrouserFitItem(e);
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
                      Image.asset(e.image, scale: 10),
                      const SizedBox(height: Insets.small),
                      Text(
                        e.humanReadable,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: createUserAdditionalForm(
        context: context,
        title: 'Which trouser fit do you prefer?',
        helper: '(Optional)',
        content: content,
        continueBtnOnPressed: widget.continueBtnOnPressed,
        backBtnOnPressed: widget.backBtnOnPressed,
      ),
    );
  }
}
