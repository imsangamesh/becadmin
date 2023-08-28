import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import '../utilities/my_buttons.dart';

class AddUserEmails extends StatelessWidget {
  AddUserEmails({super.key});
  final controller = TextEditingController();

  uplaodData() async {
    final prevValidUsers =
        await fire.collection('valid_users').doc('valid_users').get();

    final usersList = prevValidUsers.data() == null
        ? []
        : prevValidUsers.data()!['valid_users'];

    await fire.collection('valid_users').doc('valid_users').set({
      'valid_users': [
        ...usersList,
        ...controller.text
            .split('\n')
            .map((e) => e.trim())
            .where((element) => element != '')
      ],
    });

    controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add User Emails')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.crisis_alert, size: 20),
                  Text(
                    '  please separate emails by tapping "enter"',
                    style: TextStyle(height: 0.5),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: 30,
              decoration: const InputDecoration(
                labelText: 'paste user emails',
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
