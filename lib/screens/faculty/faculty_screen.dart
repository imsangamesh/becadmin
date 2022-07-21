import 'package:becadmin/utilities/constants.dart';
import 'package:becadmin/utilities/myDialogBox.dart';
import 'package:flutter/material.dart';

class Faculty extends StatelessWidget {
  Faculty({Key? key}) : super(key: key);
  //
  final _nameCntr = TextEditingController();
  final _desgnCntr = TextEditingController();
  final _phoneCntr = TextEditingController();
  final _emailCntr = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //
    InputDecoration myFacultyDecor(String label, IconData icon) {
      return InputDecoration(
        labelText: label,
        icon: Icon(
          icon,
          size: 32,
          color: Theme.of(context).primaryColor,
        ),
      );
    }

    saveForm() {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) return;
      FocusScope.of(context).unfocus();
      _formKey.currentState!.save();

      fire.collection('faculty').doc().set({
        'name': _nameCntr.text,
        'desgn': _desgnCntr.text,
        'phone': _phoneCntr.text,
        'email': _emailCntr.text,
      });
      MyDialogBox.showSnackBar('new faculty updated !', yes: true);
      _desgnCntr.text = _nameCntr.text = _emailCntr.text = _phoneCntr.text = '';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Faculty')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'please provide all the required fields and submit.',
                style: kNormalSizeTextStyle,
              ),
              const SizedBox(height: 10),
              // ----------------title----------------------
              TextFormField(
                validator: (v) {
                  if (v == null) {
                    return 'please provide this field';
                  } else if (v.trim() == '') {
                    return 'please provide this field';
                  } else {
                    return null;
                  }
                },
                decoration: myFacultyDecor('name', Icons.person),
                controller: _nameCntr,
              ),
              const SizedBox(height: 10),
              // ----------------designation----------------------
              TextFormField(
                validator: (v) {
                  if (v == null) {
                    return 'please provide this field';
                  } else if (v.trim() == '') {
                    return 'please provide this field';
                  } else {
                    return null;
                  }
                },
                decoration:
                    myFacultyDecor('designation', Icons.short_text_rounded),
                controller: _desgnCntr,
              ),
              const SizedBox(height: 10),
              // ----------------phone----------------------
              TextFormField(
                validator: (v) {
                  if (v == null) {
                    return 'please provide this field';
                  } else if (int.tryParse(v) == null || v.length != 10) {
                    return 'please provide valid phone number';
                  } else {
                    return null;
                  }
                },
                decoration:
                    myFacultyDecor('phone no.', Icons.phone_in_talk_sharp),
                controller: _phoneCntr,
              ),
              const SizedBox(height: 10),
              // ----------------email----------------------
              TextFormField(
                validator: (v) {
                  if (v == null) {
                    return 'please provide this field';
                  } else if (!v.contains('@')) {
                    return 'please provide valid email address';
                  } else {
                    return null;
                  }
                },
                decoration: myFacultyDecor('email address', Icons.email),
                controller: _emailCntr,
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveForm,
                child: const Text(
                  ' Submit ',
                  style: kNormalSizeBoldTextStyle,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
