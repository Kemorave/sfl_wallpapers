// ignore_for_file: prefer_const_constructors

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sfl/app/core/theme/main_colors.dart';
import 'package:sfl/app/core/widgets/transparent_clip.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../core/widgets/default_appbar.dart';
import '../home/home_controller.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: DefaultAppbar(AppBar(
        title: Text("About"),
      )),
      backgroundColor: MainColors.mainColor,
      body: AnimatedBackground(
          vsync: HomeController(),
          behaviour: RandomParticleBehaviour(
              options: ParticleOptions(
                  maxOpacity: 1, minOpacity: 0.5, baseColor: Colors.white)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Center(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/kemorave.png",
                            ),
                            Text(
                              "This app is not a distributed work its only used for my personal development collection  ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 167, 167, 167)),
                            ),
                            Divider(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("kemorave@gmail.com"),
                                GFIconButton(
                                  shape: GFIconButtonShape.circle,
                                  icon: Icon(
                                    Icons.mail,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    var url = "mailto:kemorave@gmail.com";
                                    if (await canLaunchUrlString(url)) {
                                      await launchUrlString(url);
                                    }
                                  },
                                ),
                              ],
                            ),
                            Divider(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("+249116720907"),
                                GFIconButton(
                                  shape: GFIconButtonShape.circle,
                                  icon: Icon(
                                    Icons.call,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    var url = "tel:+249116720907";
                                    if (await canLaunchUrlString(url)) {
                                      await launchUrlString(url);
                                    }
                                  },
                                ),
                              ],
                            ),
                            Divider(
                              height: 10,
                            ),
                            Row(
                              children: [
                                GFButton(
                                  shape: GFButtonShape.pills,
                                  icon: Icon(
                                    Icons.gite,
                                    color: Colors.white,
                                  ),
                                  text: "Visit my portfolio",
                                  onPressed: () async {
                                    var url =
                                        "https://mostaql.com/u/kemorave/portfolio";
                                    if (await canLaunchUrlString(url)) {
                                      await launchUrlString(url);
                                    }
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
