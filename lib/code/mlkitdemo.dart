
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:mlkit/mlkit.dart';
import 'package:http/http.dart' as http;

class mlkitdemo extends StatefulWidget {
  @override
  _mlkitdemo createState() => _mlkitdemo();
}

class _mlkitdemo extends State<mlkitdemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MLKit Demo'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: RaisedButton(
                child: Text('MLKit vision text detection'),
                onPressed: () {
                  // Navigate to the second screen using a named route
                  Navigator.pushNamed(context, '/vision-text');
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Object detection with custom model'),
                onPressed: () {
                  // Navigate to the second screen using a named route
                  Navigator.pushNamed(context, '/custom-model');
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Face detection'),
                onPressed: () {
                  // Navigate to the second screen using a named route
                  Navigator.pushNamed(context, '/face-detect');
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Label Images'),
                onPressed: () {
                  // Navigate to the second screen using a named route
                  Navigator.pushNamed(context, '/label-image');
                },
              ),
            ),
          ],
        ));
  }
}