import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

// ============================= normal  ================================
class MyDialogBox {
  static void normalDialog() {
    defaultDialog(
      'OOPS',
      'sorry, something went wrong please try again after some time while we resolve your issue.',
    );
  }

  // ============================= default  ================================
  static void defaultDialog(String title, String midText) {
    Get.defaultDialog(
      title: title,
      titleStyle: kBigSizeBoldTextStyle.copyWith(
        color: Colors.teal,
      ),
      middleText: midText,
      titlePadding: const EdgeInsets.only(top: 10),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      confirm: ElevatedButton.icon(
        icon: const Icon(Icons.check),
        onPressed: () => Get.back(),
        label: const Text(
          'OK',
          style: kNormalSizeTextStyle,
        ),
        style: ElevatedButton.styleFrom(
          elevation: 10,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 7,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }

  // ========================= progress indicator ===========================
  static void progressIndctr({String message = 'loading...'}) {
    Get.dialog(Scaffold(
      backgroundColor: Colors.teal.withAlpha(20),
      body: const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Colors.teal,
        ),
      ),
    ));
  }

  // ============================= loading ================================
  static void loading({String message = 'loading...'}) {
    Get.dialog(Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          width: 200,
          height: 105,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 12),
                Text(
                  message,
                  style: kNormalSizeTextStyle.copyWith(
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  // ============================= confirm ================================
  static void confirmDialogBox({
    required String message,
    required noFun,
    required String noName,
    required yesFun,
    required String yesName,
  }) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(10),
      middleText: message,
      middleTextStyle: kSmallSizeTextStyle,
      title: 'Alert !',
      titleStyle: kBigSizeBoldTextStyle.copyWith(
        color: Colors.teal,
      ),
      titlePadding: const EdgeInsets.only(top: 10),
      confirm: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 30),
          ElevatedButton.icon(
            icon: const Icon(Icons.check, size: 25),
            onPressed: yesFun,
            label: Text(yesName, style: kNormalSizeTextStyle),
            style: ElevatedButton.styleFrom(
              elevation: 10,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
      cancel: ElevatedButton.icon(
        icon: const Icon(Icons.close, size: 25),
        onPressed: noFun,
        label: Text(
          noName,
          style: kNormalSizeTextStyle,
        ),
        style: ElevatedButton.styleFrom(
          elevation: 10,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  // ============================= snack bar  ================================
  static showSnackBar(String message, {bool? yes, int? millSecs}) {
    Color myColor(int num) => yes == null
        ? Colors.amber.withAlpha(num)
        : yes
            ? Colors.teal.withAlpha(num)
            : Colors.pink.withAlpha(num);

    Get.showSnackbar(GetSnackBar(
      padding: const EdgeInsets.all(0),
      messageText: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: myColor(50),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: myColor(100)),
        ),
        child: Center(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              yes == null
                  ? Icons.add_alert_rounded
                  : yes
                      ? Icons.check
                      : Icons.close,
              size: 20,
              color: myColor(200),
            ),
            const SizedBox(width: 10),
            Text(
              message,
              overflow: TextOverflow.fade,
              style: kSmallSizeTextStyle,
            ),
          ],
        )),
      ),
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      duration: Duration(milliseconds: millSecs ?? 1100),
    ));
  }
}
