import 'package:nahpu/screens/projects/components/project_info.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/services/providers/projects.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/common.dart';

class ProjectOverview extends ConsumerWidget {
  const ProjectOverview({super.key, required this.projectUuid});

  final String projectUuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormCard(
      title: 'Project Overview',
      infoContent: const ProjectInfoContent(),
      isPrimary: true,
      mainAxisAlignment: MainAxisAlignment.start,
      child: ref.watch(projectInfoProvider(projectUuid)).when(
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

class ProjectInfoContent extends StatelessWidget {
  const ProjectInfoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoContainer(
      content: [
        InfoContent(
          header: 'Overview',
          content: 'Basic information about the project.'
              ' You can edit the project information'
              ' by clicking the edit button in the bottom right corner.',
        ),
        InfoContent(
          content: 'Keep the description short and concise.'
              ' Provide only general info about the location,'
              ' e.g. Mt. Gede, Java, Indonesia.',
        ),
        InfoContent(
          header: 'UUID',
          content: 'Unique identifier for the project.'
              ' UUID is generated automatically when you create a new project.'
              ' It ensure that each project is unique'
              ' to avoid data collision in the future.'
              ' UUID is used to identify the project in the database.',
        ),
      ],
    );
  }
}
