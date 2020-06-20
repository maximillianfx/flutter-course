import 'package:flutter/material.dart';

class TextWithDivider extends StatelessWidget {

  TextWithDivider({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(text),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
