import 'package:flutter/material.dart';

import '../../../utilities/constants.dart';

class NoticeBoard extends StatelessWidget {
  const NoticeBoard(
    this.title,
    this.body, {
    Key? key,
    this.loading = false,
  }) : super(key: key);

  final String title;
  final String body;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.23,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.teal,
          width: 3,
          style: BorderStyle.solid,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withAlpha(100),
          borderRadius: BorderRadius.circular(5),
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              title,
              style: kNormalSizeBoldTextStyle,
            ),
            const SizedBox(height: 10),
            if (loading == true) const CircularProgressIndicator(),
            if (loading == false)
              Text(
                body,
                textAlign: TextAlign.center,
                softWrap: true,
                style: kNormalSizeTextStyle.copyWith(fontSize: 17),
              )
          ]),
        ),
      ),
    );
  }
}
