import 'package:becadmin/controllers/addOns/yearController.dart';
import 'package:becadmin/utilities/myDialogBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/addOns/testController.dart';
import '../../../utilities/constants.dart';

class TextAddOnChip extends StatelessWidget {
  const TextAddOnChip(
    this.type,
    this.label,
    this.controller, {
    Key? key,
  }) : super(key: key);

  final String label;
  final String type;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 10),
      child: InkWell(
        splashColor: theme.primaryColor,
        onTap: () => controller.text = label,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.only(
            top: 5,
            left: 15,
            bottom: 5,
            right: 5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: theme.primaryColor.withOpacity(0.3),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$label ',
                  style: kSmallSizeTextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                  )),
              InkWell(
                splashColor: Colors.pink,
                onTap: () {
                  MyDialogBox.confirmDialogBox(
                    message: 'do you wanna delete the selected "$label" ?',
                    noFun: () => Get.back(),
                    noName: 'no',
                    yesFun: () {
                      Get.back();
                      if (type == 'test') {
                        Get.find<TestController>().deleteExistingTest(label);
                      } else if (type == 'year') {
                        Get.find<YearController>().deleteExistingYear(label);
                      }
                    },
                    yesName: 'yes',
                  );
                },
                borderRadius: BorderRadius.circular(30),
                child: const Icon(
                  Icons.highlight_remove_rounded,
                  size: 25,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
