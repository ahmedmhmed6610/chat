import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'menu.dart';

class Page1 extends StatefulWidget {
  final List<String> myList = [];
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final List<String> myList = [];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: Text('Home Screen title'),
      ),
      body: Center(
        child: myList.length > 0
            ? Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: GridView.builder(
                  itemCount: myList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildMyList(myList[index]);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                ),
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  Widget _buildMyList(String img) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 5,
        child: Image.network(img),
      ),
    );
  }


}
