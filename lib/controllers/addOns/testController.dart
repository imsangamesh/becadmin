import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilities/myDialogBox.dart';

class TestController extends GetxController {
  //
  List<String> testList = [];

  List<String> get getTestList {
    return testList;
  }

  Future<void> addNewTest(String testR) async {
    if (testR.trim() == '') {
      MyDialogBox.defaultDialog(
        'Oops !',
        'hey, please provide your new test\'s name and then submit.',
      );
      return;
    }

    try {
      testList.insert(0, testR);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('tests', testList);
      update();
    } catch (e) {
      MyDialogBox.normalDialog();
    }
  }

  Future<void> fetchTests() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      testList = prefs.getStringList('tests') ?? [];
    } catch (e) {
      MyDialogBox.normalDialog();
    }
    update();
  }

  deleteExistingTest(String testR) async {
    try {
      testList.remove(testR);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('tests', testList);
    } catch (e) {
      MyDialogBox.normalDialog();
    }
    update();
  }
}
