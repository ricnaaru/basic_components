library adv_chooser;

import 'package:basic_components/components/adv_group_radio.dart';
import 'package:basic_components/components/adv_list_tile.dart';
import 'package:basic_components/components/component_theme.dart';
import 'package:basic_components/components/component_theme_data.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

part 'adv_chooser_controller.dart';
part 'adv_chooser_page.dart';

enum IntentType { bottomSheet, page }

class AdvChooser extends StatefulWidget {
  final Key key;
  final String text;
  final Map<String, String> items;
  final AdvChooserController controller;
  final FocusNode focusNode;
  final InputDecoration decoration;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final TextDirection textDirection;
  final ToolbarOptions toolbarOptions;
  final bool showCursor;
  final bool autofocus;
  final int maxLines;
  final int minLines;
  final bool expands;
  final int maxLength;
  final bool maxLengthEnforced;
  final ValueChanged<String> onChanged;
  final bool enabled;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final DragStartBehavior dragStartBehavior;
  final bool enableInteractiveSelection;
  final InputCounterWidgetBuilder buildCounter;
  final ScrollController scrollController;
  final ScrollPhysics scrollPhysics;
  final IntentType intentType;

  AdvChooser({
    this.key,
    this.text,
    this.items,
    this.controller,
    this.focusNode,
    this.decoration,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.toolbarOptions,
    this.showCursor,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforced = true,
    this.onChanged,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
    IntentType intentType,
  })  : this.intentType = intentType ?? IntentType.page,
        assert(controller == null ||
            (text == null &&
                items == null &&
                decoration?.errorText == null &&
                enabled == null));

  @override
  _AdvChooserState createState() => _AdvChooserState();

  static Future<String> chooseFromBottomSheet(
    BuildContext context, {
    String title = "",
    Map<String, String> items,
    String currentItem = "",
  }) async {
    assert(items != null);

    Map<String, Widget> groupRadioItems = items.map((key, value) {
      return MapEntry(key, Text(value));
    });

    AdvGroupRadioController controller =
        AdvGroupRadioController(text: currentItem, items: groupRadioItems);

    return await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AdvListTile(
                padding: EdgeInsets.all(16.0),
                start: Icon(Icons.close),
                expanded: Text(title,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Container(height: 2.0, color: Theme.of(context).dividerColor),
              Flexible(
                child: SingleChildScrollView(
                  child: AdvGroupRadio(
                    controller: controller,
                    callback: (itemSelected) async {
                      Navigator.of(context).pop(itemSelected);
                    },
                  ),
                ),
              ),
            ],
          );
        });
  }

  static Future<String> chooseFromPage(
    BuildContext context, {
    String title = "",
    Map<String, String> items,
    String currentItem = "",
  }) async {
    assert(items != null);

    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdvChooserPage(
                  title: title,
                  items: items,
                  currentItem: currentItem,
                )));
  }
}

class _AdvChooserState extends State<AdvChooser> {
  AdvChooserController get _effectiveController => widget.controller ?? _ctrl;

  AdvChooserController _ctrl;

  @override
  void initState() {
    super.initState();

    _ctrl = widget.controller == null
        ? AdvChooserController(
            text: widget.text ?? "",
            items: widget.items,
            error: widget.decoration?.errorText,
            enabled: widget.enabled ?? true,
          )
        : null;

    _effectiveController.addListener(_update);
  }

  _update() {
    if (this.mounted) setState(() {});
  }

  @override
  void didUpdateWidget(AdvChooser oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null)
      _ctrl = AdvChooserController.fromValue(oldWidget.controller.value);
    else if (widget.controller != null && oldWidget.controller == null)
      _ctrl = null;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingCtrl = new TextEditingController(
        text: _effectiveController.items == null
            ? ""
            : _effectiveController.items[_effectiveController.text]);

    textEditingCtrl.addListener(() {
      _effectiveController.removeListener(_update);
      _effectiveController.text = textEditingCtrl.text;
      _effectiveController.addListener(_update);
    });

    InputDecoration decoration = widget.decoration ?? InputDecoration();
    ThemeData themeData = Theme.of(context);
    double fontSize =
        (widget.style?.fontSize ?? themeData.textTheme.subhead.fontSize);
    double iconSize = fontSize / 14.0 * 30.0;
    double paddingSize = fontSize / 14.0 * 0.0;
    double rightContentPadding =
        iconSize + (paddingSize * 1); //fontSize / 14.0 * 38.0;

    TextField textField = TextField(
      key: widget.key,
      controller: textEditingCtrl,
      focusNode: widget.focusNode,
      decoration: decoration.copyWith(
        errorText: _effectiveController.error,
        contentPadding: EdgeInsets.only(
          top: 12.0,
          bottom: 8.0,
          right: rightContentPadding,
        ),
      ),
      style: widget.style,
      strutStyle: StrutStyle(height: 1.4),
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textDirection: widget.textDirection,
      readOnly: true,
      toolbarOptions: widget.toolbarOptions,
      showCursor: widget.showCursor,
      autofocus: widget.autofocus,
      obscureText: _effectiveController.obscureText,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      maxLength: widget.maxLength,
      maxLengthEnforced: widget.maxLengthEnforced,
      onChanged: widget.onChanged,
      enabled: _effectiveController.enabled,
      cursorWidth: widget.cursorWidth,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      dragStartBehavior: widget.dragStartBehavior,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      onTap: _onTap,
      buildCounter: widget.buildCounter,
      scrollController: widget.scrollController,
      scrollPhysics: widget.scrollPhysics,
    );

    ComponentThemeData componentTheme = ComponentTheme.of(context);

    return Stack(
      children: [
        textField,
        Positioned(
            right: 0.0,
            top: 0.0,
            bottom: 0.0,
            child: IgnorePointer(
              child: Container(
//            alignment: Alignment.topCenter,
//            color: Colors.amber,
                  width: iconSize + (paddingSize * 1),
                  height: iconSize + (paddingSize * 2),
                  padding: EdgeInsets.all(paddingSize).copyWith(right: 0.0),
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: iconSize,
                    color: componentTheme.chooser.iconColor,
                  )),
            )),
      ],
    );
  }

  void _onTap() {
    if (!_effectiveController.enabled) return;

    if (widget.intentType == IntentType.bottomSheet) {
      AdvChooser.chooseFromBottomSheet(
        context,
        title: widget.decoration?.labelText ?? "Title",
        items: _effectiveController.items,
        currentItem: _effectiveController.text,
      ).then((picked) {
        if (picked != null) _effectiveController.text = picked;
      });
    } else if (widget.intentType == IntentType.page) {
      AdvChooser.chooseFromPage(
        context,
        title: widget.decoration?.labelText ?? "Title",
        items: _effectiveController.items,
        currentItem: _effectiveController.text,
      ).then((picked) {
        if (picked != null) _effectiveController.text = picked;
      });
    }
  }
}
