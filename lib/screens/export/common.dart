import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FileFormatIcon extends StatelessWidget {
  const FileFormatIcon({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: SvgPicture.asset(
          path,
          height: 116,
          width: 116,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ));
  }
}
