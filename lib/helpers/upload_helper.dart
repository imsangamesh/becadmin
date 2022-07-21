import 'package:becadmin/screens/uploads/upload_handler.dart';

String configureUploadType(UploadMode uploadMode) {
  return uploadMode == UploadMode.questionPaper
      ? 'Question Paper'
      : uploadMode == UploadMode.note
          ? 'Note'
          : uploadMode == UploadMode.syllabus
              ? 'Syllabus'
              : uploadMode == UploadMode.timetable
                  ? 'Time table'
                  : '';
}
