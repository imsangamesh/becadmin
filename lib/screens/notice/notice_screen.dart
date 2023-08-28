import 'dart:io';

import 'package:becadmin/controllers/uploads/upload_controller.dart';
import 'package:becadmin/utilities/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/uploads/notice_Controller.dart';
import '../../utilities/myDialogBox.dart';
import '../../utilities/my_buttons.dart';
import '../home/utils/noticeBoard.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  //
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _linkCntr = TextEditingController();
  final getCntr = Get.put(NoticeController());

  bool _attachFiles = false;
  List<PlatformFile> files = [];
  List<String> fileUrls = [];

  bool _attachImages = false;
  List<XFile> images = [];
  List<String> imageUrls = [];

  updateNotice() async {
    if (_attachFiles && files.isEmpty) {
      MyDialogBox.defaultDialog(
        'Oops',
        'please upload files, else untick the attach-file-ticker',
      );
      return;
    }
    if (_attachImages && images.isEmpty) {
      MyDialogBox.defaultDialog(
        'Oops',
        'please upload images, else untick the add-image-ticker',
      );
      return;
    }
    if (_titleController.text.trim() == '' ||
        _bodyController.text.trim() == '') {
      MyDialogBox.defaultDialog(
        'Oops !',
        'hey, please fill out your new notice to be displayed and then submit.',
      );
      return;
    }
    if (_attachFiles) await uploadFiles(files);
    if (_attachImages) await uploadImages(images);
    await getCntr.updateNotice(
      _titleController.text.trim(),
      _bodyController.text.trim(),
      fileUrls: fileUrls,
      imageUrls: imageUrls,
      link: _linkCntr.text.trim(),
    );
    _titleController.text = '';
    _bodyController.text = '';
    Get.back();
  }

  // ====================== files
  pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );
    if (result == null) {
      MyDialogBox.showSnackBar('you didn\'t pick any files', yes: false);
      return;
    }
    setState(() => files = result.files);
  }

  uploadFiles(List<PlatformFile> uploadfiles) async {
    List<String>? urlListR =
        await UploadController.multipleImages(uploadfiles, 'noticefiles');

    if (urlListR == null || urlListR.isEmpty) return;
    setState(() => fileUrls = urlListR);
  }

  // ====================== images
  // pickImages() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //     allowMultiple: true,
  //   );
  //   if (result == null) {
  //     MyDialogBox.showSnackBar('you didn\'t pick any images', yes: false);
  //     return;
  //   }
  //   setState(() => images = result.files);
  // }

  pickImages() async {
    final result = await ImagePicker().pickMultiImage();

    if (result.isEmpty) {
      MyDialogBox.showSnackBar('you didn\'t pick any images', yes: false);
      return;
    }

    setState(() => images = result);
  }

  uploadImages(List<XFile> uploadImages) async {
    List<String>? urlListR =
        await UploadController.multipleImages(uploadImages, 'noticeimages');

    if (urlListR == null || urlListR.isEmpty) return;
    setState(() => imageUrls = urlListR);
  }

  @override
  void initState() {
    Get.find<NoticeController>().fetchNoticeData();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _linkCntr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('edit notice board')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(children: [
            const Row(
              children: [
                Text('  current notice :', style: kSmallSizeBoldTextStyle)
              ],
            ),
            const SizedBox(height: 3),
            // ----------------notice board----------------------
            GetBuilder<NoticeController>(
              init: NoticeController(),
              builder: (notData) {
                return NoticeBoard(
                  notData.noticeTitle,
                  notData.noticeBody,
                );
              },
            ),

            const SizedBox(height: 20),
            // ----------------title----------------------
            TextField(
              decoration: InputDecoration(
                labelText: 'new notice title',
                icon: Icon(
                  Icons.short_text_rounded,
                  size: 35,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              controller: _titleController,
              maxLength: 30,
            ),
            // ----------------body-----------------------
            TextField(
              decoration: InputDecoration(
                labelText: 'new notice body',
                icon: Icon(
                  Icons.notes,
                  size: 35,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              controller: _bodyController,
              maxLines: 3,
            ),
            // ----------------link----------------------
            TextField(
              decoration: InputDecoration(
                labelText: 'any useful links',
                icon: Icon(
                  Icons.link,
                  size: 35,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              controller: _linkCntr,
            ),
            const SizedBox(height: 15),
            // ----------------file check box-----------------------
            CheckboxListTile(
              title: Row(children: ifFilesSelectedContent),
              tileColor: Theme.of(context).primaryColor.withAlpha(50),
              value: _attachFiles,
              onChanged: (val) => setState(() => _attachFiles = val ?? false),
            ),
            const SizedBox(height: 5),
            if (files.isNotEmpty)
              Text(
                '${files.length} files selected',
                style: kNormalSizeBoldTextStyle,
              ),
            const SizedBox(height: 15),
            // ----------------image check box-----------------------
            CheckboxListTile(
              title: Row(children: isImagesSelectedContent),
              tileColor: Theme.of(context).primaryColor.withAlpha(50),
              value: _attachImages,
              onChanged: (val) => setState(() => _attachImages = val ?? false),
            ),
            const SizedBox(height: 5),
            if (images.isNotEmpty)
              Wrap(
                children: images
                    .map((e) => Container(
                          margin: const EdgeInsets.all(5),
                          height: 100,
                          width: 100,
                          child: Image.file(File(e.path), fit: BoxFit.cover),
                        ))
                    .toList(),
              ),
            const SizedBox(height: 20),
            // ----------------elevated-----------------------
            MyElevButton(' Update ', updateNotice),
          ]),
        ),
      ),
    );
  }

  List<Widget> get isImagesSelectedContent {
    return [
      const Text('Add Images ?', style: kNormalSizeTextStyle),
      const Spacer(),
      if (_attachImages)
        MyOutLButton(
          'Pick Images',
          pickImages,
          textStyle: kSmallSizeBoldTextStyle,
        ),
    ];
  }

  List<Widget> get ifFilesSelectedContent {
    return [
      const Text('Attach a file ?', style: kNormalSizeTextStyle),
      const Spacer(),
      if (_attachFiles)
        MyOutLButton(
          'Pick Files',
          pickFiles,
          textStyle: kSmallSizeBoldTextStyle,
        ),
    ];
  }
}
