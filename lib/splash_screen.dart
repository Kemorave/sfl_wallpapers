import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sfl/app/modules/home/home_binding.dart';
import 'package:sfl/app/modules/home/home_page.dart';
import 'package:sfl/app/modules/login/login_binding.dart';
import 'package:sfl/app/modules/login/login_page.dart';
import 'package:sfl/app/routes/app_pages.dart';

import 'app/core/theme/main_colors.dart';

class MyCustomSplashScreen extends StatefulWidget {
  @override
  _MyCustomSplashScreenState createState() => _MyCustomSplashScreenState();
}

class _MyCustomSplashScreenState extends State<MyCustomSplashScreen>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  var _controller;
  Animation<double>? animation1;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller?.forward();

    Timer(Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(Duration(seconds: 4), () {
      setState(() {
        var w = AppPages.getInitialRout() == AppPages.INITIAL
            ? HomePage()
            : LoginPage();
        Get.offAll(w,
            binding: AppPages.getInitialRout() == AppPages.INITIAL
                ? HomeBinding()
                : LoginBinding(),
            transition: Transition.downToUp,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 3000));
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MainColors.mainColor,
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                  duration: Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: _height / _fontSize),
              AnimatedOpacity(
                duration: Duration(milliseconds: 1000),
                opacity: _textOpacity,
                child: Text(
                  'SFL',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: animation1?.value,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 2000),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 2000),
                curve: Curves.fastLinearToSlowEaseIn,
                height: 100,
                width: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                // child: Image.asset('assets/images/file_name.png')
                child: Icon(
                  Icons.camera_rounded,
                  size: 80,
                  color: MainColors.mainColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget page;

  PageTransition(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}
