import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/drawer/gf_drawer.dart';
import 'package:getwidget/components/drawer/gf_drawer_header.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/position/gf_position.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sfl/app/core/base_controller.dart';
import 'package:sfl/app/core/theme/main_colors.dart';

class ImageController extends BaseController {
  final String url;
  final String id;
  final String furl;
  final progress = 0.obs;
  final exist = false.obs;
  String path = "";
  static String? dirPath;
  var name;
  ImageController(this.url, this.id, this.furl) {
    name = "sfl image $id.png";
  }
  Future checkExist() async {
    if (dirPath == null) {
      const platform = MethodChannel('sfl.flutter.dev/downloadf');
      dirPath = await platform.invokeMethod<String>("getpath");
    }
    path = "$dirPath/$name";
    exist.value = await File(path).exists();
  }

  Future openImage() async {
    OpenFile.open(path);
  }

  void startDownload() async {
    isBusy.value = true;
    update();
    try {
      if (!await Permission.storage.request().isGranted) return;

      /* final ByteData imageData =
          await NetworkAssetBundle(Uri.parse(furl)).load("");
      final Uint8List bytes = imageData.buffer.asUint8List();
      final dirs = (await getExternalStorageDirectories(
          type: StorageDirectory.downloads));
      final directory = dirs?.first;
      final fpath = '${directory?.path}/$id.png';
      var _transferedImage = File(fpath);
      await _transferedImage.writeAsBytes(bytes);
 */
      const platform = MethodChannel('sfl.flutter.dev/downloadf');
      await platform.invokeMethod("downloadImage", {"furl": furl, "id": name});
      await checkExist();
    } on PlatformException catch (error) {
      Get.snackbar("failed", "Cant download image");
    } catch (error) {
      Get.snackbar("failed", "Cant download image");
    } finally {
      isBusy.value = false;
    }
  }
}

class MyItem {
  MyItem(this.name, this.url, this.id, this.furl) {
    ic = ImageController(url, id, furl);
  }
  ImageController? ic;
  final String name;

  final String url;
  final String furl;
  final String id;
}

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final items = List<MyItem>.empty(growable: true).obs;
  final last = 0.obs;
  var cont = ScrollController();
  @override
  void onInit() {
    addItems(15);
    cont.addListener(() {
      if (cont.offset >= cont.position.maxScrollExtent &&
          !cont.position.outOfRange) {
        Get.showSnackbar(const GetSnackBar(
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
          messageText: Text(
            "Loading more",
            style: TextStyle(color: Colors.white),
          ),
        ));
        addItems(15);
      }
    });
    super.onInit();
  }

  void addItems(int n) async {
    //Size in physical pixels
    var physicalScreenSize = window.physicalSize;
    var physicalWidth = physicalScreenSize.width.toInt() + 200;
    var physicalHeight = physicalScreenSize.height.toInt() + 200;
    Future.microtask(() async {
      for (var i = 0; i < n; i++) {
        last.value++;
        var it = MyItem(
            "Image $last",
            "https://picsum.photos/id/${(last.value + 9)}/400/600",
            "${(last.value + 9)}",
            "https://picsum.photos/id/${(last.value + 9)}/$physicalWidth/$physicalHeight");
        await it.ic?.checkExist();
        items.add(it);
      }
    });
  }
}
