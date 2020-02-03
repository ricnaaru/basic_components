import 'package:basic_components/components/component_theme.dart';
import 'package:basic_components/components/component_theme_data.dart';
import 'package:flutter/material.dart';

class AdvLoadingWithBarrier extends StatelessWidget {
  final WidgetBuilder content;
  final bool isProcessing;
  final WidgetBuilder processingContent;
  final Color barrierColor;
  final double width;
  final double height;

  AdvLoadingWithBarrier(
      {this.content,
      this.isProcessing,
      Color barrierColor,
      double width,
      double height,
      WidgetBuilder processingContent})
      : this.barrierColor = barrierColor,
        this.width = width,
        this.height = height,
        this.processingContent = processingContent ?? content;

  @override
  Widget build(BuildContext context) {
    ComponentThemeData componentTheme = ComponentTheme.of(context);
    Color _barrierColor = barrierColor ?? componentTheme.loading.barrierColor;
    double _width = width ?? componentTheme.loading.width;
    double _height = height ?? componentTheme.loading.height;

    return Stack(
      children: <Widget>[
        isProcessing ? processingContent(context) : content(context),
        _AdvLoadingWrapper(isProcessing, _barrierColor, _width, _height)
      ],
    );
  }
}

class _AdvLoadingWrapper extends StatefulWidget {
  final bool visible;
  final Color barrierColor;
  final double width;
  final double height;

  _AdvLoadingWrapper(this.visible, this.barrierColor, this.width, this.height);

  @override
  State<StatefulWidget> createState() => _AdvLoadingWrapperState();
}

class _AdvLoadingWrapperState extends State<_AdvLoadingWrapper>
    with TickerProviderStateMixin {
  AnimationController opacityController;

  @override
  void initState() {
    super.initState();
    if (!this.mounted) return;

    opacityController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    opacityController.addListener(() {
      if (this.mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    opacityController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!opacityController.isAnimating) {
        if (widget.visible && opacityController.value == 0.0)
          opacityController.forward(from: 0.0);
        if (!widget.visible && opacityController.value == 1.0)
          opacityController.reverse(from: 1.0);
      }
    });
    ComponentThemeData componentTheme = ComponentTheme.of(context);
    String _assetName = componentTheme.loading.assetName;

    return Visibility(
      visible: opacityController.value > 0.0,
      child: Positioned.fill(
        child: Opacity(
          opacity: opacityController.value,
          child: Container(
            color: widget.barrierColor,
            child: Center(
              child: _assetName == null || _assetName.isEmpty
                  ? CircularProgressIndicator()
                  : Image.asset(
                      _assetName,
                      height: widget.height,
                      width: widget.width,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
