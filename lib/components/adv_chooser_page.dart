part of adv_chooser;

class AdvChooserPage extends StatefulWidget {
  final String title;
  final Map<String, String> items;
  final String currentItem;

  AdvChooserPage({
    String title,
    Map<String, String> items,
    String currentItem,
  })  : this.title = title ?? "",
        this.items = items ?? {},
        this.currentItem = currentItem ?? "";

  @override
  _AdvChooserPageState createState() => _AdvChooserPageState();
}

class _AdvChooserPageState extends State<AdvChooserPage> {
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> groupRadioItems = widget.items.map((key, value) {
      return MapEntry(key, Text(value));
    });

    AdvGroupRadioController controller = AdvGroupRadioController(
        text: widget.currentItem, items: groupRadioItems);

    return WillPopScope(
      onWillPop: () async {
        return _timer == null;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: AdvGroupRadio(
            controller: controller,
            callback: (itemSelected) async {
              Navigator.of(context).push(PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) {
                    return WillPopScope(
                        onWillPop: () async {
                          return _timer == null;
                        },
                        child: Container());
                  }));

              if (_timer != null) {
                _timer.cancel();
              }
              _timer = Timer(Duration(milliseconds: 300), () {
                _timer = null;
                Navigator.of(context).pop();
                Navigator.of(context).pop(itemSelected);
              });
            },
          ),
        ),
      ),
    );
  }
}
