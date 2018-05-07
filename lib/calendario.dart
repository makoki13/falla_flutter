import 'package:flutter/material.dart';

class Calendario extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new Center(
          child: new IconButton(
            icon: new Icon (Icons.announcement, size:150.0, color: Colors.indigoAccent),
            onPressed: null,
          ),
          
        )
    );
  }
}