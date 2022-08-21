import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nahpu/providers/project.dart';
import 'package:nahpu/screens/projects/project_home.dart';
// import 'package:nahpu/providers/narrative.dart';

class ProjectBackButton extends ConsumerWidget {
  const ProjectBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BackButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const ProjectHome();
        }));
        ref.read(projectNavbarIndexProvider.state).state = 0;
      },
    );
  }
}
