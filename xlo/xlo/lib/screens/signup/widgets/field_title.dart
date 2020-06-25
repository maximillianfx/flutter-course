import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget {

  const FieldTitle({this.title, this.subTitle});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.w700,
              fontSize: 16
            ),
          ),
          SizedBox(width: 10,),
          Text(
            subTitle,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12
            ),
          )

        ],
      ),
    );
  }
}
