import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prop_mize/app/global_widgets/image_picker_option.dart';

class ImagePickerService {
  static final ImagePicker _imagePicker = ImagePicker();

  /// Show image source options (Gallery & Camera)
  static void showImageSourceOptions({
    required Function(ImageSource) onSourceSelected,
    String? galleryText,
    String? cameraText,
    IconData? galleryIcon,
    IconData? cameraIcon,
  }) {
    Get.bottomSheet(
      ImagePickerOption(
        onImageSelected: onSourceSelected,
        galleryText: galleryText,
        cameraText: cameraText,
        galleryIcon: galleryIcon,
        cameraIcon: cameraIcon,
      ),
      isScrollControlled: true,
    );
  }

  /// Pick image from gallery
  static Future<XFile?> pickFromGallery({
    double maxWidth = 800,
    double maxHeight = 800,
    int quality = 80,
  }) async {
    try {
      return await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: quality,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image from gallery: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  /// Pick image from camera
  static Future<XFile?> pickFromCamera({
    double maxWidth = 800,
    double maxHeight = 800,
    int quality = 80,
  }) async {
    try {
      return await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: quality,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to capture image: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  /// Direct method to show options and handle the result
  static Future<XFile?> showPickerAndGetImage({
    String? galleryText,
    String? cameraText,
    IconData? galleryIcon,
    IconData? cameraIcon,
    double maxWidth = 800,
    double maxHeight = 800,
    int quality = 80,
  }) async {
    final Completer<XFile?> completer = Completer();

    showImageSourceOptions(
      onSourceSelected: (ImageSource source) async {
        XFile? file;
        if (source == ImageSource.gallery) {
          file = await pickFromGallery(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            quality: quality,
          );
        } else {
          file = await pickFromCamera(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            quality: quality,
          );
        }
        completer.complete(file);
      },
      galleryText: galleryText,
      cameraText: cameraText,
      galleryIcon: galleryIcon,
      cameraIcon: cameraIcon,
    );

    return completer.future;
  }
}