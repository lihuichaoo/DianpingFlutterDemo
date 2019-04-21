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

  void _followPressed() {
    print('follow pressed');
  }

  Widget buildHomePage(String title) {

    final appBar = SliverAppBar(
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
    );

    final avar = Container(
        padding: const EdgeInsets.fromLTRB(15, 0, 14, 0),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset('assets/ava2.png'),
            ),
            Positioned(
              left: 25,
              top: 25,
              child: Container(
                width: 25,
                height: 25,
                child: Image.asset('assets/v.png'),
              ),
            ),
          ],
        )
    );

    final nickName = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'Midnight',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
              ),
            ),
            Container(
              height: 16,
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Image.asset('assets/lv1.png'),
            ),
          ],
        ),
        SizedBox(height: 6,), // for spacing
        Text(
          '2月28日 18:45',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
      ],
    );

    final followButton = Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          width: 80,
          height: 34,
          child: CupertinoButton(
            padding: const EdgeInsets.all(0),
            color: Colors.deepOrangeAccent,
            borderRadius: BorderRadius.circular(20),
            child: Text(
              '✚ 关注',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onPressed: _followPressed,
          ),
        ),
      ),
    );

    final stamper = Positioned(
      right: 10,
      child: Container(
        width: 55,
        height: 55,
        child: Image.asset('assets/efi.png'),
      ),
    );

    final commentSection = Container(
      padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
      child: Text('已经是第二次来了，在回龙观华联的三楼，电梯上来就能看到，很好找。'
          '上次是在砍价网站上买的，很便宜，这次直接来了，可以团购代金券，'
          '相当于打了九二折，还比较合适。味道相当好，里面有好多配菜，可以不用'
          '单点配菜。以后还会来的。',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.98),
      body: CustomScrollView(
        slivers: <Widget>[
          appBar,
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  children: <Widget>[
                    avar,
                    nickName,
                    followButton,
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  stamper,
                  commentSection,
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}