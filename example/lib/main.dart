import 'package:basic_components/basic_components.dart';
import 'package:basic_components/components/chooser.dart';
import 'package:basic_components/components/column.dart';
import 'package:basic_components/components/date_picker.dart';
import 'package:basic_components/components/group_check.dart';
import 'package:basic_components/components/group_radio.dart';
import 'package:basic_components/components/row.dart';
import 'package:basic_components/components/increment.dart';
import 'package:basic_components/components/text_field.dart';
import 'package:flutter/material.dart';

const String loremIpsum =
    "You think water moves fast? You should see ice. It moves like it has a mind. Like it knows it killed the world once and got a taste for murder. After the avalanche, it took us a week to climb out. Now, I don't know exactly when we turned on each other, but I know that seven of us survived the slide... and only five made it out. Now we took an oath, that I'm breaking now. We said we'd say it was the snow that killed the other two, but it wasn't. Nature is lethal but it doesn't hold a candle to man.";
bool a = false;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PIT Components Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'PIT Components Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextFieldController controller = TextFieldController();
  IncrementController incrementController = IncrementController(amount: 10);

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
    if (!a)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      a = true;
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyHomePage(title: "title",)));
    });

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
//                scrollPadding: EdgeInsets.all(16.0),
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
//                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                  filled: true,
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(width: 5.0, color: Colors.red)),
//                  disabledBorder: InputBorder.none,
//                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
//                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  fillColor: Colors.white,
                  focusColor: Colors.green,
                  hoverColor: Colors.orange,
                ),
//                scrollPadding: EdgeInsets.all(16.0),
              ),
//              AdvRow(
//                padding: EdgeInsets.symmetric(horizontal: 16.0),
//                divider: RowDivider(16.0),
//                children: [
//                  FlatButton(
//                    child: Text("Hide Password!"),
//                    onPressed: () {
//                      controller.obscureText = true;
//                    },
//                  ),
//                  FlatButton(
//                    child: Text("Unhide Password!"),
//                    onPressed: () {
//                      controller.obscureText = false;
//                    },
//                  ),
//                ],
//              ),
//              AdvRow(
//                padding: EdgeInsets.symmetric(horizontal: 16.0),
//                divider: RowDivider(16.0),
//                children: [
//                  FlatButton(
//                    child: Text("Set Error!"),
//                    onPressed: () {
//                      controller.error = "Error!";
//                    },
//                  ),
//                  FlatButton(
//                    child: Text("Unset Error!"),
//                    onPressed: () {
//                      controller.error = null;
//                    },
//                  ),
//                ],
//              ),
//              AdvRow(
//                padding: EdgeInsets.symmetric(horizontal: 16.0),
//                divider: RowDivider(16.0),
//                children: [
//                  FlatButton(
//                    child: Text("Disable!"),
//                    onPressed: () {
//                      controller.enabled = false;
//                    },
//                  ),
//                  FlatButton(
//                    child: Text("Enable!"),
//                    onPressed: () {
//                      controller.enabled = true;
//                    },
//                  ),
//                ],
//              ),
//              AdvRow(
//                padding: EdgeInsets.symmetric(horizontal: 16.0),
//                divider: RowDivider(16.0),
//                children: [
//                  FlatButton(
//                    child: Text("Set Text!"),
//                    onPressed: () {
//                      controller.text = "Date Time = ${DateTime.now()}";
//                    },
//                  ),
//                ],
//              ),
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
