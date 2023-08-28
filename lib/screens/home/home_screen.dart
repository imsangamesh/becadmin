import 'package:becadmin/result%20and%20block/result_and_search.dart';
import 'package:becadmin/screens/addOns/add_test_year.dart';
import 'package:becadmin/screens/faculty/faculty_screen.dart';
import 'package:becadmin/screens/home/utils/myDrawerListTile.dart';
import 'package:becadmin/screens/images/home_images.dart';
import 'package:becadmin/screens/notice/notice_screen.dart';
import 'package:becadmin/screens/uploads/path_selector.dart';
import 'package:becadmin/screens/uploads/upload_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../add users/add_user_emails.dart';
import '../gallery/gallery_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const MainDrawer(),
      appBar: AppBar(
        leading: const Icon(Icons.school),
        leadingWidth: 100,
        titleSpacing: 0,
        title: const Text('BEC ADMIN'),
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Column(
              children: [
                MyDrawerListTile(
                  title: 'Notice board',
                  icon: Icons.calendar_month_rounded,
                  navigateTo: () => Get.to(() => const NoticeScreen()),
                ),
                MyDrawerListTile(
                  title: 'Question Papers',
                  icon: Icons.library_books,
                  navigateTo: () => Get.to(
                    () => const PathSelector(UploadMode.questionPaper),
                  ),
                ),
                MyDrawerListTile(
                  title: 'Notes',
                  icon: Icons.library_books,
                  navigateTo: () => Get.to(
                    () => const PathSelector(UploadMode.note),
                  ),
                ),
                MyDrawerListTile(
                  title: 'Add Test and Years',
                  icon: Icons.add_box_rounded,
                  navigateTo: () => Get.to(() => const AddTestYear()),
                ),
                MyDrawerListTile(
                  title: 'Gallery',
                  icon: Icons.collections,
                  navigateTo: () => Get.to(const Gallery()),
                ),
                MyDrawerListTile(
                  title: 'Syllabus',
                  icon: Icons.notes,
                  navigateTo: () => Get.to(
                    () => const PathSelector(UploadMode.syllabus),
                  ),
                ),
                MyDrawerListTile(
                  title: 'Time table',
                  icon: Icons.edit_calendar,
                  navigateTo: () => Get.to(
                    () => const PathSelector(UploadMode.timetable),
                  ),
                ),
                MyDrawerListTile(
                  title: 'Faculty',
                  icon: Icons.switch_account,
                  navigateTo: () => Get.to(
                    () => Faculty(),
                  ),
                ),
                MyDrawerListTile(
                  title: 'Home Images',
                  icon: Icons.photo_size_select_actual_outlined,
                  navigateTo: () => Get.to(
                    () => const HomeImages(),
                  ),
                ),
                MyDrawerListTile(
                  title: 'Result Upload',
                  icon: Icons.search,
                  navigateTo: () => Get.to(
                    () => const ResultAndExamBlock(SearchMode.result),
                  ),
                ),
                MyDrawerListTile(
                  title: 'Exam block Upload',
                  icon: Icons.person_search_sharp,
                  navigateTo: () => Get.to(
                    () => const ResultAndExamBlock(SearchMode.block),
                  ),
                ),
                MyDrawerListTile(
                  title: 'Add New Users',
                  icon: Icons.account_circle,
                  navigateTo: () => Get.to(
                    () => AddUserEmails(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
