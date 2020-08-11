
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:http/http.dart' as http;

class AR extends StatefulWidget {
  @override
  _AR createState() => _AR();
}

class _AR extends State<AR> {
  ArCoreController arCoreController;
  String url = '';


  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello World'),
        ),
        body: ArCoreView(
          enableTapRecognizer: true ,
        onArCoreViewCreated: _onArCoreViewCreated,
      ),
      ),
    );
  }

  _onArCoreViewCreated(ArCoreController _arcoreController) {
    this.arCoreController = _arcoreController;
    this.arCoreController.onNodeTap = (nodes) => onNodeTapHandler(nodes); 
    _addCyclinder(arCoreController);
    _addSphere(arCoreController);
  }

  void onNodeTapHandler(String name) {
    print("hello");
    print(name);
    url = "http://192.168.43.19:80/$name";
    var res = http.get(Uri.encodeFull(url));
  }

  _addCyclinder(ArCoreController _arcoreController) {
    final material = ArCoreMaterial(color: Colors.green, reflectance: 1);
    final cylinder =
        ArCoreCylinder(materials: [material], radius: 0.4, height: 0.3);
    final node = ArCoreNode(
      name: "cylinder",
      shape: cylinder,
      position: vector.Vector3(
        0,
        -2.5,
        -3.0,
      ),
    );
    _arcoreController.addArCoreNode(node);
  }

  _addSphere(ArCoreController _arcoreController) {
    final material = ArCoreMaterial(color: Colors.green, reflectance: 1);
    final sphere = ArCoreSphere(materials: [material], radius: 0.4);
    final moonMaterial = ArCoreMaterial(color: Colors.grey);
    final moonShape = ArCoreSphere(materials: [moonMaterial], radius: 0.4);
    final moon = ArCoreNode(
      shape: moonShape, 
      position: vector.Vector3(1, -2.5, -3.0),
      );
    
    final node = ArCoreNode(
      name: "sphere",
      shape: sphere,
      children: [moon],
      position: vector.Vector3(2, -2.5, -3.0),
    );
    _arcoreController.addArCoreNodeWithAnchor(node);
  }



}


