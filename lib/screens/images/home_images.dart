import 'package:becadmin/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'package:becadmin/controllers/uploads/upload_controller.dart';
import 'package:file_picker/file_picker.dart';

import '../../utilities/myDialogBox.dart';
import '../../utilities/my_buttons.dart';
import '../gallery/upload_events.dart';

class HomeImages extends StatefulWidget {
  const HomeImages({Key? key}) : super(key: key);

  @override
  State<HomeImages> createState() => _HomeImagesState();
}

class _HomeImagesState extends State<HomeImages> {
  List<PlatformFile> imageList = [];

  pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result == null) {
      MyDialogBox.showSnackBar('you didn\'t pick any images', yes: false);
      return;
    }
    setState(() => imageList = result.files);
  }

  submitImages() async {
    List? imageUrls = await UploadController.multipleImages(
      imageList,
      'homeimages',
    );
    if (imageUrls == null) return;

    UploadController.updMultipleImagesDataToFire(
      imageUrls,
      'homeimages',
      'homeimages',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Images'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const Text(
            'select as many as images in the order.',
            style: kNormalSizeTextStyle,
          ),
          const SizedBox(height: 20),
          MyOutLButton('Pick Images', pickImages),
          const SizedBox(height: 20),
          Wrap(
            children: imageList.map((each) => EventImage(each.path!)).toList(),
          ),
          const SizedBox(height: 20),
          if (imageList.isNotEmpty) MyElevButton('Upload', submitImages),
        ]),
      ),
    );
  }
}
