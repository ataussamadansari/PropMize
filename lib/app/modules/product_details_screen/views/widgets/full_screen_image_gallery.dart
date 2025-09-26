import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullscreenImageGallery extends StatelessWidget
{
  final List<String> images;
  final int initialIndex;

  const FullscreenImageGallery(
      {super.key, required this.images, this.initialIndex = 0});

  @override
  Widget build(BuildContext context)
  {
    final PageController pageController =
    PageController(initialPage: initialIndex);
    return Scaffold(
        floatingActionButton: FloatingActionButton(backgroundColor: context.iconColor, onPressed: () => Get.back(), child: Icon(Icons.close)),
        body: PhotoViewGallery.builder(
            itemCount: images.length,
            pageController: pageController,
            builder: (context, index)
            {
              return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(images[index]),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 3
              );
            },
            loadingBuilder: (context, event) => const Center(
                child: CircularProgressIndicator(color: Colors.white)
            )
        )
    );
  }
}