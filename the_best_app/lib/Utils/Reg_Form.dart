import 'package:flutter/material.dart';
import 'package:colours/colours.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';

///Class that implement a custom-made [ListTile] to manage textboxes containing strings in a [Form].
///You must provide a controller, a label that is shown as helper, and an icon. This is checked via a regex.
///The [FormTextTile] content is valid if it is not empty.
class FormTextTile extends ListTile {
  final controller;
  final labelText;

  FormTextTile({this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
        title: Padding(
      padding: EdgeInsets.only(right: 25.0, bottom: 5, left: 25.0, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: screenSize.width / 1.5,
            child: TextFormField(
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 16),
              autocorrect: false,
              keyboardType: TextInputType.text,
              controller: controller,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Can\'t be empty';
                }
                return null;
              },
              decoration: inputDecoration(labelText, context),
            ),
          ),
        ],
      ),
    ));
  } // build
} // FormTextTile

///Class that implement a custom-made [ListTile] to manage textboxes containing numbers in a [Form].
///You must provide a controller, a label that is shown as helper, and an icon.
///The [FormNumberTile] content is valid if it contains numbers only. This is checked via a regex.
class FormNumberTile extends ListTile {
  final controller;
  final labelText;
  final icon;

  FormNumberTile({this.icon, this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).accentColor),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: screenSize.width / 1.5,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                String? ret;
                String pattern =
                    r'^(0*[1-9][0-9]*(\.[0-9]*)?|0*\.[0-9]*[1-9][0-9]*)$';
                RegExp regex = RegExp(pattern);
                if (!regex.hasMatch(value!)) ret = 'Must be a number.';
                return ret;
              },
              keyboardType: TextInputType.numberWithOptions(signed: true),
              decoration: InputDecoration(
                labelText: labelText,
              ),
            ),
          ),
        ],
      ),
    );
  } // build
} // FormTextTile

///Class that implement a custom-made [ListTile] to manage textboxes containing dates in a [Form].
///You must provide a label that is shown as helper, the date to show, an icon, a callback to define the behaviour of the field when it is tapped, and a [DateFormat].
///The [FormDateTile] content is always valid and it should be guaranteed via a DatePicker.
class FormDateTile extends ListTile {
  final labelText;
  final date;
  final onPressed;
  final DateFormat dateFormat;

  FormDateTile(
      {this.labelText, this.date, required this.dateFormat, this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
        title: Padding(
      padding: EdgeInsets.only(right: 25.0, bottom: 5, left: 25.0, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: screenSize.width / 1.5,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).accentColor, width: 2.0),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white),
            child: Container(
              alignment: Alignment.center,
              child: FlatButton(
                child: Text(
                  dateFormat.format(date),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                onPressed: onPressed,
              ),
            ),
          )
        ],
      ),
    ));
  } // build
} // FormDateTile

///Class that implement a custom-made [ListTile] to manage dropdown menus containing numbers in a [Form].
///You must provide a label that is shown as helper, the value to show, the items to show, a callback to define the behaviour of the field when it changes, and an icon.
///The [DropdownButtonTileNumber] content is always valid since it is guaranteed by the fact that the values it can assumes are provided by the user.
class DropdownButtonTileNumber extends StatefulWidget {
  final value;
  final items;
  final labelText;
  final icon;
  final onChanged;

  DropdownButtonTileNumber(
      {this.icon, this.value, this.items, this.labelText, this.onChanged});

  @override
  State<DropdownButtonTileNumber> createState() =>
      _DropdownButtonTileNumberState();
}

class _DropdownButtonTileNumberState extends State<DropdownButtonTileNumber> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(widget.icon, color: Theme.of(context).accentColor),
      title: Container(
        width: screenSize.width / 1.5,
        child: DropdownButton<int>(
          isExpanded: false,
          value: widget.value,
          onChanged: widget.onChanged,
          items: widget.items.map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text('${value.toString()}'),
            );
          }).toList(),
        ),
      ),
    );
  }
} // DropdownButtonTileNumber

class DropdownButtonTileString extends StatefulWidget {
  final items;
  final labelText;

  DropdownButtonTileString({required this.items, required this.labelText});

  @override
  State<DropdownButtonTileString> createState() =>
      _DropdownButtonTileStringState();
}

class _DropdownButtonTileStringState extends State<DropdownButtonTileString> {
  String dropdownValue = "None";

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
        title: Padding(
      padding: EdgeInsets.only(right: 25.0, bottom: 5, left: 25.0, top: 5),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).accentColor, width: 2.0),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
        width: screenSize.width / 1.5,
        child: DropdownButton<String>(
          alignment: Alignment.center,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          isExpanded: false,
          value: dropdownValue,
          elevation: 16,
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
          },
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text('$value'),
            );
          }).toList(),
        ),
      ),
    ));
  }
} // DropdownButtonTileString

InputDecoration inputDecoration(
  label,
  context,
) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colours.black, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Theme.of(context).accentColor, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colours.red, width: 2.0),
    ),
    hintText: label,
    hintStyle: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
    filled: true,
    fillColor: Colours.white,
  );
}
