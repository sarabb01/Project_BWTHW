import 'package:flutter/material.dart';
import 'package:colours/colours.dart';
import 'package:flutter/services.dart';

class Inputs_Forms extends StatelessWidget {
  final controller;
  final label;
  final DataType;

  Inputs_Forms({
    required this.label,
    required this.controller,
    required this.DataType,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Registration_Inputs_Form(
        controller: controller,
        label: label,
        DataType: DataType,
      ),
    );
  }
}

class Registration_Inputs_Form extends StatefulWidget {
  final controller;
  final label;
  final DataType;

  Registration_Inputs_Form({
    required this.label,
    required this.controller,
    required this.DataType,
  });

  @override
  State<Registration_Inputs_Form> createState() =>
      _Registration_Inputs_FormState();
}

class _Registration_Inputs_FormState extends State<Registration_Inputs_Form> {
  bool _submitted = false;

  String? get _errorText {
    final text = widget.controller.value.text;
    if (text.isEmpty || text == null) {
      return 'Must not be empty';
    }
  }

  void _submit() {
    setState(() {
      _submitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.controller,
        builder: (context, TextEditingValue value, __) {
          return Padding(
            padding:
                EdgeInsets.only(right: 50.0, bottom: 5, left: 50.0, top: 5),
            child: TextField(
              controller: widget.controller,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
              autocorrect: false,
              keyboardType: widget.DataType == 'NUM'
                  ? TextInputType.number
                  : TextInputType.text,
              inputFormatters: widget.DataType == 'NUM'
                  ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                  : null,
              onChanged: (String value) {
                if (widget.controller.value.text.isEmpty ||
                    widget.controller.value.text == null) {
                  _submit();
                }
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colours.black, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor, width: 2.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colours.red, width: 2.0),
                ),
                errorText: _submitted ? _errorText : null,
                hintText: widget.label,
                hintStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                filled: true,
                fillColor: Colours.white,
              ),
            ),
          );
        });
  }
}
