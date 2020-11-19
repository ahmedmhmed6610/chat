import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'menu.dart';

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: Text('page3'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image(
              height: 40,
              image: AssetImage('assets/icons/welcome.png'),
            ),

          ],
        ),
      ),
    );
  }
}
