import 'dart:io';

import 'package:sfl/app/core/components/default_app_bar.dart';
import 'package:sfl/locator.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoGalleryWidgetPage extends StatefulWidget {
  const PhotoGalleryWidgetPage(
      {super.key,
      this.backgroundDecoration,
      this.onPageChanged,
      this.pageController,
      required this.galleryItems});
  final List<String> galleryItems;
  final PageController? pageController;
  final BoxDecoration? backgroundDecoration;
  final Function(int)? onPageChanged;
  @override
  State<PhotoGalleryWidgetPage> createState() => _PhotoGalleryWidgetPageState();
}

class _PhotoGalleryWidgetPageState extends State<PhotoGalleryWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(language().strings.images),
      body: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
      return PhotoViewGalleryPageOptions(
        imageProvider: (!widget.galleryItems[index].contains('http')
            ? FileImage(File(widget.galleryItems[index]))
            : NetworkImage(widget.galleryItems[index])) as ImageProvider,
        initialScale: PhotoViewComputedScale.contained * 1,
        heroAttributes:
            PhotoViewHeroAttributes(tag: widget.galleryItems[index]),
      );
        },
        itemCount: widget.galleryItems.length,
        loadingBuilder: (context, event) => Center(
      child: SizedBox(
        width: 20.0,
        height: 20.0,
        child: CircularProgressIndicator(
          value: event == null
              ? 0
              : event.cumulativeBytesLoaded /
                  (event.expectedTotalBytes ?? 1),
        ),
      ),
        ),
        backgroundDecoration: widget.backgroundDecoration,
        pageController: widget.pageController,
        onPageChanged: widget.onPageChanged,
      ),
    );
  }
}
