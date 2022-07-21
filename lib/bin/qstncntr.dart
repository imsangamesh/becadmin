// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../utilities/myDialogBox.dart';

// class dsfsdfsd extends GetxController {
//   List<String> keyPaths = ['heldfdslo', 'san', 'hello', 'san'];

//   Future<void> fetchKeyPaths() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     keyPaths = prefs.getStringList('keypaths') ?? [];
//     update();
//   }

//   addNewPathKey(String pathRec) async {
//     if (pathRec.trim() == '') {
//       MyDialogBox.defaultDialog(
//         'Oops',
//         'hey please enter any path before you add it,',
//       );
//       return;
//     }
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> newlist = [...keyPaths, pathRec];
//     prefs.setStringList('keypaths', newlist);

//     keyPaths.add(pathRec);
//     update();
//   }

//   deleteExistiongPathKey(String pathRec) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     keyPaths.remove(pathRec);
//     prefs.setStringList('keypaths', keyPaths);
//     update();
//   }
// }
