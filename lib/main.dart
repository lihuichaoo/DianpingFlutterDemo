import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
import 'package:flutter/cupertino.dart';

void main() {
  debugPaintSizeEnabled = false; // Set to true for visual layout
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: buildHomePage(''),
    );
  }

  void _morePressed(TapUpDetails details) {
    print('more pressed');
  }

  Widget buildHomePage(String title) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 326,
            actions: <Widget>[
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  width: 40,
                  height: 40,
                  child: Image.asset('assets/more.png'),
                ),
                onTapUp: _morePressed,
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(title),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset('assets/pavlova.jpg',
                    fit: BoxFit.cover,),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}