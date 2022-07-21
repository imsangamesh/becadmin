import 'package:becadmin/utilities/constants.dart';
import 'package:becadmin/utilities/my_buttons.dart';
import 'package:flutter/material.dart';

import '../screens/uploads/widgets/my_dropdown_dgnr.dart';

enum SearchMode { result, block }

class ResultAndExamBlock extends StatefulWidget {
  const ResultAndExamBlock(this.searchMode, {Key? key}) : super(key: key);

  final SearchMode searchMode;

  @override
  State<ResultAndExamBlock> createState() => _ResultAndExamBlockState();
}

class _ResultAndExamBlockState extends State<ResultAndExamBlock> {
  //
  final controller = TextEditingController();
  final List<String> semesters = [
    'P cycle',
    'C cycle',
    '3 semester',
    '4 semester',
    '5 semester',
    '6 semester',
    '7 semester',
    '8 semester',
  ];
  String currSem = 'P cycle';

  String get modeConfigure => widget.searchMode == SearchMode.result
      ? 'result'
      : widget.searchMode == SearchMode.block
          ? 'exam block'
          : '';

  uplaodData() async {
    final collName =
        widget.searchMode == SearchMode.result ? 'examresults' : 'block';
    await fire.collection(collName).doc(currSem).set({
      'name': currSem,
      'data': controller.text.trim(),
    });

    controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Result & Exam Seat')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          // ----------------------------- dropdown
          MyDropDownDgnr(
            'select semester',
            DropdownButton(
              dropdownColor: Colors.teal.shade100,
              underline: MyDropDownDgnr.transDivider, isExpanded: true,
              iconSize: 30,
              icon: const Icon(Icons.arrow_drop_down_circle_outlined),
              ////////////////
              value: currSem,
              items: semesters
                  .map((String items) => DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      ))
                  .toList(),
              onChanged: (String? newValue) {
                setState(() => currSem = newValue!);
              },
            ),
          ),

          // ----------------------------- dropdown
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: 25,
              decoration: InputDecoration(
                labelText: 'upload $modeConfigure json',
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(child: MyElevButton('Upload', uplaodData)),
        ]),
      ),
    );
  }
}
