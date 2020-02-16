

import 'package:basic_components/components/component_theme_data.dart';
import 'package:flutter/material.dart';

const Duration kThemeAnimationDuration = Duration(milliseconds: 200);

class ComponentTheme extends StatelessWidget {
  /// Applies the given theme [data] to [child].
  ///
  /// The [data] and [child] arguments must not be null.
  const ComponentTheme({
    Key key,
    @required this.data,
    @required this.child,
  }) : assert(child != null),
        assert(data != null),
        super(key: key);

  final ComponentThemeData data;

  final Widget child;

  static ComponentThemeData of(BuildContext context, { bool shadowThemeOnly = false }) {
    final _InheritedTheme inheritedTheme = context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();

      return inheritedTheme?.theme?.data ?? ComponentThemeData();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedTheme(
      theme: this,
      child: child,
    );
  }
}

class _InheritedTheme extends InheritedTheme {
  const _InheritedTheme({
    Key key,
    @required this.theme,
    @required Widget child,
  }) : assert(theme != null),
        super(key: key, child: child);

  final ComponentTheme theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final _InheritedTheme ancestorTheme = context.findAncestorWidgetOfExactType<_InheritedTheme>();
    return identical(this, ancestorTheme) ? child : ComponentTheme(data: theme.data, child: child);
  }

  @override
  bool updateShouldNotify(_InheritedTheme old) => theme.data != old.theme.data;
}