import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utilities/constants.dart';

class MyDrawerListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final dynamic navigateTo;

  const MyDrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.navigateTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              splashColor: Theme.of(context).primaryColor.withAlpha(100),
              onTap: () {
                Get.back();
                navigateTo();
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      icon,
                      size: 32,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      title,
                      softWrap: true,
                      style: kNormalSizeTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1, height: 8, indent: 10, endIndent: 20),
          ],
        ),
      ),
    );
  }
}
