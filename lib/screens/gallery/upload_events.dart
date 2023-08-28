import 'dart:io';

import 'package:becadmin/controllers/uploads/upload_controller.dart';
import 'package:becadmin/models/event_model.dart';
import 'package:becadmin/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';

import '../../utilities/myDialogBox.dart';

class UploadEvents extends StatefulWidget {
  const UploadEvents(this.evm, {Key? key}) : super(key: key);

  final EventModel evm;

  @override
  State<UploadEvents> createState() => _UploadEventsState();
}

class _UploadEventsState extends State<UploadEvents> {
  //
  List<XFile> imageList = [];

  // pickImages() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //     allowMultiple: true,
  //   );
  //   if (result == null) {
  //     MyDialogBox.showSnackBar('you didn\'t pick any images', yes: false);
  //     return;
  //   }
  //   setState(() => imageList = result.files);
  // }

  pickImages() async {
    final result = await ImagePicker().pickMultiImage();

    if (result.isEmpty) {
      MyDialogBox.showSnackBar('you didn\'t pick any images', yes: false);
      return;
    }

    setState(() => imageList = result);
  }

  submitImages() async {
    List? imageUrls =
        await UploadController.newEventImages(widget.evm.title!, imageList);

    if (imageUrls == null) return;

    UploadController.updEventDataToFire(EventModel(
      eid: widget.evm.eid,
      title: widget.evm.title,
      date: widget.evm.date,
      images: imageUrls,
      description: widget.evm.description,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Event Pics')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(children: [
            const SizedBox(height: 20),
            const Text(
              'please choose multiple images all at once and upload.',
              style: kSmallSizeBoldTextStyle,
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: pickImages,
              icon: const Icon(Icons.add_photo_alternate_rounded),
              label: const Text(' Pick Images '),
            ),
            const SizedBox(height: 30),
            //
            if (imageList.isNotEmpty)
              const Text(
                'your selected images : ',
                style: kSmallSizeBoldTextStyle,
              ),
            //
            const SizedBox(height: 10),
            if (imageList.isNotEmpty)
              Wrap(
                children: imageList
                    .map((eachPlatFile) => EventImage(eachPlatFile.path))
                    .toList(),
              ),
            if (imageList.isNotEmpty) const SizedBox(height: 20),
            //
            if (imageList.isNotEmpty)
              ElevatedButton(
                onPressed: submitImages,
                child: const Text(' Upload '),
              ),
            //
          ]),
        ),
      ),
    );
  }
}

class EventImage extends StatelessWidget {
  const EventImage(
    this.imagePath, {
    Key? key,
  }) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final priClr = Theme.of(context).primaryColor;
    return InkWell(
      splashColor: priClr,
      onTap: () => OpenFile.open(imagePath),
      child: Container(
        height: 100,
        width: 100,
        color: priClr,
        margin: const EdgeInsets.all(2),
        child: Image.file(File(imagePath), fit: BoxFit.cover),
      ),
    );
  }
}
