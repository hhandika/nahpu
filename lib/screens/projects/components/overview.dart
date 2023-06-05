import 'package:nahpu/screens/projects/project_info.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/common.dart';

class ProjectOverview extends ConsumerWidget {
  const ProjectOverview({Key? key, required this.projectUuid})
      : super(key: key);

  final String projectUuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormCard(
      title: 'Project Overview',
      isPrimary: true,
      mainAxisAlignment: MainAxisAlignment.start,
      child: Column(
        children: [
          ref.watch(projectInfoProvider(projectUuid)).when(
                data: (data) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ProjectInfo(
                      projectData: data,
                    ),
                  );
                },
                loading: () => const CommonProgressIndicator(),
                error: (error, stack) => Text(error.toString()),
              ),
        ],
      ),
    );
  }

  Widget showAlert(BuildContext context, String error) {
    return AlertDialog(
      title: const Text('ERROR!'),
      content: Column(
        children: [
          Text(
              'Failed fetching data from the database. Check if the project name exists. $error')
        ],
      ),
    );
  }
}
