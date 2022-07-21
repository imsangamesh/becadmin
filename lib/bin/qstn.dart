// import 'package:becadmin/screens/question/upload_questions.dart';
// import 'package:becadmin/utilities/default_textfield.dart';
// import 'package:flutter/cupertino.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../screens/question/widgets/text_addOn_chip.dart';

// class QuestionScreen extends StatefulWidget {
//   const QuestionScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<QuestionScreen> createState() => _QuestionScreenState();
// }

// class _QuestionScreenState extends State<QuestionScreen> {
//   //
//   final _pathController = TextEditingController();
//   final _newKeyController = TextEditingController();
//   final questionController = Get.put(QuestionController());

//   bool _showKbd = false;

//   // addKey(BuildContext ctx) {
//   //   // questionController.addNewPathKey(_newKeyController.text);
//   //   // FocusScope.of(ctx).unfocus();
//   //   // _newKeyController.text = '';
//   // }

//   // @override
//   // void initState() {
//   //   Future.delayed(const Duration(milliseconds: 10)).then((value) {
//   //     questionController.fetchKeyPaths();
//   //   });
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final size = MediaQuery.of(context).size;

//     Container textContainer({required Widget child}) {
//       return Container(
//         padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: theme.primaryColor.withAlpha(50),
//         ),
//         child: child,
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('edit Question Papers'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: SizedBox(
//           height: size.height,
//           width: size.width,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     const Text('show keyboard ',
//                         style: TextStyle(fontSize: 17)),
//                     CupertinoSwitch(
//                       activeColor: theme.primaryColor,
//                       value: _showKbd,
//                       onChanged: (val) => setState(() => _showKbd = val),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 //==================== path creator =====================
//                 textContainer(
//                   child: TextField(
//                     decoration: kDefaultTextFieldDecor(
//                       context,
//                       'create new path',
//                       Icons.short_text_rounded,
//                     ).copyWith(
//                         suffixIcon: IconButton(
//                       icon: const Icon(Icons.add_circle_outline_rounded,
//                           size: 30),
//                       onPressed: () {
//                         // addKey(context);
//                       },
//                     )),
//                     controller: _newKeyController,
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 //==================== append path =====================
//                 textContainer(
//                   child: TextField(
//                     decoration: kDefaultTextFieldDecor(
//                       context,
//                       'path where you wanna add qp',
//                       Icons.library_books,
//                     ),
//                     maxLines: 4,
//                     readOnly: !_showKbd,
//                     showCursor: true,
//                     controller: _pathController,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 //==================== Path Wrap =====================
//                 GetBuilder<QuestionController>(builder: (qstnData) {
//                   return SizedBox(
//                     width: double.infinity,
//                     child: Wrap(
//                       crossAxisAlignment: WrapCrossAlignment.start,
//                       children: questionController.deptList
//                           .map((e) => TextAddOnChip('sub', e, _pathController))
//                           .toList(),
//                     ),
//                   );
//                 })
//               ],
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.to(() => UploadQuestionScreen(_pathController.text));
//         },
//         child: const Icon(Icons.chevron_right_rounded, size: 43),
//       ),
//     );
//   }
// }
