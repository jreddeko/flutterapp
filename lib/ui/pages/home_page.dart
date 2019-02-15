import 'package:flutter/material.dart';
import 'package:card_example/ui/pages/video_page2.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kinh phật - Lời phật dạy',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.brown,
        platform: Theme.of(context).platform,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kinh phật - Lời phật dạy'),
        ),
        body: Center(
          child: VideoPage2(),
        ),        
      ),
    );
  }
}
