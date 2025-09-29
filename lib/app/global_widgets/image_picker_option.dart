import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerOption extends StatelessWidget
{
    final Function(ImageSource) onImageSelected;
    final String? galleryText;
    final String? cameraText;
    final IconData? galleryIcon;
    final IconData? cameraIcon;

    const ImagePickerOption({
        super.key,
        required this.onImageSelected,
        this.galleryText,
        this.cameraText,
        this.galleryIcon,
        this.cameraIcon
    });

    @override
    Widget build(BuildContext context) 
    {
        return Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)
                )
            ),
            child: Wrap(
                children: [
                    ListTile(
                        leading: Icon(cameraIcon ?? Icons.photo_camera),
                        title: Text(cameraText ?? 'Camera'),
                        onTap: ()
                        {
                            Get.back();
                            onImageSelected(ImageSource.camera);
                        }
                    ),
                    ListTile(
                        leading: Icon(galleryIcon ?? Icons.photo_library),
                        title: Text(galleryText ?? 'Gallery'),
                        onTap: ()
                        {
                            Get.back();
                            onImageSelected(ImageSource.gallery);
                        }
                    )

                ]
            )
        );
    }
}
