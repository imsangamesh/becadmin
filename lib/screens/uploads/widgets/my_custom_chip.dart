import 'package:flutter/material.dart';

class MyCustomChip extends StatelessWidget {
  const MyCustomChip(this.label, {Key? key}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 8),
      child: Chip(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: Theme.of(context).primaryColor.withAlpha(50),
        elevation: 5,
        label: Text(label),
        padding: const EdgeInsets.all(5),
      ),
    );
  }
}
