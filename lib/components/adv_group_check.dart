library group_check;

import 'dart:async';

import 'package:basic_components/components/adv_check_box.dart';
import 'package:basic_components/components/adv_column.dart';
import 'package:basic_components/components/adv_list_tile.dart';
import 'package:basic_components/components/component_theme.dart';
import 'package:basic_components/components/component_theme_data.dart';
import 'package:flutter/material.dart';

part 'adv_group_check_controller.dart';

typedef GroupCheckCallback = void Function(List<String> data);

class AdvGroupCheck extends StatefulWidget {
  final AdvGroupCheckController controller;
  final GroupCheckCallback callback;

  AdvGroupCheck(
      {String text,
      Map<String, Widget> items,
      AdvGroupCheckController controller,
      this.callback})
      : assert(controller == null || (text == null && items == null)),
        this.controller =
            controller ?? new AdvGroupCheckController(items: items ?? []);

  @override
  State<StatefulWidget> createState() => _AdvGroupCheckState();
}

class _AdvGroupCheckState extends State<AdvGroupCheck> {
  Timer _timer;

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
    ComponentThemeData componentTheme = ComponentTheme.of(context);

    for (int i = 0; i < widget.controller.items.length; i++) {
      AdvGroupCheckItem item = widget.controller.items[i];
      children.add(Container(
          child: AdvListTile(
              onTap: () {
//                if (this.mounted)
//                  setState(() {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  widget.controller.check = i;
//                  if (this.mounted)
//                    setState(() {
//                          Navigator.of(context).push(PageRouteBuilder(
//                              opaque: false,
//                              pageBuilder: (BuildContext context, _, __) {
//                                return Container();
//                              }));
                  if (_timer != null) {
                    _timer.cancel();
                  }
                  _timer = Timer(Duration(milliseconds: 3000), () {
                    _timer = null;
//                            Navigator.pop(context);
//                            if (widget.callback != null) widget.callback(itemKey);
                  });
//                        });
//                    });
                });
              },
              padding: EdgeInsets.all(16.0),
              expanded: item.display,
              end: AbsorbPointer(
                  child: AdvCheckbox(
                onChanged: (value) {},
                value: item.isChecked,
                radius: Radius.circular(AdvCheckbox.width / 4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: componentTheme.groupCheck.checkColor,
              )))));
    }

    return WillPopScope(
      onWillPop: () async {
        return _timer == null;
      },
      child: Container(
        child: AdvColumn(
            divider: Container(
              height: 1.0,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              color: Theme.of(context).dividerColor,
            ),
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
