import 'package:flutter/material.dart';

class CustomDiaog extends StatefulWidget {
  @override
  _CustomDiaogState createState() => _CustomDiaogState();
}

class _CustomDiaogState extends State<CustomDiaog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
            "This application requires additional files to be downloaded to be downloaded in order to work properly"),
        Row(
          children: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        )
      ],
    );
  }
}
