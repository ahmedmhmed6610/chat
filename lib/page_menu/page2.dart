import 'package:chat/utilites/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'menu.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: Text('page2'),
      ),
      body: Background(
        child: Column(
          children: <Widget>[
            Text("ahmed6610")
          ],
        ),

      ),

    );
  }


}
