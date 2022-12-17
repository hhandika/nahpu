import 'package:flutter/material.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout(
      {Key? key, required this.useHorizontalLayout, required this.children})
      : super(key: key);

  final List<Widget> children;
  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context) {
    return useHorizontalLayout
        ? IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var textField in children)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: textField,
                    ),
                  ),
              ],
            ),
          )
        : Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: children,
            ),
          );
  }
}
