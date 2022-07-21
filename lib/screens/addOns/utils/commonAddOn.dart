import 'package:becadmin/screens/addOns/utils/my_add_textfield.dart';
import 'package:becadmin/utilities/constants.dart';
import 'package:flutter/material.dart';

class CommonAddOnScreen extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final VoidCallback fun;
  final Widget getListWidget;

  const CommonAddOnScreen(
    this.labelText,
    this.controller,
    this.fun,
    this.getListWidget, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyAddTextField(
            labelText,
            Icons.short_text_rounded,
            controller,
            sufIcon: Icons.add_circle_outline_sharp,
            fun: () {
              fun();
              controller.text = '';
            },
          ),
          const SizedBox(height: 30),
          Text(
            'current $labelText/s : ',
            style: kSmallSizeTextStyle,
          ),
          const SizedBox(height: 10),
          getListWidget,
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
// GetBuilder<DeptController>(builder: (_) {
//                 return SizedBox(
//                   width: double.infinity,
//                   child: Wrap(
//                     crossAxisAlignment: WrapCrossAlignment.start,
//                     children: Get.find<DeptController>()
//                         .deptList
//                         .map((each) =>
//                             TextAddOnChip('dept', each, _deptController))
//                         .toList(),
//                   ),
//                 );
//               }),