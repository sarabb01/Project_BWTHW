// Flutter Packages
import 'package:flutter/material.dart';

class FormSeparator extends StatelessWidget {
  final label;

  FormSeparator({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(right: 30, bottom: 5, left: 30, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 2,
              width: 75,
              child: Container(
                color: Theme.of(context).accentColor,
              ),
            ),
            Expanded(
                child: Center(
                    child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ))),
            SizedBox(
              height: 2,
              width: 75,
              child: Container(
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
