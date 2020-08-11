import 'package:alfred/home.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MymainApp());
}

class MymainApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'elfRED',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'elf-RED'),
    );
  }
}

