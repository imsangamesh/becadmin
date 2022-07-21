import 'package:becadmin/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageButton extends StatelessWidget {
  const PageButton(
      {Key? key,
      required this.title,
      required this.icon,
      required this.navigateTo})
      : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback navigateTo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 2,
            color: Colors.grey,
          )
        ],
      ),
      child: ListTile(
        onTap: () {
          Get.back();
          navigateTo();
        },
        leading: Icon(
          icon,
          size: 30,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          title,
          style: kNormalSizeTextStyle,
        ),
      ),
    );
  }
}
