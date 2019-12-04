library group_check;

import 'dart:async';

import 'package:basic_components/basic_components.dart';
import 'package:basic_components/components/adv_check_box.dart';
import 'package:basic_components/components/adv_column.dart';
import 'package:basic_components/components/adv_list_tile.dart';
import 'package:flutter/material.dart';

part 'adv_group_check_controller.dart';

typedef GroupCheckCallback = void Function(List<String> data);

class AdvGroupCheck extends StatefulWidget {
  final AdvGroupCheckController controller;
  final GroupCheckCallback callback;
  final bool prefixCheckbox;

  AdvGroupCheck(
      {String text,
      List<AdvGroupCheckItem> items,
      AdvGroupCheckController controller,
      this.callback,
      this.prefixCheckbox})
      : assert(controller == null || (text == null && items == null)),
        this.controller =
            controller ?? new AdvGroupCheckController(items: items ?? []);

  @override
  State<StatefulWidget> createState() => _AdvGroupCheckState();
}

class _AdvGroupCheckState extends State<AdvGroupCheck> {
  @override
  void initState() {
    widget.controller.addListener(() {
      if (this.mounted) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    for (int i = 0; i < widget.controller.items.length; i++) {
      AdvGroupCheckItem item = widget.controller.items[i];

      Widget checkbox = AbsorbPointer(
          child: AdvCheckbox(
        onChanged: (value) {},
        value: item.isChecked,
        radius: Radius.circular(AdvCheckbox.width / 4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        activeColor: BasicComponents.groupCheck.checkColor,
      ));

      children.add(Container(
          child: AdvListTile(
              onTap: () {
                widget.controller.check = i;
                if (this.mounted)
//                if (this.mounted)
//                  setState(() {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
//                  if (this.mounted)
//                    setState(() {
//                          Navigator.of(context).push(PageRouteBuilder(
//                              opaque: false,
//                              pageBuilder: (BuildContext context, _, __) {
//                                return Container();
//                              }));
//                            Navigator.pop(context);
                    if (widget.callback != null)
                      widget.callback(widget.controller.items
                          .where((item) => item.isChecked)
                          .map((item) => item.value)
                          .toList());
//                        });
//                    });
                  });
              },
              padding: EdgeInsets.all(16.0),
              expanded: item.display,
              start: (widget.prefixCheckbox ?? false) ? checkbox : null,
              end: (widget.prefixCheckbox ?? false) ? null : checkbox)));
    }

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

  @override
  void dispose() {
    super.dispose();
  }
}
