import 'package:flutter/material.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Text To Speech',
      theme: ThemeData(),
      home: MyHomePage(title: 'Text To Speech'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  VoiceController _voiceController;
  final myController = TextEditingController();

  @override
  void initState() {
    _voiceController = FlutterTextToSpeech.instance.voiceController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
    _voiceController.stop();
  }

  _playVoice() {
    _voiceController.init().then((_) {
      _voiceController.speak(
        myController.text,
        VoiceControllerOptions(),
      );
    });
  }

  _stopVoice() {
    _voiceController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 223, 240, 1),
      appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Color.fromRGBO(253, 49, 157, 0.4)),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: NetworkImage(
                  'http://assets.stickpng.com/thumbs/580b57fbd9996e24bc43bfdd.png'),
              height: 200,
              width: 200,
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: myController,
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: _playVoice,
              color: Colors.white,
              child: Text('Reproducir voz'),
              shape: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            RaisedButton(
              onPressed: _stopVoice,
              color: Colors.white,
              child: Text('Parar reproducción'),
              shape: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
