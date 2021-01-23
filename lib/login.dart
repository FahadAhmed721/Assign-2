import 'dart:async';
import 'dart:math';

import 'package:assign_2/Second_screen.dart';
import 'package:assign_2/custom_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offset;
  Animation<double> offsetAgain;
  Animation<double> secondOffset;
  bool isShow = false;
  bool isShowAgain = false;

// Images
  List<String> photos = [
    "assets/river.jpg",
    "assets/stones.jpg",
    "assets/tree.jpg",
  ];

  int _pos = 0;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 100))
        .animate(controller);

    offsetAgain = Tween<double>(begin: 0, end: -400).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    secondOffset = Tween<double>(begin: 0, end: 500).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    _timer = Timer.periodic(new Duration(seconds: 3), (Timer t) {
      setState(() {
        _pos = (_pos + 1) % photos.length;
      });
    });
  }

  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        //color: Colors.amber,
        //height: 100,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.33,
              child: Stack(children: [
                Container(
                    width: double.infinity, child: Image.asset(photos[_pos])),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 70.0, left: 30),
                      child: Text(
                        'Connection',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )),
              ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height * 0.74,
                ),
              ),
            ),
            Positioned(
              top: 200,
              left: MediaQuery.of(context).size.width / 4,
              // bottom: 0,
              child: SlideTransition(
                position: offset,
                child: Text(
                  "AUTHENTICATION",
                  style: TextStyle(color: authTextColor, fontSize: authSize),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.33,
                  left: 20,
                  right: 20),
              child: Container(
                child: Column(
                  children: [
                    Transform.translate(
                      offset: Offset(0, secondOffset.value),
                      //position: offset,
                      child: TextField(
                        focusNode: AlwaysDisabledFocusNode(),
                        onTap: () {},
                        decoration: InputDecoration(hintText: "Email"
                            //labelText: "Email"
                            ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, secondOffset.value),
                      child: TextField(
                        focusNode: AlwaysDisabledFocusNode(),
                        decoration: InputDecoration(labelText: "Password"),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Transform.translate(
                      offset: Offset(0, secondOffset.value),
                      child: GestureDetector(
                          onTap: () {},
                          child: Container(
                              height: 50,
                              //width: 300,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                  child: Text(
                                "CONNECT",
                                style: TextStyle(
                                    color: Colors.white, fontSize: connectTextSize),
                              )))),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Transform.translate(
                      offset: Offset(0, secondOffset.value),
                      child: GestureDetector(
                        onTap: () {
                          switch (controller.status) {
                            case AnimationStatus.dismissed:
                              controller.forward();
                              setState(() {
                                isShow = true;
                              });

                              break;
                            default:
                          }
                        },
                        child: Text(
                          "Forgotten password",
                          style: TextStyle(color: forgetPasswordText, fontSize: forgetPasswordTextSize),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Transform.translate(
                      offset: Offset(0, secondOffset.value),
                      child: Text(
                        "-OR-",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Transform.translate(
                      offset: Offset(0, secondOffset.value),
                      child: GestureDetector(
                          onTap: () {
                            switch (controller.status) {
                              case AnimationStatus.dismissed:
                                controller.forward();
                                break;
                              default:
                            }
                          },
                          child: Container(
                              height: 50,
                              //width: 300,
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                  child: Text(
                                "REGISTER",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    isShow == true
                        ? Transform.translate(
                            offset: Offset(0, offsetAgain.value),
                            child: GestureDetector(
                                onTap: () {
                                  switch (controller.status) {
                                    case AnimationStatus.completed:
                                      controller.reverse();
                                      break;
                                    // case AnimationStatus.dismissed:
                                    //   controller.forward();
                                    //   break;
                                    default:
                                  }
                                },
                                child: Icon(Icons.arrow_back)))
                        : Container()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BgWallpaper extends StatelessWidget {
  const BgWallpaper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.33,
      child: Stack(children: [
        Container(
          width: double.infinity,
          child: //CustomPageView()
              Image.network(
            "https://myrepublica.nagariknetwork.com/uploads/media/2019/May/theholidayspot.jpg",
            filterQuality: FilterQuality.high,
            fit: BoxFit.fill,
          ),
        ),
        Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70.0, left: 30),
              child: Text(
                'Connection',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )),
      ]),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
