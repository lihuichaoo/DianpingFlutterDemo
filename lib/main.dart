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
            child: Image.asset('assets/more_menu.png'),
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
            CircleAvatar(
              radius: 24,
              backgroundImage: ExactAssetImage('assets/ava2.png'),
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
        child: Image.asset('assets/stamper.png'),
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
            return Image.asset('assets/full_star.png');
          } else {
            return Container(
              padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
              child: Image.asset('assets/full_star.png'),
            );
          }
        } else if (index == countOfFullStar && halfStar) {
          return Container(
            padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
            child: Image.asset('assets/half_star.png'),
          );
        } else {
          return Container(
            padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
            child: Image.asset('assets/empty_star.png'),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            width: 20,
            height: 20,
            child: Image.asset('assets/perfect.png'),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
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
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: 30,
          height: 30,
          child: Image.asset('assets/coupon.png'),
        ),
      ],
    );

    final subTitleStyle = TextStyle(
      color: Colors.black54,
      fontSize: 14,
    );

    final scoreRow = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 12,
          child: _buildScore(4.5),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text(
            '￥96/人',
            style: subTitleStyle,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 2, 0),
              width: 12,
              height: 12,
              child: Image.asset('assets/star.png'),
            ),
            Text(
                '3429',
                style: subTitleStyle
            ),
          ],
        ),
      ],
    );

    final distanceRow = Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
        child: Row(
          children: <Widget>[
            Text(
              '昌平区',
              style: subTitleStyle,
            ),
            SizedBox(width: 5,),
            Text(
                '回龙观',
                style: subTitleStyle,
            ),
            SizedBox(width: 5,),
            Text(
                '焖锅',
                style: subTitleStyle,
            ),
            SizedBox(width: 10,),
            Text(
              '1.1km',
              style: subTitleStyle,
            ),
          ],
        ));

    final groupBuySection = Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
            height: 18,
            child: Image.asset('assets/group.png'),
          ),
          Text(
            '177元 清江鱼焖锅套餐',
            style: subTitleStyle,
          ),
        ],
      ),
    );

    final poiCard = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 2,
      child: Container(
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  titleRow,
                  scoreRow,
                  distanceRow,
                  Divider(height: 1, color: Colors.black38,),
                  groupBuySection,
                ],
              ),
            ),
          ],
        ),
      ),
    );

    Widget _buildCircleAvatar(String path) {
      return CircleAvatar(
        radius: 20,
        backgroundImage: ExactAssetImage(path),
      );
    }

    final likeSection =  Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                  width: 26,
                  child: Image.asset('assets/like.png'),
                ),
                Text(
                  '45',
                  style: subTitleStyle,
                ),
              ],
            ),
            _buildCircleAvatar('assets/ava5.png'),
            _buildCircleAvatar('assets/ava2.png'),
            _buildCircleAvatar('assets/ava3.png'),
            _buildCircleAvatar('assets/ava4.png'),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black12,
              child: Text(
                '更多',
                style: subTitleStyle,
              ),
            ),
          ],
        ));

    Widget _buildIconButton(String path) {
      return GestureDetector(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          width: 40,
          height: 40,
          child: Image.asset(path),
        ),
        onTapUp: _morePressed,
      );
    }

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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                          '浏览 3.5万',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          )),
                    ),
                    SizedBox(width: 0, height: 20,),
                    Divider(height: 1, color: Colors.black38),
                    likeSection,
                    Divider(height: 1, color: Colors.black38),
                    SizedBox(width: 0, height: 20,),
                  ],
                )
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 44,
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildIconButton('assets/like.png'),
              _buildIconButton('assets/comment.png'),
              _buildIconButton('assets/dark_star.png'),
              _buildIconButton('assets/share.png'),
            ],
          ),
        ),
      ),
    );
  }
}