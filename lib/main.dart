import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

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

  void _suggestionPressed() {
    print('suggestion pressed');
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

    final avatar = Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 14, 0),
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
      padding: const EdgeInsets.fromLTRB(0, 25, 15, 0),
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

    final suggestionSection = RichText(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: '推荐: ',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 19,
        ),
        children: <TextSpan>[
          TextSpan(
              text: '清江鱼',
              style: TextStyle(
                color: Colors.blueAccent,
              ),
              recognizer: TapGestureRecognizer()..onTap = _suggestionPressed
          ),
        ],
      ),
    );

    Widget _buildScore(double score) {
      if(score < 0) score = 0;
      if(score > 5) score = 5;
      int countOfFullStar = score.floor();
      bool halfStar = (score - countOfFullStar) >= 0.5;

      List<Widget> children = List.generate(5, (int index) {
        if (index < countOfFullStar) {
          if (index == 0) {
            return Image.asset('assets/fw2.png');
          } else {
            return Container(
              padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
              child: Image.asset('assets/fw2.png'),
            );
          }
        } else if (index == countOfFullStar && halfStar) {
          return Container(
            padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
            child: Image.asset('assets/fw1.png'),
          );
        } else {
          return Container(
            padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
            child: Image.asset('assets/fw0.png'),
          );
        }
      });

      return Row(children: children);
    }

    final scoreSection = Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Row(
          children: <Widget>[
            Text('打分',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 19,
              ),
            ),
            Container(
              height: 18,
              padding: const EdgeInsets.fromLTRB(12, 0, 30, 0),
              child: _buildScore(3.3),
              ),
            Text('￥90/人',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 19,
              ),
            ),
          ],
        ));

    Widget _buildIconText(String title) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 32,
            height: 32,
            child: Image.asset('assets/fa.png'),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),),
        ],
      );
    }

    final detailScoreRow = Row(
      children: <Widget>[
        _buildIconText('口味超棒'),
        _buildIconText('环境超棒'),
        _buildIconText('服务超棒'),
        _buildIconText('食材超棒'),
      ],
    );

    final titleRow = Row(
      children: <Widget>[
        Text(
          '一品焖锅(回龙观店)',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: 30,
          height: 30,
          child: Image.asset('assets/cm3.png'),
        ),
      ],
    );

    final scoreRow = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 15,
          child: _buildScore(4.5),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
          child: Text(
            '￥96/人',
            style: TextStyle(
              color: Colors.black26,
              fontSize: 18,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              width: 25,
              height: 25,
              child: Image.asset('assets/gfl.png'),
            ),
            Text(
              '3429',
              style: TextStyle(
                color: Colors.black26,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );

    final distanceRow = Row(
      children: <Widget>[
        Text(
            '昌平区',
            style: TextStyle(
              color: Colors.black26,
              fontSize: 18,
            )),
        SizedBox(width: 5,),
        Text(
            '回龙观',
            style: TextStyle(
              color: Colors.black26,
              fontSize: 18,
            )),
        SizedBox(width: 5,),
        Text(
            '焖锅',
            style: TextStyle(
              color: Colors.black26,
              fontSize: 18,
            )),
        SizedBox(width: 10,),
        Text(
            '1.1km',
            style: TextStyle(
              color: Colors.black26,
              fontSize: 18,
            )),
      ],
    );

    final poiCard = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 90,
              height: 90,
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Image.asset('assets/poi.png'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                titleRow,
                scoreRow,
                distanceRow,
              ],
            )
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.98),
      body: CustomScrollView(
        slivers: <Widget>[
          appBar,
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        avatar,
                        nickName,
                        followButton,
                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        stamper,
                        commentSection,
                      ],
                    ),
                    suggestionSection,
                    scoreSection,
                    SizedBox(width: 0, height: 2,),
                    detailScoreRow,
                    SizedBox(width: 0, height: 10,),
                    poiCard,
                  ],
                )
              ),
            ]),
          ),
        ],
      ),
    );
  }
}