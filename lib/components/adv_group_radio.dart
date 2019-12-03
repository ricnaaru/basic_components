library group_radio;

import 'dart:async';

import 'package:basic_components/basic_components.dart';
import 'package:basic_components/components/adv_check_box.dart';
import 'package:basic_components/components/adv_column.dart';
import 'package:basic_components/components/adv_list_tile.dart';
import 'package:flutter/material.dart';

part 'adv_group_radio_controller.dart';

typedef GroupRadioCallback = void Function(String data);

class AdvGroupRadio extends StatefulWidget {
  final AdvGroupRadioController controller;
  final GroupRadioCallback callback;

  AdvGroupRadio(
      {String text,
      Map<String, Widget> items,
      AdvGroupRadioController controller,
      this.callback})
      : assert(controller == null || (text == null && items == null)),
        this.controller = controller ??
            new AdvGroupRadioController(text: text ?? "", items: items ?? {});

  @override
  State<StatefulWidget> createState() => _AdvGroupRadioState();
}

class _AdvGroupRadioState extends State<AdvGroupRadio> {
  @override
  void initState() {
    widget.controller.addListener(() {
      if (this.mounted) {
        setState(() {});
      }
    });

    super.initState();
  }

  bool _text = true;

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> stringChildren = widget.controller.items;
    List<Widget> children = [];

    if (stringChildren != null)
      stringChildren.keys.forEach((itemKey) {
        children.add(Container(
            child: AdvListTile(
                onTap: () {
                  _text = false;
                  widget.controller.text = itemKey;

                  if (this.mounted)
                    setState(() {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (this.mounted)
                          setState(() {
                            _text = true;
                          });
                      });
                    });
                },
                padding: EdgeInsets.all(16.0),
                expanded: stringChildren[itemKey],
                end: itemKey == widget.controller.text
                    ? AbsorbPointer(
                        child: AdvCheckbox(
                        onChanged: (value) {},
                        value: _text,
                        radius: Radius.circular(AdvCheckbox.width),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: BasicComponents.groupRadio.checkColor,
                      ))
                    : Container())));
      });

    return Container(
      child: AdvColumn(
          divider: Container(
            height: 1.0,
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            color: Theme.of(context).dividerColor,
          ),
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children),
    );
  }
}
