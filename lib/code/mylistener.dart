import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';



class MyListener extends StatefulWidget {
  @override
  _MyListenerState createState() => _MyListenerState();
}

class _MyListenerState extends State<MyListener> {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "";
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  final ip_controller = TextEditingController();
  final port_controller = TextEditingController();
  String url = '';


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('my STT Listener'),
        ),
        body: Column(children: [
          Center(
              child: Text(
                'Speak to the servers', 
                style: TextStyle(fontSize: 22.0),
                ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: ip_controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Server name/ip'
                    ),
                  ),
                ),
                Container(
                  width: 100.0,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: port_controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Server Port'
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                lastWords,
              ),
            )
          ),
          Container(
            child: Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    DropdownButton(
                      onChanged: (selectedVal) => _switchLang(selectedVal),
                      value: _currentLocaleId,
                      items: _localeNames
                          .map(
                            (localeName) => DropdownMenuItem(
                              value: localeName.localeId,
                              child: Text(localeName.name),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
            ),
          ),
          Expanded(
            child: Center(
              child: IconButton(
                iconSize: 50,
                icon: Icon(Icons.mic), 
                onPressed: !_hasSpeech || speech.isListening ? null : startListening),
            ),
          ),
          Container(
            child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      child: Text('Initialize'),
                      onPressed: _hasSpeech ? null : initSpeechState,
                    ),
                    FlatButton(
                      child: Text('cancel'),
                      onPressed: speech.isListening ? cancelListening : null,
                    ),
                    FlatButton(
                      child: Text('stop'),
                      onPressed: speech.isListening ? stopListening : null,
                    ),
                  ],
                ),
          ),
        ]),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
  }

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    if (hasSpeech) {
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId;
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  void startListening() {
    lastWords = "";
    lastError = "";
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 10),
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        partialResults: true,
        onDevice: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void test(){
    print(3*2);
  }


  void resultListener(SpeechRecognitionResult result) {
    setState(() {

      var status = "....";
      if(result.finalResult==true){   //* print the true values only *//
        // print(lastWords);
        // print(name_controller.text);
        
        url = "http://"+ip_controller.text+":"+port_controller.text+"/"+result.recognizedWords;
        print(url);
        status = (result.finalResult=='true')?'...':'sent';
        // var res = http.get(Uri.encodeFull(url));
        // print(res);
      }
      lastWords = "${result.recognizedWords} - ${status}";
      
    });
    
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    // print("Received error status: $error, listening: ${speech.isListening}");
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status) {
    // print("Received listener status: $status, listening: ${speech.isListening}");
    setState(() {
      lastStatus = "$status";
    });
  }

  _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    // print(selectedVal);
  }
}