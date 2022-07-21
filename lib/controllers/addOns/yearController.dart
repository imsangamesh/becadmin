import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilities/myDialogBox.dart';

class YearController extends GetxController {
  //
  List<String> yearList = [];

  List<String> get getYearList {
    return yearList;
  }

  Future<void> addNewYear(String yearR) async {
    if (yearR.trim() == '') {
      MyDialogBox.defaultDialog(
        'Oops !',
        'hey, please provide your new year\'s name and then submit.',
      );
      return;
    }

    try {
      yearList.insert(0, yearR);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('years', yearList);
    } catch (e) {
      MyDialogBox.normalDialog();
    }
    update();
  }

  Future<void> fetchYears() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      yearList = prefs.getStringList('years') ?? [];
    } catch (e) {
      MyDialogBox.normalDialog();
    }
    update();
  }

  deleteExistingYear(String yearR) async {
    try {
      yearList.remove(yearR);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('years', yearList);
    } catch (e) {
      MyDialogBox.normalDialog();
    }
    update();
  }
}
