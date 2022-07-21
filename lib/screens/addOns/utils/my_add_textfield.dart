import 'package:flutter/material.dart';

class MyAddTextField extends StatelessWidget {
  const MyAddTextField(
    this.label,
    this.icon,
    this.cont, {
    this.sufIcon,
    this.fun,
    Key? key,
  }) : super(key: key);
  //
  final String label;
  final IconData icon;
  final TextEditingController cont;
  final IconData? sufIcon;
  final VoidCallback? fun;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5, right: 10, left: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor.withAlpha(50),
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          icon: Icon(
            icon,
            size: 35,
            color: Theme.of(context).primaryColor,
          ),
          suffixIcon: InkWell(
            onTap: fun == null ? null : fun!,
            borderRadius: BorderRadius.circular(30),
            child: Icon(sufIcon, size: 30),
          ),
        ),
        controller: cont,
      ),
    );
  }
}
