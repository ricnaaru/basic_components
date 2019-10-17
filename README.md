# Components by PIT

A bundle that contains our custom components, mostly just override the default Flutter widgets and custom its style and some of its functional.

*Note*: This plugin is still under development, and some Components might not be available yet or still has so many bugs.
- The date picker components inspired by [flutter_calendar_carousel](https://pub.dartlang.org/packages/flutter_calendar_carousel#-readme-tab-), I clone it and override some of its functional and add selection types (single, multi or range)

## Installation

First, add `pit_components` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

```
pit_components: ^0.0.18
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
  DateTime _date;
  String _radioButtonValue = "";
  List<String> possibleValue = [];

  double _lowerValue = 0.0;
  double _upperValue = 100.0;

  @override
  void initState() {
    super.initState();
    possibleValue.add("Possible Value 1");
    possibleValue.add("Possible Value 2");
  }

  Widget _buildRadioButton(Widget icon, String value) {
    return AdvRow(divider: RowDivider(12.0), children: [
      icon,
      Text(value,
          style: ts.fw700.merge(ts.fs12).copyWith(
              color:
                  _radioButtonValue == value ? Colors.black87 : Colors.black38))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    AdvTextFieldController controller = AdvTextFieldController(
        label: "Just TextField MaxLines 1",
        hint: "TextField MaxLines 1 Example",
        maxLines: 1 /*,
        text: "00\\00\\0000 ~ 00(00)00®000"*/
        );
    AdvTextFieldController plainController = AdvTextFieldController(
        enable: false,
        hint: "Plain TextField Example",
        label: "Plain TextField");

    AdvRadioGroupController radioButtonController = new AdvRadioGroupController(
        checkedValue: _radioButtonValue,
        itemList: possibleValue.map((value) {
          IconData activeIconData;
          IconData inactiveIconData;

          if (value == possibleValue[0]) {
            activeIconData = Icons.cloud;
            inactiveIconData = Icons.cloud_off;
          } else {
            activeIconData = Icons.alarm;
            inactiveIconData = Icons.alarm_off;
          }

          return RadioGroupItem(value,
              activeItem: _buildRadioButton(Icon(activeIconData), value),
              inactiveItem: _buildRadioButton(Icon(inactiveIconData), value));
        }).toList());

    AdvRangeSliderController sliderController = AdvRangeSliderController(
        lowerValue: _lowerValue,
        upperValue: _upperValue,
        min: 0.0,
        max: 100.0,
        divisions: 10,
        hint: "Advanced Slider");

    AdvGroupCheckController groupCheckController = AdvGroupCheckController(
        checkedValue: "",
        itemList: [
          GroupCheckItem('Image', 'Image'),
          GroupCheckItem('Document', 'Document')
        ]);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffFCF6E8),
          child: AdvColumn(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            onlyInner: false,
            divider: ColumnDivider(16.0),
            children: [
              AdvRow(divider: RowDivider(8.0), children: [
                Expanded(
                    child: AdvTextField(
                  controller: controller,
//                  inputFormatters: [
//                    DateTextFormatter("dd\\MM\\yyyy ~ HH(mm)ss®SSS")
//                  ],
                )),
                Expanded(
                    child: AdvTextFieldPlain(
                  controller: plainController,
                )),
              ]),
              AdvRow(divider: RowDivider(8.0), children: [
                Expanded(child: AdvButton("Normal", enable: false)),
                Expanded(
                    child:
                        AdvButton("Outlined", onlyBorder: true, enable: false)),
                Expanded(
                    child: AdvButton("Reverse", reverse: true, enable: false))
              ]),
              AdvButton(
                "Go to List View with Bottom Button",
                width: double.infinity,
                buttonSize: ButtonSize.small,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AnotherPage(),
                        settings:
                            RouteSettings(name: widget.runtimeType.toString())),
                  );
                },
              ),
              AdvRow(divider: RowDivider(8.0), children: [
                Expanded(
                  child: AdvButtonWithIcon(
                      "", Icon(Icons.ring_volume), Axis.vertical),
                ),
                Expanded(
                    child: AdvButtonWithIcon(
                        "", Icon(Icons.airline_seat_flat_angled), Axis.vertical,
                        onPressed: () {}, onlyBorder: true)),
                Expanded(
                    child: AdvButtonWithIcon(
                        "", Icon(Icons.headset), Axis.vertical,
                        onPressed: () {}, reverse: true)),
              ]),
              Visibility(
                  visible: _date != null,
                  child: AdvText("You picked date => $_date")),
              AdvDatePicker(
                onChanged: (List value) {
                  if (value.length == 0) return;

                  setState(() {
                    _date = value[0];
                  });
                },
//                markedDates: [
//                  MarkedDate(DateTime(2018, 11, 20),
//                      "20th November - Maulid Nabi Muhammad")
//                ],
                controller: AdvDatePickerController(
                    label: "Just TextField MaxLines 1",
                    enable: false,
                    hint: "test",
                    initialValue: _date ?? DateTime.now(),
                    dates: [_date ?? DateTime.now()]),
              ),
              AdvDropDown(
                onChanged: (String value) {},
                items: {
                  "data 1": "display 1",
                  "data 2": "display 2",
                  "data 3": "display 3"
                },
              ),
              AdvSingleDigitInputter(
                text: "12345",
                digitCount: 5,
              ),
              AdvRadioGroup(
                direction: Axis.vertical,
                controller: radioButtonController,
                divider: 8.0,
                callback: _handleRadioValueChange,
              ),
              AdvRangeSlider(
                controller: sliderController,
                onChanged: (low, high) {
                  setState(() {
                    _lowerValue = low;
                    _upperValue = high;
                  });
                },
              ),
              AdvBadge(
                size: 50.0,
                text: "5,000.00",
              ),
              AdvGroupCheck(
                controller: groupCheckController,
                callback: (itemSelected) async {},
              ),
              AdvChooser(
                enable: false,
                label: "Chooser Example",
                hint: "This is chooser example",
                items: {
                  "data 1": "display 1",
                  "data 2": "display 2",
                  "data 3": "display 3",
                  "data 4": "display 4",
                  "data 5": "display 5",
                  "data 6": "display 6",
                  "data 7": "display 7",
                  "data 8": "display 8",
                  "data 9": "display 9",
                  "data 10": "display 10",
                  "data 11": "display 11",
                  "data 12": "display 12",
                  "data 13": "display 13",
                  "data 14": "display 14",
                  "data 15": "display 15",
                  "data 16": "display 16",
                  "data 17": "display 17",
                  "data 18": "display 18",
                  "data 19": "display 19",
                  "data 20": "display 20",
                  "data 21": "display 21",
                  "data 22": "display 22",
                  "data 23": "display 24 ",
                  "data 24": "display 24",
                  "data 25": "display 25"
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleRadioValueChange(String value) {
    setState(() {
      _radioButtonValue = value;
    });
  }
}
```
