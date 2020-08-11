import 'package:alfred/code/ar.dart';
import 'package:alfred/code/mylistener.dart';
import 'package:alfred/code/detect-object.dart';
import 'package:alfred/code/mlkitdemo.dart';
// ------------------------------------------------------
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: (){
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (Context) => AR()));
            },
            title: Center(
              child: Text("List item 1 - AR"),
            ),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (Context) => MyListener()));
            },
            title: Center(
              child: Text("List item 2 - MyListener"),
            ),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (Context) => AutoDetectPlane()));
            },
            title: Center(
              child: Text("List item 3- AR on tap"),
            ),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (Context) => mlkitdemo()));
            },
            title: Center(
              child: Text("List item 4- mlkit demo"),
            ),
          ),
        ]
      ),
      );
  }
}
