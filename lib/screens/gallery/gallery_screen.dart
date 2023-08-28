import 'package:becadmin/models/event_model.dart';
import 'package:becadmin/screens/gallery/upload_events.dart';
import 'package:becadmin/utilities/constants.dart';
import 'package:becadmin/utilities/myDialogBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utilities/my_buttons.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  //
  final _titleCntr = TextEditingController();
  final _descCntr = TextEditingController();
  DateTime? _dateCntr;

  void openDatePicker(context) {
    FocusScope.of(context).unfocus();
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate == null) {
        MyDialogBox.showSnackBar('please select date', millSecs: 1700);
        return;
      }
      setState(() => _dateCntr = selectedDate);
    });
  }

  passData() {
    if (_titleCntr.text.trim() == '' ||
        _descCntr.text.trim() == '' ||
        _dateCntr == null) {
      MyDialogBox.defaultDialog(
        'Oops',
        'please fill out all the fields, select date and then proceed.',
      );
      return;
    }
    Get.to(
      () => UploadEvents(EventModel(
        eid: '${_titleCntr.text}~${_descCntr.text}~$_dateCntr',
        title: _titleCntr.text.trim(),
        description: _descCntr.text.trim(),
        date: _dateCntr!.toIso8601String(),
        images: [],
      )),
    );
  }

  @override
  void dispose() {
    _descCntr.dispose();
    _titleCntr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 50),
                TextField(
                  controller: _titleCntr,
                  decoration: InputDecoration(
                    labelText: 'title of event',
                    icon: Icon(
                      Icons.short_text,
                      size: 35,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
                TextField(
                  controller: _descCntr,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'description',
                    icon: Icon(
                      Icons.notes_rounded,
                      size: 35,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(children: [
                  Text(
                    _dateCntr == null
                        ? '   please choose date'
                        : '   Date chosen : ${DateFormat.yMMMd().format(_dateCntr!)}',
                    style: kSmallSizeBoldTextStyle,
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () => openDatePicker(context),
                    icon: Icon(
                      Icons.date_range,
                      color: theme.primaryColor,
                    ),
                    label: const Text('Date', style: kPSmallSizeBoldTextStyle),
                  )
                ]),
                const Spacer(),
                MyElevButton(' Next ', passData, radius: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
