import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tiktok_ui/repository/fake_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AddVideoPage extends StatefulWidget {
  @override
  _AddVideoPageState createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
  CameraController _cameraController;
  List<CameraDescription> cameras;

  TextStyle _textStyle = TextStyle(fontSize: 11);
  int _pageSelectedIndex=1;

  @override
  void initState() {
    _initializedCamera();
    super.initState();
  }

  _initializedCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    _cameraController.initialize().then((value) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              _cameraController.value.isInitialized
                  ? Container(
                      child: CameraPreview(_cameraController),
                    )
                  : Container(),
              _topRowWidget(),
              _rightColumnWidgets(),
              _bottomRowWidget(),
              _bottomWidget(),
            ],
          ),
        );
      },
    );
  }

  Widget _topRowWidget() {
    return Positioned(
      top: 30,
      left: 10,
      right: 20,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close)),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.music_note),
                  Text("Sounds"),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Icon(Icons.flip),
                Text(
                  "flip",
                  style: _textStyle,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _rightColumnWidgets() {
    return Positioned(
      right: 20,
      top: 80,
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Icon(Icons.shutter_speed),
                Text(
                  "Speed",
                  style: _textStyle,
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Icon(Icons.filter_tilt_shift),
                Text(
                  "filters",
                  style: _textStyle,
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Icon(Icons.color_lens),
                Text(
                  "beautify",
                  style: _textStyle,
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Icon(Icons.av_timer),
                Text(
                  "Timer",
                  style: _textStyle,
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Icon(Icons.flash_off),
                Text(
                  "Flash",
                  style: _textStyle,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _bottomRowWidget() {
    return Positioned(
      bottom: 60,
      left: 10,
      right: 10,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.purple.withOpacity(.4),
                        Colors.blue.withOpacity(.4)
                      ]),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Image.asset("assets/effects.png"),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Effects",
                    style: _textStyle,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(.4),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  border: Border.all(color: Colors.black, width: 1.5),
                ),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Image.asset("assets/gallery.png"),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Upload",
                    style: _textStyle,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bottomWidget() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Stack(
          children: <Widget>[
            PageView.builder(
              itemCount: FakeRepository.dataList.length,
              onPageChanged: (int index){
                setState(() {
                  _pageSelectedIndex=index;
                });
              },
              scrollDirection: Axis.horizontal,
              controller: PageController(initialPage: 1,keepPage: true,viewportFraction: 0.2),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  child: Text("${FakeRepository.dataList[index]}",style: TextStyle(color: _pageSelectedIndex==index?Colors.white:Colors.grey),),
                );
              },
            ),
            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}
