import 'package:flutter/material.dart';
import 'package:chicpic/statics/insets.dart';

class UnitSwitch<T> extends StatefulWidget {
  final List<T> items;
  final int initialIndex;
  final String Function(T) itemTextBuilder;
  final void Function(T unit) onChange;

  const UnitSwitch({
    Key? key,
    required this.items,
    required this.initialIndex,
    required this.itemTextBuilder,
    required this.onChange,
  }) : super(key: key);

  @override
  State<UnitSwitch<T>> createState() => _UnitSwitchState<T>();
}

class _UnitSwitchState<T> extends State<UnitSwitch<T>> {
  final double itemHeight = 20;
  final double itemWidth = 30;
  late T currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.items[widget.initialIndex];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: itemWidth * widget.items.length,
      height: itemHeight,
      child: ClipRRect(
        borderRadius:
            const BorderRadius.all(Radius.circular(Insets.xSmall / 2)),
        child: Row(
          children: widget.items
              .map((T e) => GestureDetector(
                    onTap: () {
                      setState(() {
                        currentValue = e;
                      });
                      widget.onChange(e);
                    },
                    child: Container(
                      color: currentValue == e
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      width: itemWidth,
                      height: itemHeight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Center(
                          child: Text(
                            widget.itemTextBuilder(e),
                            style: TextStyle(
                              color: currentValue == e
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
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
  }
}
