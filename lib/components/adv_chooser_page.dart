part of adv_chooser;

class AdvChooserPage extends StatefulWidget {
  final String title;
  final Map<String, String> items;
  final String currentItem;
  final OnAdd onAdd;
  final AdvChooserController controller;

  AdvChooserPage({
    String title,
    Map<String, String> items,
    String currentItem,
    this.onAdd,
    this.controller,
  })
      : this.title = title ?? "",
        this.items = items ?? {},
        this.currentItem = currentItem ?? "";

  @override
  _AdvChooserPageState createState() => _AdvChooserPageState();
}

class _AdvChooserPageState extends State<AdvChooserPage> {
  Timer _timer;
  Map<String, String> _items;


  @override
  void initState() {
    super.initState();
    _items = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> groupRadioItems = _items.map((key, value) {
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
        floatingActionButton: widget.onAdd == null ? null :  FloatingActionButton(
          child: Icon(Icons.add), onPressed: () async {
          if (widget.onAdd != null) {
            var items = await widget.onAdd();

            if (items is Map && items != null) {
              _items = items;
              widget.controller.items = items;
              setState(() {

              });
            }
          }
        },),
      ),
    );
  }
}
