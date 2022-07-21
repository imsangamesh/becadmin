import 'package:flutter/material.dart';

class MyDropDownDgnr extends StatelessWidget {
  const MyDropDownDgnr(this.label, this.child, {Key? key}) : super(key: key);

  final Widget child;
  final String label;
  static const transDivider = Divider(height: 0, color: Colors.transparent);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(' $label'),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withAlpha(70),
              borderRadius: BorderRadius.circular(10),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
