import 'package:becadmin/helpers/data.dart';
import 'package:becadmin/models/notes_model.dart';
import 'package:becadmin/models/question_model.dart';
import 'package:becadmin/screens/uploads/upload_handler.dart';
import 'package:becadmin/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/upload_helper.dart';
import 'widgets/my_dropdown_dgnr.dart';

class PathSelector extends StatefulWidget {
  const PathSelector(
    this.mode, {
    Key? key,
  }) : super(key: key);

  final UploadMode mode;

  @override
  State<PathSelector> createState() => _PathSelectorState();
}

class _PathSelectorState extends State<PathSelector> {
  final TextEditingController _nameController = TextEditingController();
  bool _isFilled = false;

  void _submitForm() {
    if (widget.mode == UploadMode.questionPaper) {
      Get.to(
        () => UploadHandler(
          mode: widget.mode,
          qm: QuestionModel(
            id: '',
            dept: currDept,
            sem: currSem,
            sub: currSub,
            year: currYear,
            testNo: currTest,
            link: '',
            date: '',
          ),
        ),
      );
    } else if (widget.mode == UploadMode.note) {
      if (!_isFilled) return;

      Get.to(
        () => UploadHandler(
          mode: widget.mode,
          nm: NotesModel(
            id: '',
            chapterName: _nameController.text,
            dept: currDept,
            sem: currSem,
            sub: currSub,
            link: '',
            date: '',
          ),
        ),
      );
    } else if (widget.mode == UploadMode.syllabus) {
      Get.to(
        () => UploadHandler(
          mode: widget.mode,
          sylDept: currDept,
          sylSem: currSem,
        ),
      );
    } else if (widget.mode == UploadMode.timetable) {
      Get.to(
        () => UploadHandler(
          mode: widget.mode,
          sylDept: currDept,
          sylSem: currSem,
        ),
      );
    }
  }

  @override
  void initState() {
    setTestandYear();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload new ${configureUploadType(widget.mode)}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ---------------------------------department---------------

              MyDropDownDgnr(
                'select department',
                DropdownButton(
                  dropdownColor: Colors.teal.shade100,
                  underline: MyDropDownDgnr.transDivider, isExpanded: true,
                  iconSize: 30,
                  icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                  ////////////////
                  value: currDept,
                  items: departments
                      .map((String items) => DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() => currDept = newValue!);
                    selectDepartment(newValue!);
                  },
                ),
              ),
              // ---------------------------------semester---------------
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
                    selectSemester(newValue);
                  },
                ),
              ),

              // ---------------------------------subject---------------
              if (widget.mode == UploadMode.questionPaper ||
                  widget.mode == UploadMode.note)
                MyDropDownDgnr(
                  'select subject',
                  DropdownButton(
                    dropdownColor: Colors.teal.shade100,
                    underline: MyDropDownDgnr.transDivider, isExpanded: true,
                    iconSize: 30,
                    icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                    ////////////////
                    value: currSub,
                    items: subjects
                        .map((String items) => DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        currSub = newValue!;
                      });
                    },
                  ),
                ),

              // ---------------------------------tests---------------
              if (widget.mode == UploadMode.questionPaper)
                if (_done)
                  SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MyDropDownDgnr(
                          'select tests',
                          DropdownButton(
                            dropdownColor: Colors.teal.shade100,
                            underline: MyDropDownDgnr.transDivider,
                            iconSize: 35,
                            icon: const Icon(Icons.arrow_drop_down_outlined),
                            ////////////////
                            value: currTest,
                            items: tests
                                .map((String items) => DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    ))
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                currTest = newValue!;
                              });
                            },
                          ),
                        ),

                        // ---------------------------------years---------------
                        if (widget.mode == UploadMode.questionPaper)
                          if (_done)
                            MyDropDownDgnr(
                              'select years',
                              DropdownButton(
                                dropdownColor: Colors.teal.shade100,
                                underline: MyDropDownDgnr.transDivider,
                                iconSize: 35,
                                icon:
                                    const Icon(Icons.arrow_drop_down_outlined),
                                ////////////////
                                value: currYear,
                                items: years
                                    .map((String items) => DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        ))
                                    .toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    currYear = newValue!;
                                  });
                                },
                              ),
                            ),
                      ],
                    ),
                  ),
              const SizedBox(height: 10),
              // -------------------------name field-----------------------
              if (widget.mode == UploadMode.note)
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'title of Chapter',
                  ),
                  onChanged: (val) {
                    setState(() => _isFilled = val.trim() != '');
                  },
                ),
              const SizedBox(height: 3),
              if (!_isFilled && widget.mode == UploadMode.note)
                const Text(
                  '⚠️  please provide title of the chapter and proceed.',
                  style: kErrTextStyle,
                ),

              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(
                  'Upload new ${configureUploadType(widget.mode)}',
                  style: kNormalSizeBoldTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> departments = myDeptMap.keys.toList();
  String currDept = myDeptMap.keys.toList()[0];

  List<String> semesters = myDeptMap['Civil Engineering']!.keys.toList();
  String currSem = myDeptMap['Civil Engineering']!.keys.toList()[0];

  List<String> subjects =
      myDeptMap['Civil Engineering']!['P cycle']!.keys.toList();
  String currSub = myDeptMap['Civil Engineering']!['P cycle']!.keys.toList()[0];

  List<String> tests = [];
  String currTest = '';

  List<String> years = [];
  String currYear = '';

  bool _done = false;

  void selectDepartment(String selDep) {
    setState(() {
      currSem = myDeptMap[selDep]!.keys.toList()[0];
      currSub = myDeptMap[selDep]![semesters[0]]!.keys.toList()[0];
      //
      semesters = myDeptMap[selDep]!.keys.toList();
      subjects = myDeptMap[selDep]![semesters[0]]!.keys.toList();
      //
    });
  }

  void selectSemester(selSem) {
    setState(() {
      currSub = myDeptMap[currDept]![selSem]!.keys.toList()[0];
      //
      subjects = myDeptMap[currDept]![selSem]!.keys.toList();
    });
  }

  setTestandYear() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      tests = prefs.getStringList('tests') ?? [];
      currTest = tests[0];
      //
      years = prefs.getStringList('years') ?? [];
      currYear = years[0];
      //
      _done = true;
    });
  }
}

Map<String, Map<String, Map<String, Map<String, Map<String, String>>>>>
    myDeptMap = departMapData;
