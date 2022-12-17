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
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 5.0),
                      child: textField,
                    ),
                  ),
              ],
            ),
          )
        : Container(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
            child: Column(
              children: children,
            ),
          );
  }
}
