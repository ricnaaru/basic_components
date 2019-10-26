# Custom Basic Components

A bundle that contains our custom components, mostly just override the default Flutter widgets and custom its style and some of its functional.

*Note*: This plugin is still under development, and some Components might not be available yet or still has so many bugs.
- The date picker components inspired by [flutter_calendar_carousel](https://pub.dartlang.org/packages/flutter_calendar_carousel#-readme-tab-), I clone it and override some of its functional and add selection types (single, multi or range)

## Installation

First, add `basic_components` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

```
basic_components: ^0.0.18
```

## Example
```
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AdvTextFieldController controller = AdvTextFieldController();
  AdvIncrementController incrementController = AdvIncrementController(amount: 10);

  AdvGroupRadioController groupRadioController = AdvGroupRadioController(text: "Test1", items: {
    "Test1": Icon(Icons.edit_attributes),
    "Test2": Icon(Icons.speaker_notes),
    "Test3": Icon(Icons.speaker_notes_off),
  });

  AdvGroupCheckController groupCheckController = AdvGroupCheckController(items: [
    AdvGroupCheckItem(value: "Test1", display: Icon(Icons.edit_attributes), isChecked: false),
    AdvGroupCheckItem(value: "Test2", display: Icon(Icons.speaker_notes), isChecked: false),
    AdvGroupCheckItem(value: "Test3", display: Icon(Icons.speaker_notes_off), isChecked: false),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffffedd8),
          child: AdvColumn(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            divider: ColumnDivider(16.0),
            children: [
              AdvTextField(
                controller: controller,
                minLines: 3,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Text \n lalala",
                  prefix: Text("Prefix"),
                  prefixIcon: Material(
                      child: InkWell(
                        child: Icon(Icons.add),
                        onTap: () {
                          print("makan siang");
                        },
                      )),
                  isDense: true,
                  helperText: "This is Helper Text",
                ),
              ),
              TextField(
                minLines: 3,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Text \n lalala",
                  labelText: "Latex",
                  prefix: Text("Prefix"),
                  prefixIcon: Icon(Icons.add),
                  helperText: "This is Helper Text",
                  contentPadding: EdgeInsets.all(8.0),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                  filled: true,
                  enabledBorder:
                  OutlineInputBorder(borderSide: BorderSide(width: 5.0, color: Colors.red)),
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  fillColor: Colors.white,
                  focusColor: Colors.green,
                  hoverColor: Colors.orange,
                ),
//                scrollPadding: EdgeInsets.all(16.0),
              ),
              AdvRow(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                divider: RowDivider(16.0),
                children: [
                  FlatButton(
                    child: Text("Hide Password!"),
                    onPressed: () {
                      controller.obscureText = true;
                    },
                  ),
                  FlatButton(
                    child: Text("Unhide Password!"),
                    onPressed: () {
                      controller.obscureText = false;
                    },
                  ),
                ],
              ),
              AdvRow(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                divider: RowDivider(16.0),
                children: [
                  FlatButton(
                    child: Text("Set Error!"),
                    onPressed: () {
                      controller.error = "Error!";
                    },
                  ),
                  FlatButton(
                    child: Text("Unset Error!"),
                    onPressed: () {
                      controller.error = null;
                    },
                  ),
                ],
              ),
              AdvRow(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                divider: RowDivider(16.0),
                children: [
                  FlatButton(
                    child: Text("Disable!"),
                    onPressed: () {
                      controller.enabled = false;
                    },
                  ),
                  FlatButton(
                    child: Text("Enable!"),
                    onPressed: () {
                      controller.enabled = true;
                    },
                  ),
                ],
              ),
              AdvRow(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                divider: RowDivider(16.0),
                children: [
                  FlatButton(
                    child: Text("Set Text!"),
                    onPressed: () {
                      controller.text = "Date Time = ${DateTime.now()}";
                    },
                  ),
                ],
              ),
              Container(
                color: Colors.white,
                child: AdvChooser(
                    style: TextStyle(fontSize: 32.0),
                    textAlign: TextAlign.center,
                    items: {
                      "test1": "Satu",
                      "test2": "Dua",
                      "test3": "Tiga",
                      "test4": "Empat",
                    }),
              ),
              Container(
                color: Colors.white,
                child: AdvIncrement(
                  style: TextStyle(fontSize: 24.0),
                  textAlign: TextAlign.center,
                  controller: incrementController,
                ),
              ),
              Container(
                color: Colors.white,
                child: AdvDatePicker(
                  style: TextStyle(fontSize: 24.0),
                  textAlign: TextAlign.center,
                ),
              ),
              AdvGroupRadio(
                controller: groupRadioController,
                callback: (itemSelected) async {
                  Navigator.of(context).pop(itemSelected);
                },
              ),
              AdvGroupCheck(
                controller: groupCheckController,
                callback: (itemSelected) async {
                  Navigator.of(context).pop(itemSelected);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```
