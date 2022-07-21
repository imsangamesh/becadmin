import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';

import '../../../utilities/constants.dart';
import '../../../utilities/myDialogBox.dart';

//Faculty listcard widget
class FacultyListTile extends StatelessWidget {
  //
  FacultyListTile({
    Key? key,
    required this.name,
    required this.department,
    required this.phone,
    required this.myEmail,
  }) : super(key: key);

  String name;
  String department;
  String phone;
  String myEmail;

  @override
  Widget build(BuildContext context) {
    //
    void showCallConfirmDialog() {
      MyDialogBox.confirmDialogBox(
        message: 'Hey, you wanna call $name',
        noFun: () => Get.back(),
        noName: 'no',
        yesFun: () => FlutterPhoneDirectCaller.callNumber(phone),
        yesName: 'call',
      );
    }

    void sendEmail() async {
      final Email email = Email(
        body: 'Hello sir,',
        subject: '',
        recipients: [myEmail],
      );

      await FlutterEmailSender.send(email);
    }

    return ExpansionTile(
      title: Text(name, style: kNormalSizeBoldTextStyle),
      subtitle: Text('Dept: $department'),
      children: [
        ListTile(
          subtitle: Text('phone:  $phone', style: kSmallSizeBoldTextStyle),
          title: Text('email:  $myEmail', style: kSmallSizeBoldTextStyle),
          trailing: SizedBox(
            width: 100,
            child: Row(children: [
              IconButton(
                icon: const Icon(
                  Icons.phone_in_talk_rounded,
                  color: Colors.pink,
                ),
                onPressed: () {
                  showCallConfirmDialog();
                },
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.email,
                  color: Colors.amber,
                ),
                onPressed: () => sendEmail(),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
