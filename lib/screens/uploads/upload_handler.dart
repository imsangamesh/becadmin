import 'dart:io';

import 'package:becadmin/controllers/uploads/upload_controller.dart';
import 'package:becadmin/helpers/upload_helper.dart';
import 'package:becadmin/models/notes_model.dart';
import 'package:becadmin/models/question_model.dart';
import 'package:becadmin/screens/uploads/widgets/my_custom_chip.dart';
import 'package:becadmin/utilities/constants.dart';
import 'package:becadmin/utilities/myDialogBox.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

enum UploadMode { questionPaper, note, syllabus, timetable }

class UploadHandler extends StatefulWidget {
  const UploadHandler({
    required this.mode,
    this.qm,
    this.nm,
    this.sylDept,
    this.sylSem,
    Key? key,
  }) : super(key: key);

  final QuestionModel? qm;
  final NotesModel? nm;
  final UploadMode mode;
  final String? sylDept, sylSem;

  @override
  State<UploadHandler> createState() => _UploadHandlerState();
}

class _UploadHandlerState extends State<UploadHandler> {
  //
  bool isUploaded = false;

  openFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf'],
      type: FileType.custom,
    );
    if (result == null) {
      MyDialogBox.showSnackBar('you didn\'t pick any files !', yes: false);
      return;
    }

    final platFile = result.files.first;
    // OpenFile.open(platFile.path);

    final file = File(platFile.path!);
    if (widget.mode == UploadMode.questionPaper) questionUploadHandler(file);
    if (widget.mode == UploadMode.note) notesUploadHandler(file);
    if (widget.mode == UploadMode.syllabus) syllabusUploadHandler(file);
    if (widget.mode == UploadMode.timetable) timeTableUploadHandler(file);
  }

  questionUploadHandler(File file) async {
    final pathId =
        '${widget.qm!.dept}~${widget.qm!.sem}~${widget.qm!.sub}~${widget.qm!.testNo}~${widget.qm!.year}';

    final String? downUrl =
        await UploadController.uploadAnyFile(file, pathId, 'questionpapers');

    if (downUrl == null) return;

    final newQM = QuestionModel(
      id: pathId,
      dept: widget.qm!.dept,
      sem: widget.qm!.sem,
      sub: widget.qm!.sub,
      testNo: widget.qm!.testNo,
      year: widget.qm!.year,
      link: downUrl,
      date: DateTime.now().toIso8601String(),
      tag: pathId.split('~').sublist(0, 3).join('~'),
    );

    UploadController.updQuestionsDataToFire(newQM);
  }

  notesUploadHandler(File file) async {
    final pathId =
        '${widget.nm!.dept}~${widget.nm!.sem}~${widget.nm!.sub}~${widget.nm!.chapterName}';

    final String? downUrl =
        await UploadController.uploadAnyFile(file, pathId, 'notes');

    if (downUrl == null) return;

    final newNM = NotesModel(
      id: pathId,
      chapterName: widget.nm!.chapterName,
      dept: widget.nm!.dept,
      sem: widget.nm!.sem,
      sub: widget.nm!.sub,
      link: downUrl,
      date: DateTime.now().toIso8601String(),
      tag: pathId.split('~').sublist(0, 3).join('~'),
    );

    UploadController.updNotesDataToFire(newNM);
  }

  syllabusUploadHandler(File file) async {
    final pathId = '${widget.sylDept}~${widget.sylSem}';

    final String? downUrl =
        await UploadController.uploadAnyFile(file, pathId, 'syllabus');
    if (downUrl == null) return;

    UploadController.updSyllabusDataToFire(
      widget.sylDept!,
      widget.sylSem!,
      downUrl,
    );
  }

  timeTableUploadHandler(File file) async {
    final pathId = '${widget.sylDept}~${widget.sylSem}';

    final String? downUrl =
        await UploadController.uploadAnyFile(file, pathId, 'timetable');
    if (downUrl == null) return;

    UploadController.updTimeTableDataToFire(
      widget.sylDept!,
      widget.sylSem!,
      downUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> currModeChipList =
        widget.mode == UploadMode.questionPaper
            ? [
                MyCustomChip(widget.qm!.dept!),
                MyCustomChip(widget.qm!.sem!),
                MyCustomChip(widget.qm!.sub!),
                MyCustomChip(widget.qm!.testNo!),
                MyCustomChip(widget.qm!.year!),
              ]
            : widget.mode == UploadMode.note
                ? [
                    MyCustomChip(widget.nm!.dept!),
                    MyCustomChip(widget.nm!.sem!),
                    MyCustomChip(widget.nm!.sub!),
                    MyCustomChip(widget.nm!.chapterName!),
                  ]
                : [
                    MyCustomChip(widget.sylDept!),
                    MyCustomChip(widget.sylSem!),
                  ];

    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Upload new ${configureUploadType(widget.mode)}',
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
        child: Center(
            child: Column(
          children: [
            RichText(
              text: TextSpan(
                text: 'please pick pdf file of your new  ',
                style: kSmallSizeTextStyle.copyWith(color: Colors.black),
                children: [
                  TextSpan(
                    text: configureUploadType(widget.mode),
                    style: kPSmallSizeBoldTextStyle,
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: currModeChipList,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: openFile,
              icon: const Icon(Icons.note_add),
              label: const Text('Pick File'),
            ),
          ],
        )),
      ),
    );
  }
}
