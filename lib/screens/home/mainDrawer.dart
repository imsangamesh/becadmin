import 'package:becadmin/screens/notice/notice_screen.dart';
import 'package:becadmin/utilities/constants.dart';
import 'package:becadmin/screens/home/utils/myDrawerListTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.close,
                size: 30,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text('BECUSER'),
            automaticallyImplyLeading: false,
          ),
          const SizedBox(height: 5),
          const SizedBox(height: 10),
          MyDrawerListTile(
            title: 'Notice board',
            icon: Icons.calendar_month_rounded,
            navigateTo: () => Get.to(() => NoticeScreen()),
          ),
          MyDrawerListTile(
            title: 'Question Papers',
            icon: Icons.library_books,
            navigateTo: () => Get.to(() => const Demo()),
          ),
          // MyDrawerListTile(
          //   title: 'Notes',
          //   icon: Icons.menu_book,
          //   navigateTo: () => Get.to(const Notes()),
          // ),
          // MyDrawerListTile(
          //   title: 'Gallery',
          //   icon: Icons.collections,
          //   navigateTo: () => Get.to(const Gallery()),
          // ),
          // MyDrawerListTile(
          //   title: 'Syllabus',
          //   icon: Icons.notes,
          //   navigateTo: () => Get.to(const Syllabus()),
          // ),
          // MyDrawerListTile(
          //   title: 'Faculty',
          //   icon: Icons.contacts,
          //   navigateTo: () => Get.to(const Faculty()),
          // ),
          // MyDrawerListTile(
          //   title: 'Logout',
          //   icon: Icons.exit_to_app_rounded,
          //   navigateTo: () => confirmLogout(),
          // ),
          const Spacer(),
          Container(
            color: Theme.of(context).primaryColor.withAlpha(40),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(' developed by :',
                    style: kSmallSizeTextStyle.copyWith(
                      fontStyle: FontStyle.italic,
                    )),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'San & Sajjan',
                    textAlign: TextAlign.center,
                    style: kBigSizeBoldTextStyle.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).primaryColor,
                        letterSpacing: 2,
                        shadows: [
                          Shadow(
                            color: Theme.of(context).primaryColor,
                            blurRadius: 10,
                          )
                        ]),
                  ),
                ),
                const SizedBox(height: 3),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    '  Crackhead ltd.',
                    textAlign: TextAlign.center,
                    style: kSmallSizeTextStyle.copyWith(
                      // color: Theme.of(context).primaryColor,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
