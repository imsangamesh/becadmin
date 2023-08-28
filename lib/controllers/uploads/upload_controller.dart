import 'dart:io';

import 'package:becadmin/models/event_model.dart';
import 'package:becadmin/models/notes_model.dart';
import 'package:becadmin/models/question_model.dart';
import 'package:becadmin/screens/home/home_screen.dart';
import 'package:becadmin/utilities/constants.dart';
import 'package:becadmin/utilities/myDialogBox.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadController {
  // =======================  upload any file ===================
  static Future<String?> uploadAnyFile(
    File file,
    String pathId,
    String uploadFileName,
  ) async {
    try {
      MyDialogBox.loading(message: 'uploading...');
      TaskSnapshot taskSnapshot =
          await store.ref().child(uploadFileName).child(pathId).putFile(file);

      Get.back();
      return await taskSnapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      Get.back();
      MyDialogBox.defaultDialog(e.code, e.message.toString());
    } catch (e) {
      Get.back();
      MyDialogBox.normalDialog();
    }
    return null;
  }

  // ======================= questions firestore ===================
  static updQuestionsDataToFire(QuestionModel qm) async {
    try {
      MyDialogBox.loading(message: 'updating');
      await fire.collection('questionpapers').doc(qm.id).set(qm.toMap());

      Get.back();
      Get.back();
      MyDialogBox.showSnackBar('question papers uploaded !', yes: true);
    } on FirebaseException catch (e) {
      Get.back();
      MyDialogBox.defaultDialog(e.code, e.message.toString());
    } catch (e) {
      Get.back();
      MyDialogBox.normalDialog();
    }
  }

  // ======================= notes firestore ===================
  static updNotesDataToFire(NotesModel nm) async {
    try {
      MyDialogBox.loading(message: 'updating');
      await fire.collection('notes').doc(nm.id).set(nm.toMap());

      Get.back();
      Get.back();
      MyDialogBox.showSnackBar('Note uploaded !', yes: true);
    } on FirebaseException catch (e) {
      Get.back();
      MyDialogBox.defaultDialog(e.code, e.message.toString());
    } catch (e) {
      Get.back();
      MyDialogBox.normalDialog();
    }
  }

  // ======================= syllabus firestore ===================
  static updSyllabusDataToFire(String dept, String sem, String url) async {
    try {
      MyDialogBox.loading(message: 'updating');
      await fire.collection('syllabus').doc('$dept~$sem').set({
        'id': '$dept~$sem',
        'department': dept,
        'semester': sem,
        'link': url,
        'date': DateTime.now().toIso8601String(),
      });

      Get.back();
      Get.back();
      MyDialogBox.showSnackBar('Syllabus uploaded !', yes: true);
    } on FirebaseException catch (e) {
      Get.back();
      MyDialogBox.defaultDialog(e.code, e.message.toString());
    } catch (e) {
      Get.back();
      MyDialogBox.normalDialog();
    }
  }

  // ======================= timeTable firestore ===================
  static updTimeTableDataToFire(String dept, String sem, String url) async {
    try {
      MyDialogBox.loading(message: 'updating');
      await fire.collection('timetable').doc('$dept~$sem').set({
        'id': '$dept~$sem',
        'department': dept,
        'semester': sem,
        'link': url,
        'date': DateTime.now().toIso8601String(),
      });

      Get.back();
      Get.back();
      MyDialogBox.showSnackBar('Time table uploaded !', yes: true);
    } on FirebaseException catch (e) {
      Get.back();
      MyDialogBox.defaultDialog(e.code, e.message.toString());
    } catch (e) {
      Get.back();
      MyDialogBox.normalDialog();
    }
  }

  // ======================= upload event images ===================
  static Future<List<String>?> newEventImages(
    String title,
    List<XFile> images,
  ) async {
    try {
      List<String> imageUrls = [];
      MyDialogBox.loading(message: 'uploading...');

      for (int i = 0; i < images.length; i++) {
        TaskSnapshot taskSnapshot = await store
            .ref()
            .child('events')
            .child('$title _ $i')
            .putFile(File(images[i].path));

        imageUrls.add(await taskSnapshot.ref.getDownloadURL());
      }
      Get.back();
      return imageUrls;
    } on FirebaseException catch (e) {
      Get.back();
      MyDialogBox.defaultDialog(e.code, e.message.toString());
    } catch (e) {
      Get.back();
      MyDialogBox.normalDialog();
    }
    return null;
  }

  // ======================= events firestore ===================
  static updEventDataToFire(EventModel em) async {
    try {
      MyDialogBox.loading(message: 'updating');
      await fire.collection('events').doc(em.eid).set(em.toMap());

      Get.offAll(const HomeScreen());
      MyDialogBox.showSnackBar('new event updated.', yes: true, millSecs: 1800);
    } on FirebaseException catch (e) {
      Get.back();
      MyDialogBox.defaultDialog(e.code, e.message.toString());
    } catch (e) {
      Get.back();
      MyDialogBox.normalDialog();
    }
  }

  // ======================= upload Home images ===================
  static Future<List<String>?> multipleImages(
    // List<XFile> images,
    dynamic images,
    String refName,
  ) async {
    try {
      List<String> imageUrls = [];
      MyDialogBox.loading(message: 'uploading...');

      for (int i = 0; i < images.length; i++) {
        TaskSnapshot taskSnapshot = await store
            .ref()
            .child(refName)
            .child('images-$i')
            .putFile(File(images[i].path));

        imageUrls.add(await taskSnapshot.ref.getDownloadURL());
      }
      Get.back();
      return imageUrls;
    } on FirebaseException catch (e) {
      Get.back();
      MyDialogBox.defaultDialog(e.code, e.message.toString());
    } catch (e) {
      Get.back();
      MyDialogBox.normalDialog();
    }
    return null;
  }

  static updMultipleImagesDataToFire(
      List images, String collName, docName) async {
    try {
      MyDialogBox.loading(message: 'updating');
      await fire.collection(collName).doc(docName).set({'images': images});

      Get.offAll(const HomeScreen());
      MyDialogBox.showSnackBar('$collName updated !.', yes: true);
    } on FirebaseException catch (e) {
      Get.back();
      MyDialogBox.defaultDialog(e.code, e.message.toString());
    } catch (e) {
      Get.back();
      MyDialogBox.normalDialog();
    }
  }
}
