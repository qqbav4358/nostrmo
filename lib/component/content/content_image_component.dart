import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

import '../../consts/base.dart';

class ContentImageComponent extends StatelessWidget {
  String imageUrl;

  List<String>? imageList;

  int imageIndex;

  double? width;

  double? height;

  BoxFit imageBoxFix;

  ContentImageComponent({
    required this.imageUrl,
    this.imageList,
    this.imageIndex = 0,
    this.width,
    this.height,
    this.imageBoxFix = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.maxFinite,
      height: height,
      margin: const EdgeInsets.only(
        top: Base.BASE_PADDING_HALF / 2,
        bottom: Base.BASE_PADDING_HALF / 2,
      ),
      child: GestureDetector(
        onTap: () {
          previewImages(context);
        },
        child: Center(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: imageBoxFix,
            width: width ?? double.maxFinite,
            height: height,
            // placeholder: (context, url) => CircularProgressIndicator(),
            placeholder: (context, url) => Container(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  void previewImages(context) {
    if (imageList != null && imageList!.isNotEmpty) {
      List<ImageProvider> imageProviders = [];
      for (var imageUrl in imageList!) {
        imageProviders.add(CachedNetworkImageProvider(imageUrl));
      }

      MultiImageProvider multiImageProvider =
          MultiImageProvider(imageProviders, initialIndex: imageIndex);

      showImageViewerPager(context, multiImageProvider, onPageChanged: (page) {
        // print("page changed to $page");
      }, onViewerDismissed: (page) {
        // print("dismissed while on page $page");
      });
    }
  }
}
