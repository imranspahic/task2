import 'package:flutter/material.dart';
import '../functions/preuzmi_func.dart';


class CustomAlert extends StatefulWidget {
  @override
  _CustomAlertState createState() => _CustomAlertState();
}

class _CustomAlertState extends State<CustomAlert> {
  bool preuzimanje = false;
  PreuzmiFunc _func = PreuzmiFunc();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Preuzmi audio fajlove?'),
      children: [
        preuzimanje
            ? Container(
                width: 200, height: 10, child: LinearProgressIndicator())
            : Container(),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ne')),
          SizedBox(
            width: 15,
          ),
          RaisedButton(
              onPressed: () {
                _func.preuzmi().then((zavrseno) {
                  if (zavrseno) {
                    Navigator.of(context).pop(0);
                  } else {
                    Navigator.of(context).pop();
                  }
                });
              },
              child: Text('Da')),
        ]),
      ],
    );
  }
}
