// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart' as intl;
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/drawer/gf_drawer.dart';
import 'package:getwidget/components/drawer/gf_drawer_header.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/position/gf_position.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sfl/app/core/base_controller.dart';
import 'package:sfl/app/core/theme/main_colors.dart';
import 'package:sfl/app/core/widgets/default_appbar.dart';
import 'package:sfl/app/core/widgets/transparent_clip.dart';
import 'package:sfl/app/modules/about/about_page.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  final zoomDrawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
        controller: zoomDrawerController,
        androidCloseOnBackTap: true,
        borderRadius: 24.0,
        showShadow: true,
        angle: 0.0,
        menuBackgroundColor: MainColors.mainColor,
        slideWidth: MediaQuery.of(context).size.width *
            (intl.Bidi.isRtlLanguage(
                    Localizations.localeOf(context).languageCode)
                ? .45
                : 0.65),
        menuScreen: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            GFDrawerHeader(
              closeButton: SizedBox(),
              currentAccountPicture: GFAvatar(
                radius: 80.0,
                backgroundImage:
                    FirebaseAuth.instance.currentUser?.photoURL == null
                        ? null
                        : NetworkImage(
                            FirebaseAuth.instance.currentUser?.photoURL ?? ""),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Divider(
                    height: 10,
                    color: Colors.transparent,
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser?.displayName ?? "No name",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Divider(
                    height: 10,
                    color: Colors.transparent,
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser?.email ?? "No email",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
            ),
            GFListTile(
              color: Colors.white,
              icon: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Get.to(AboutPage(),
                    transition: Transition.circularReveal,
                    duration: Duration(milliseconds: 800));
              },
            ),
            GFListTile(
              color: Colors.white,
              icon: Icon(Icons.logout_rounded),
              title: Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
        mainScreen: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: DefaultAppbar(AppBar(
            leading: IconButton(
              icon: Icon(Icons.keyboard_option_key),
              onPressed: () {
                zoomDrawerController.toggle?.call(forceToggle: true);
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.camera_rounded,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                Obx(() {
                  return Text(
                    "${controller.last} images",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  );
                }),
              ],
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  icon: Icon(Icons.logout))
            ],
          )),
          body: Obx(() {
            return GridView.builder(
              controller: controller.cont,
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: [
                  QuiltedGridTile(2, 2),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 2),
                ],
              ),
              itemBuilder: (BuildContext context, int index) {
                var i = controller.items[index];
                var ic = i.ic ?? ImageController(i.url, i.id, i.furl);
                return Container(
                  color: Color.fromARGB(255, 0, 22, 54),
                  child: Stack(fit: StackFit.expand, children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(
                            SafeArea(
                              child: Hero(
                                tag: i.url,
                                child: TransparentClip(
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: CircularProgressIndicator(),
                                          ),
                                          Column(
                                            children: [
                                              Expanded(
                                                child: Material(
                                                  color: Colors.white,
                                                  clipBehavior: Clip.hardEdge,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.network(
                                                    i.furl,
                                                    fit: BoxFit.fill,
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress
                                                              ?.expectedTotalBytes ==
                                                          loadingProgress
                                                              ?.cumulativeBytesLoaded)
                                                        return child;
                                                      return Center(
                                                          child: LottieBuilder
                                                              .asset(
                                                                  "assets/loading_image.json"));
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  height: 60,
                                                  child: Center(
                                                    child: Material(
                                                        color: Colors.black12,
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Obx(() {
                                                            return ic
                                                                    .exist.value
                                                                ? GFIconButton(
                                                                    shape: GFIconButtonShape
                                                                        .circle,
                                                                    onPressed:
                                                                        () async {
                                                                      await ic
                                                                          .openImage();
                                                                    },
                                                                    type: GFButtonType
                                                                        .solid,
                                                                    icon: Icon(
                                                                      Icons
                                                                          .check,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  )
                                                                : ic.isBusy
                                                                        .value
                                                                    ? CircularProgressIndicator(
                                                                        backgroundColor:
                                                                            Colors.amber,
                                                                      )
                                                                    : GFIconButton(
                                                                        shape: GFIconButtonShape
                                                                            .circle,
                                                                        color: Color.fromARGB(
                                                                            117,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        onPressed:
                                                                            () =>
                                                                                {
                                                                          ic.startDownload()
                                                                        },
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .download,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      );
                                                          }),
                                                        )),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20))),
                              ),
                            ),
                            opaque: false);
                      },
                      child: Hero(
                        tag: i.url,
                        child: Image.network(
                          i.url,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Obx(() {
                        return ic.exist.value
                            ? GFIconButton(
                                shape: GFIconButtonShape.circle,
                                onPressed: () async {
                                  await ic.openImage();
                                },
                                type: GFButtonType.solid,
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              )
                            : ic.isBusy.value
                                ? CircularProgressIndicator(
                                    backgroundColor: Colors.amber,
                                  )
                                : GFIconButton(
                                    shape: GFIconButtonShape.circle,
                                    color: Color.fromARGB(117, 0, 0, 0),
                                    onPressed: () => {ic.startDownload()},
                                    icon: const Icon(
                                      Icons.download,
                                      color: Colors.white,
                                    ),
                                  );
                      }),
                    ),
                  ]),
                );
              },
              itemCount: controller.items.length,
            );
          }),
        ));
  }
}
