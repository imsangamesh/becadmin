// import 'package:becadmin/screens/question/widgets/text_addOn_chip.dart';
// import 'package:becadmin/utilities/myDialogBox.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../controllers/questionController.dart';
// import '../../utilities/default_textfield.dart';
// import '../../utilities/myElevButton.dart';
// import '../home/utils/noticeBoard.dart';

// class QuestionScreen extends StatelessWidget {
//   QuestionScreen({Key? key}) : super(key: key);

//   final _deptController = TextEditingController();
//   final _semController = TextEditingController();
//   final _subController = TextEditingController();
//   final _testController = TextEditingController();

//   final questionController = Get.put(QuestionController());

//   save() async {
//     String dept = _deptController.text.trim();
//     String sem = _semController.text.trim();
//     String sub = _subController.text.trim();
//     String test = _testController.text.trim();
//     if (dept == '' || sem == '' || sub == '' || test == '') {
//       MyDialogBox.defaultDialog(
//         'Oops',
//         'hey, please fill all the fields and then submit.',
//       );
//       return;
//     }
//     // if (dept != '') questionController.addNewDept(dept);
//     // if (sem != '') questionController.addNewSem(dept, sem);
//     // if (sub != '') questionController.addNewSub(dept, sem, sub);
//     // if (dept != '') questionController.addNewTest(dept, sem, sub, test);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     Container textContainer({required Widget child}) {
//       return Container(
//         padding: const EdgeInsets.only(bottom: 5),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: theme.primaryColor.withAlpha(50),
//         ),
//         child: child,
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('edit QuestionScreen Papers'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 15),
//         child: SingleChildScrollView(
//             child: FutureBuilder(
//                 future: Get.find<QuestionController>().fetchAllData(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return NoticeBoard('', '', loading: true);
//                   }
//                   if (snapshot.hasError) {
//                     return NoticeBoard(
//                       'error',
//                       'an error occured !, please notify us while we work on it.',
//                     );
//                   }
//                   return Column(
//                     children: [
//                       //==================== department =====================
//                       ExpansionTile(
//                         title: textContainer(
//                           child: TextField(
//                             decoration: kDefaultTextFieldDecor(
//                               context,
//                               'department',
//                               Icons.short_text_rounded,
//                             ),
//                             controller: _deptController,
//                           ),
//                         ),
//                         children: [
//                           GetBuilder<QuestionController>(builder: (_) {
//                             return SizedBox(
//                               width: double.infinity,
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Wrap(
//                                   crossAxisAlignment: WrapCrossAlignment.start,
//                                   children: questionController.deptList
//                                       .map((each) => TextAddOnChip(
//                                           'dept', each, _deptController))
//                                       .toList(),
//                                 ),
//                               ),
//                             );
//                           }),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       //==================== semester =====================
//                       ExpansionTile(
//                         title: textContainer(
//                           child: TextField(
//                             decoration: kDefaultTextFieldDecor(
//                               context,
//                               'semseter',
//                               Icons.short_text_rounded,
//                             ),
//                             controller: _semController,
//                           ),
//                         ),
//                         children: [
//                           GetBuilder<QuestionController>(builder: (_) {
//                             return SizedBox(
//                               width: double.infinity,
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Wrap(
//                                   crossAxisAlignment: WrapCrossAlignment.start,
//                                   children: questionController.semList
//                                       .map((each) => TextAddOnChip(
//                                           'sem', each, _semController))
//                                       .toList(),
//                                 ),
//                               ),
//                             );
//                           }),
//                         ],
//                       ),

//                       const SizedBox(height: 10),
//                       //==================== subject =====================
//                       ExpansionTile(
//                         title: textContainer(
//                           child: TextField(
//                             decoration: kDefaultTextFieldDecor(
//                               context,
//                               'subject',
//                               Icons.short_text_rounded,
//                             ),
//                             controller: _subController,
//                           ),
//                         ),
//                         children: [
//                           GetBuilder<QuestionController>(builder: (_) {
//                             return SizedBox(
//                               width: double.infinity,
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Wrap(
//                                   crossAxisAlignment: WrapCrossAlignment.start,
//                                   children: questionController.subList
//                                       .map((each) => TextAddOnChip(
//                                           'sub', each, _subController))
//                                       .toList(),
//                                 ),
//                               ),
//                             );
//                           }),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       //==================== tests =====================
//                       ExpansionTile(
//                         title: textContainer(
//                           child: TextField(
//                             decoration: kDefaultTextFieldDecor(
//                               context,
//                               'test no',
//                               Icons.short_text_rounded,
//                             ),
//                             controller: _testController,
//                           ),
//                         ),
//                         children: [
//                           GetBuilder<QuestionController>(builder: (_) {
//                             return SizedBox(
//                               width: double.infinity,
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Wrap(
//                                   crossAxisAlignment: WrapCrossAlignment.start,
//                                   children: questionController.testList
//                                       .map((each) => TextAddOnChip(
//                                           'test', each, _testController))
//                                       .toList(),
//                                 ),
//                               ),
//                             );
//                           }),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       //==================== tests =====================
//                       MyElevButton('Submit', () {
//                         save();
//                       }),
//                     ],
//                   );
//                 })),
//       ),
//     );
//   }
// }
