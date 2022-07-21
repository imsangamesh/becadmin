import 'package:becadmin/utilities/constants.dart';
import 'package:becadmin/utilities/myDialogBox.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NoticeController extends GetxController {
  String noticeTitle = 'hey there';
  String noticeBody = 'fetching ...';
  String noticeDate = DateFormat.yMd().format(DateTime.now());

  Future<void> updateNotice(
    String titleR,
    String bodyR, {
    List? fileUrls,
    List? imageUrls,
    String? link,
  }) async {
    try {
      MyDialogBox.progressIndctr();

      await fire.collection('notice').doc('notice').set({
        'title': titleR,
        'body': bodyR,
        'images': imageUrls,
        'files': fileUrls,
        'date': DateTime.now().toIso8601String(),
        'link': link ?? '',
      });

      noticeTitle = titleR;
      noticeBody = bodyR;

      Get.back();
      MyDialogBox.showSnackBar('notice updated !', yes: true);
    } catch (e) {
      Get.back();
      MyDialogBox.normalDialog();
    }
    update();
  }

  Future<void> fetchNoticeData() async {
    try {
      final docSnap = await fire.collection('notice').doc('notice').get();
      final snapData = docSnap.data() as Map<String, dynamic>;

      noticeTitle = snapData['title'];
      noticeBody = snapData['body'];
      update();
    } catch (e) {
      MyDialogBox.normalDialog();
    }
  }
}
