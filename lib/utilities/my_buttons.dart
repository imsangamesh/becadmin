import 'package:becadmin/utilities/constants.dart';
import 'package:flutter/material.dart';

class MyElevButton extends StatelessWidget {
  const MyElevButton(
    this.title,
    this.fun, {
    this.radius,
    this.icon,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  final String title;
  final VoidCallback fun;
  final double? radius;
  final IconData? icon;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    //
    myElevBtnStyle() => ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 22),
          textStyle: textStyle ?? kNormalSizeBoldTextStyle,
        );

    return icon == null
        ? ElevatedButton(
            style: myElevBtnStyle(),
            onPressed: () {
              FocusScope.of(context).unfocus();
              fun();
            },
            child: Text(title),
          )
        : ElevatedButton.icon(
            style: myElevBtnStyle(),
            onPressed: () {
              FocusScope.of(context).unfocus();
              fun();
            },
            icon: Icon(icon),
            label: Text(title),
          );
  }
}

class MyOutLButton extends StatelessWidget {
  const MyOutLButton(
    this.title,
    this.fun, {
    this.radius,
    this.icon,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  final String title;
  final VoidCallback fun;
  final double? radius;
  final IconData? icon;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    //
    myOutLBtnStyle() => OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 5),
          ),
          side: BorderSide(
            color: Theme.of(context).primaryColor.withAlpha(100),
            width: 1.5,
          ),
          textStyle: textStyle ?? kNormalSizeBoldTextStyle,
        );

    return icon == null
        ? OutlinedButton(
            style: myOutLBtnStyle(),
            onPressed: () {
              FocusScope.of(context).unfocus();
              fun();
            },
            child: Text(title),
          )
        : OutlinedButton.icon(
            style: myOutLBtnStyle(),
            onPressed: () {
              FocusScope.of(context).unfocus();
              fun();
            },
            icon: Icon(icon),
            label: Text(title),
          );
  }
}
