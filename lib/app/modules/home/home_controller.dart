import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sfl/app/core/base_controller.dart';

  //TODO Heavy cleanup and create a channels service class. :( man i hope i find a job that worth all this
class ImageController extends BaseController {
  final String url;
  final String id;
  final String furl;
  final progress = 0.obs;
  final exist = false.obs;
  String path = "";
  static String? dirPath;
  String get name => "sfl image $id.png";
  
  ImageController(this.url, this.id, this.furl);
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
  MyItem(this.name, this.url, this.id, this.furl);
  late ImageController ic = ImageController(url, id, furl);
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
      for (var i = 0; i <= n; i++) {
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
