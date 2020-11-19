import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('ahmed6610'),
              accountEmail: Text('ahmedmhmed6610@gmail.com'),
              currentAccountPicture: Image.asset('assets/image/back.jpg'),
            ),
            Divider(
              color: Colors.white,
            ),
            Card(
              child: ListTile(
                title: Text('Home'),
                onTap: () {
                  Navigator.of(context).pushNamed('/home');
                },
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            Card(
              child: ListTile(
                title: Text('ahmed1'),
                onTap: () {
                  Navigator.of(context).pushNamed('/page1');
                },
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            Card(
              child: ListTile(
                title: Text('ahmed2'),
                onTap: () {
                  Navigator.of(context).pushNamed('/page2');
                },
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            Card(
              child: ListTile(
                title: Text('ahmed3'),
                onTap: () {
                  Navigator.of(context).pushNamed('/page3');
                },
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            Divider(
              color: Colors.white,
            ),
            Card(
              child: ListTile(
                title: Text('Upload'),
                onTap: () {
                  Navigator.of(context).pushNamed('/Uplaod');
                },
              ),
            ),
            Divider(
              color: Colors.white,
            ),

            Divider(
              color: Colors.white,
            ),
            Card(
              child: ListTile(
                title: Text('View Database'),
                onTap: () {
                  Navigator.of(context).pushNamed('/viewdata');
                },
              ),
            ),
            Divider(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
