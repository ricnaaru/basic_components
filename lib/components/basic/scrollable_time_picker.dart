part of time_picker;

class ScrollableTimePicker extends StatefulWidget {
  final FixedExtentScrollController controller;
  final double fontSize;
  final Color selectedColor;
  final Color nonSelectedColor;
  final List<int> dataList;
  final Function(int result) callback;

  const ScrollableTimePicker(
      {Key key,
      this.controller,
      this.fontSize,
      this.selectedColor,
      this.nonSelectedColor,
      this.dataList,
      this.callback})
      : super(key: key);

  @override
  _ScrollableTimePickerState createState() => _ScrollableTimePickerState();
}

class _ScrollableTimePickerState extends State<ScrollableTimePicker> {
  int _result = 0;
  double _itemExtent;
  double lerps = 0;

  @override
  void initState() {
    _itemExtent = widget.fontSize + 10;
    widget.controller.addListener(_scrollListener);
    _result = widget.controller.initialItem;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildScrollable();
  }

  Widget _buildScrollable() {
    return Container(
        constraints:
            BoxConstraints.expand(height: _itemExtent * 4, width: _itemExtent),
        child: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black, Colors.transparent],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.dstIn,
          child: ListWheelScrollView.useDelegate(
              controller: widget.controller,
              itemExtent: _itemExtent,
              diameterRatio: 1.2,
              clipToSize: true,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: ((selected) {
                _result = selected;
                widget.callback(widget.dataList[_result]);
              }),
              childDelegate: ListWheelChildLoopingListDelegate(
                  children: _children(widget.dataList))),
        ));
  }

  List<Widget> _children(List<int> list) {
    return List.generate(list.length, (index) {
      return Center(
          child: AnimatedDefaultTextStyle(
              child: Text(list[index].toString().padLeft(2, "0")),
              style: _result == index
                  ? TextStyle(
                      color: Color.lerp(
                          widget.selectedColor,
                          widget.nonSelectedColor,
                          lerps < 0.5 ? lerps : 1 - lerps),
                      fontWeight: FontWeight.w800,
                      fontSize: widget.fontSize)
                  : TextStyle(
                      color: widget.nonSelectedColor,
                      fontSize: widget.fontSize * 0.80),
              duration: Duration(milliseconds: 100)));
    });
  }

  void _scrollListener() {
    if (this.mounted)
      setState(() {
        lerps =
            (widget.controller.offset.round() % _itemExtent) / (_itemExtent);
      });
  }
}
