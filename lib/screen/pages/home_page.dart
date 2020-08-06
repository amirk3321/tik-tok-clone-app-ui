import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tiktok_ui/repository/fake_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  VideoPlayerController _videoPlayerController;
  bool _isPlaying = true;
  int _followingForYouController = 0;
  TextStyle _followingForYouStyle =
      TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500);

  AnimationController _animationController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.asset('videos/intro.mp4')
      ..initialize()
      ..setLooping(true)
      ..play().then((value) {
        setState(() {});
      });
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 8));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        return Scaffold(
            body: Stack(
          children: <Widget>[
            PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: FakeRepository.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: <Widget>[
                    _videoPlayerController.value.initialized
                        ? Container(
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_videoPlayerController
                                        .value.isPlaying) {
                                      _isPlaying = false;
                                      _videoPlayerController.pause();
                                    } else {
                                      _isPlaying = true;
                                      _videoPlayerController.play();
                                    }
                                  });
                                },
                                child: VideoPlayer(_videoPlayerController)),
                          )
                        : Container(),
                    _isPlaying == false
                        ? Align(
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.4),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Icon(
                                Icons.play_arrow,
                                size: 95,
                              ),
                            ),
                          )
                        : Container(),
                    _rightSideButtonsWidgets(index),
                    _textDataWidgetBottom(sizingInformation, index),
                  ],
                );
              },
            ),
            _topWidgetFollowingAndForYou(),
          ],
        ));
      },
    );
  }

  Widget _topWidgetFollowingAndForYou() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  setState(() {
                    _followingForYouController = 0;
                  });
                },
                child: Text("Following",
                    style: _textStyleFollowingForYou(
                        _followingForYouController == 0
                            ? Colors.white
                            : Colors.white60))),
            SizedBox(
              width: 15,
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    _followingForYouController = 1;
                  });
                },
                child: Text("For you",
                    style: _textStyleFollowingForYou(
                        _followingForYouController == 1
                            ? Colors.white
                            : Colors.white60)))
          ],
        ),
      ),
    );
  }

  TextStyle _textStyleFollowingForYou(Color color) {
    return TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.w500);
  }

  Widget _rightSideButtonsWidgets(int index) {
    return Positioned(
      right: 10,
      bottom: 40,
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 0.80),
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: Image.asset(
                      FakeRepository.data[index].profileUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 13,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Text(
                      "+",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.solidHeart,
                  size: 38,
                ),
                SizedBox(
                  height: 5,
                ),
                Text("${FakeRepository.data[index].likesCount}")
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Icon(Icons.message, size: 38),
                SizedBox(
                  height: 5,
                ),
                Text("${FakeRepository.data[index].messagesCount}")
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            child: Icon(FontAwesomeIcons.share, size: 38),
          ),
          SizedBox(
            height: 25,
          ),
          AnimatedBuilder(
            builder: (BuildContext context, Widget child) {
              return Transform.rotate(
                  angle: _animationController.value * 6.3, child: child);
            },
            animation: _animationController,
            child: Container(
              height: 50,
              width: 50,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: Image.asset(
                      FakeRepository.data[index].profileUrl,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textDataWidgetBottom(SizingInformation sizingInformation, int index) {
    return Positioned(
      bottom: 20,
      left: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Icon(
                      Icons.play_arrow,
                      size: 15,
                    )),
                SizedBox(
                  width: 10,
                ),
                Text("Double Exposure")
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "${FakeRepository.data[index].name}",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: sizingInformation.localWidgetSize.width * 0.80,
            child: Text(
              "${FakeRepository.data[index].description}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              width: sizingInformation.localWidgetSize.width * 0.70,
              child: Text("${FakeRepository.data[index].tags}")),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.music_note,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 25,
                  width: sizingInformation.localWidgetSize.width * 0.40,
                  child: Marquee(
                    text: "${FakeRepository.data[index].musicName}",
                    pauseAfterRound: Duration(seconds: 1),
                    startPadding: 10.0,
                    accelerationDuration: Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: Duration(seconds: 1),
                    decelerationCurve: Curves.easeOut,
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 20.0,
                    velocity: 100.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    _animationController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }
}
