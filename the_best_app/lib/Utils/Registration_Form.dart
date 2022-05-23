import 'package:flutter/material.dart';
import 'package:colours/colours.dart';

class Inputs_Forms extends StatelessWidget {
  final controller;
  final label;
  final ValueChanged<String> onSubmit;

  Inputs_Forms({
    required this.label,
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Registration_Inputs_Form(
        controller: controller,
        label: label,
        onSubmit: onSubmit,
      ),
    );
  }
}

class Registration_Inputs_Form extends StatefulWidget {
  final controller;
  final label;
  final ValueChanged<String> onSubmit;

  Registration_Inputs_Form({
    required this.label,
    required this.controller,
    required this.onSubmit,
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
    if (_errorText == null) {
      widget.onSubmit(widget.controller.value.text);
    }
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
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      BorderSide(color: Colours.rebeccaPurple, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colours.dodgerBlue, width: 2.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      BorderSide(color: Colours.rebeccaPurple, width: 2.0),
                ),
                errorText: _submitted ? _errorText : null,
                hintText: widget.label,
                hintStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                suffixIcon: IconButton(
                    onPressed: () {
                      widget.controller.value.text.isEmpty ? _submit() : null;
                    },
                    icon: Icon(
                      Icons.check,
                      color: Colours.rebeccaPurple,
                    )),
                filled: true,
                fillColor: Colours.aliceBlue,
              ),
            ),
          );
        });
  }
}
