/*
import 'package:flutter/material.dart';
import 'package:colours/colours.dart';
import 'package:intl/intl.dart';
//import 'package:flutter/services.dart';
import 'package:select_form_field/select_form_field.dart';

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
    return ListTile(
        title: Form(
            key: key,
            child: Padding(
              padding:
                  EdgeInsets.only(right: 50.0, bottom: 5, left: 50.0, top: 5),
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
            )));
  }
}

class Inp_Reg_Mult_Choice extends StatefulWidget {
  final value;
  final items;
  final labelText;
  final icon;
  final onChanged;

  Inp_Reg_Mult_Choice(
      {required this.value,
      required this.items,
      required this.labelText,
      required this.icon,
      required this.onChanged});
  @override
  State<Inp_Reg_Mult_Choice> createState() =>
      _Inp_Reg_Mult_ChoiceState(value: value);
}

class _Inp_Reg_Mult_ChoiceState extends State<Inp_Reg_Mult_Choice> {
  String value; //  None
  final items; // Male,Female,None
  final icon;

  ///Class that implement a custom-made [ListTile] to manage dropdown menus containing strings in a [Form].
  ///You must provide a label that is shown as helper, the value to show, the items to show, a callback to define the behaviour of the field when it changes, and an icon.
  ///The [DropdownButtonTileString] content is always valid since it is guaranteed by the fact that the values it can assumes are provided by the user.
  _Inp_Reg_Mult_ChoiceState({
    this.icon,
    required this.value,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).accentColor),
      title: Container(
        width: screenSize.width / 1.5,
        child: DropdownButton<String>(
          isExpanded: false,
          value: value,
          onChanged: (String? newValue) {
            setState(() {
              value = newValue!;
            });
          },
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text('$value'),
            );
          }).toList(),
        ),
      ),
    );
  } // build
} // DropdownButtonTileString

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
*/