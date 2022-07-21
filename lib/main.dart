import 'package:becadmin/screens/home/home_screen.dart';
import 'package:becadmin/utilities/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// depts // sems  // subs  // tests

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Becuser',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          primaryColor: Colors.teal,
          iconTheme: const IconThemeData(
            color: Colors.teal,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              textStyle: kNormalSizeBoldTextStyle,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
            ),
          )),
      navigatorKey: Get.key,
      home: const HomeScreen(),
    );
  }
}

class Demo extends StatelessWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('demo')));
  }
}
