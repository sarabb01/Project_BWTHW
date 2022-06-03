import 'package:flutter/material.dart';
import 'package:colours/colours.dart';
import 'package:flutter/services.dart';

// FOR TEXT BOXES
class Inp_Reg_Text extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  Inp_Reg_Text({required this.label, required this.controller});

  @override
  State<Inp_Reg_Text> createState() =>
      Inp_Reg_TextState(controller: controller, label: label);
}

class Inp_Reg_TextState extends State<Inp_Reg_Text> {
  final TextEditingController controller;
  final String label;

  Inp_Reg_TextState({
    required this.label,
    required this.controller,
  });

  String _ans = '';
  bool _submitted = false;
  final key = GlobalKey<FormState>();

  void _submit() {
    setState(() => _submitted = true);
    if (key.currentState!.validate()) {
      print(controller.value.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: key,
        child: Padding(
          padding: EdgeInsets.only(right: 50.0, bottom: 5, left: 50.0, top: 5),
          child: TextFormField(
            controller: controller,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
            autocorrect: false,
            keyboardType: TextInputType.text,
            autovalidateMode: _submitted
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Can\'t be empty';
              } else {
                return null;
              }
            },
            onChanged: (value) {
              if (value.isEmpty || value == null) {
                _submit();
              }
              setState(() {
                _ans = value;
              });
            },
            onTap: () {
              if (controller.text.isEmpty || controller.text == null) {
                _submit();
              }
              setState(() {
                _ans = controller.text;
              });
            },
            decoration: inputDecoration(_submitted, widget.label, context),
          ),
        ));
  }
}

// FOR NUMERIC BOXES
class Inp_Reg_Num extends StatefulWidget {
  final controller;
  final label;

  Inp_Reg_Num({
    required this.label,
    required this.controller,
  });

  @override
  State<Inp_Reg_Num> createState() => Inp_Reg_NumState(
        controller: controller,
        label: label,
      );
}

class Inp_Reg_NumState extends State<Inp_Reg_Num> {
  final controller;
  final label;

  Inp_Reg_NumState({
    required this.label,
    required this.controller,
  });

  String _ans = '';
  bool _submitted = false;
  final key = GlobalKey<FormState>();

  void _submit() {
    setState(() => _submitted = true);
    if (key.currentState!.validate()) {
      print(controller.value.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: key,
        child: Padding(
          padding: EdgeInsets.only(right: 50.0, bottom: 5, left: 50.0, top: 5),
          child: TextFormField(
            controller: widget.controller,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
            autocorrect: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Can\'t be empty';
              } else {
                String? ret;
                String pattern = r'^[0-9]{1,3}$';
                RegExp regex = RegExp(pattern);
                if (!regex.hasMatch(value)) {
                  ret = 'Must be a number.';
                  return ret;
                }
              }
            },
            keyboardType: TextInputType.numberWithOptions(signed: true),
            onChanged: (value) {
              if (value.isEmpty || value == null) {
                _submit();
              }
              setState(() {
                _ans = value;
              });
            },
            onTap: () {
              if (controller.text.isEmpty || controller.text == null) {
                _submit();
              }
              setState(() {
                _ans = controller.text;
              });
            },
            decoration: inputDecoration(_submitted, widget.label, context),
          ),
        ));
  }
}

InputDecoration inputDecoration(
  submitted,
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

/*
///Class that implement a custom-made [ListTile] to manage textboxes containing dates in a [Form].
///You must provide a label that is shown as helper, the date to show, an icon, a callback to define the behaviour of the field when it is tapped, and a [DateFormat].
///The [FormDateTile] content is always valid and it should be guaranteed via a DatePicker.
class FormDateTile extends ListTile {
  final labelText;
  final date;
  final icon;
  final onPressed;
  final DateFormat dateFormat;

  FormDateTile(
      {this.icon,
      this.labelText,
      this.date,
      required this.dateFormat,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).accentColor),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1),
                top: BorderSide(width: 1),
                left: BorderSide(width: 1),
                right: BorderSide(width: 1),
              ),
            ),
            child: Container(
              alignment: Alignment.centerLeft,
              width: screenSize.width / 1.5,
              child: FlatButton(
                child: Text(dateFormat.format(date)),
                onPressed: onPressed,
              ),
            ),
          )
        ],
      ),
    );
  } // build
} // FormDateTile
*/
