import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/common/console.dart';
import 'package:home_services_provider/common/ui.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDialog extends StatefulWidget {
  const ImagePickerDialog({Key key, this.title}) : super(key: key);
  final String title;

  static Future show() async {
    return Get.bottomSheet(ImagePickerDialog());
  }

  @override
  _ImagePickerDialogState createState() => _ImagePickerDialogState();
}

class _ImagePickerDialogState extends State<ImagePickerDialog> {
  Future _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile image = await _picker.pickImage(source: source);
    if (image != null) {
      Console.log("image.path ${image.path}");
      await Get.back(result: image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: Ui.getBoxDecoration(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          widget.title ?? 'Pick Image',
          style: TextStyle(color: context.theme.accentColor),
        ).paddingAll(24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => _pickImage(ImageSource.camera),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera,
                    size: 50,
                    color: Get.theme.colorScheme.primary,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Camera',
                    style: Get.textTheme.bodyText2,
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _pickImage(ImageSource.gallery),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.collections,
                      size: 50,
                      color: Get.theme.colorScheme.primary,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Gallery')
                  ]),
            ),
          ],
        ),
      ]),
    );
  }
}
