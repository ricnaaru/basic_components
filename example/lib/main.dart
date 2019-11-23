import 'package:basic_components/components/adv_chooser.dart';
import 'package:basic_components/components/adv_column.dart';
import 'package:basic_components/components/adv_date_picker.dart';
import 'package:basic_components/components/adv_group_check.dart';
import 'package:basic_components/components/adv_group_radio.dart';
import 'package:basic_components/components/adv_increment.dart';
import 'package:basic_components/components/adv_row.dart';
import 'package:basic_components/components/adv_text_field.dart';
import 'package:basic_components/utilities/toast.dart';
import 'package:flutter/material.dart';

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
  AdvTextFieldController controller = AdvTextFieldController();
  AdvIncrementController incrementController =
      AdvIncrementController(amount: 10);
  AdvDatePickerController dateController = AdvDatePickerController(
    minDate: DateTime.now(),
    maxDate: DateTime.now().add(Duration(days: 30)),
  );

  AdvGroupRadioController groupRadioController =
      AdvGroupRadioController(text: "Test1", items: {
    "Test1": Icon(Icons.edit_attributes),
    "Test2": Icon(Icons.speaker_notes),
    "Test3": Icon(Icons.speaker_notes_off),
  });

  AdvGroupCheckController groupCheckController =
      AdvGroupCheckController(items: [
    AdvGroupCheckItem(
        value: "Test1", display: Icon(Icons.edit_attributes), isChecked: false),
    AdvGroupCheckItem(
        value: "Test2", display: Icon(Icons.speaker_notes), isChecked: false),
    AdvGroupCheckItem(
        value: "Test3",
        display: Icon(Icons.speaker_notes_off),
        isChecked: false),
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
                controller: controller
                  ..prefixIcon = Material(
                      child: InkWell(
                    child: Icon(Icons.add),
                    onTap: () {
                      Toast.showToast(context, "I'm Tapped!");
                    },
                  )),
                minLines: 3,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Text \n lalala",
                  prefix: Text("Prefix"),
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
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 5.0, color: Colors.red)),
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
              AdvRow(divider: RowDivider(16.0), children: [
                Container(
                  color: Colors.white,
                  child: AdvIncrement(
                    margin: EdgeInsets.all(16.0),
                    decoration:
                        InputDecoration(contentPadding: EdgeInsets.all(8.0)),
                    measureText: "@@@",
                    textAlign: TextAlign.center,
                    controller: incrementController,
                    addButtonColor: Colors.blue,
                    style: TextStyle(fontSize: 16),
                    addButtonShapeBorder: CircleBorder(side: BorderSide()),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: AdvDatePicker(
                    margin: EdgeInsets.all(8.0),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0.0)),
                    measureText: "23-10-2019",
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                    controller: dateController,
                    onChanged: (dates) {},
                  ),
                ),
              ]),
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
