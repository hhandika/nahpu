import 'package:flutter/material.dart';

import 'package:nahpu/services/database/database.dart';

class ProjectInfo extends StatelessWidget {
  const ProjectInfo({Key? key, required this.projectData}) : super(key: key);

  final ProjectData? projectData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProjectInfoText(
          title: 'Project name: ',
          text: projectData?.name,
        ),
        ProjectInfoText(title: 'UUID: ', text: projectData?.uuid),
        ProjectInfoText(
            title: 'Project description: ', text: projectData?.description),
        ProjectInfoText(
          title: 'Principal investigator: ',
          text: projectData?.principalInvestigator,
        ),
        ProjectInfoText(
          title: 'Location: ',
          text: projectData?.location,
        ),
        ProjectInfoText(
          title: 'Start date: ',
          text: projectData?.startDate,
        ),
        ProjectInfoText(
          title: 'End date: ',
          text: projectData?.endDate,
        ),
        const SizedBox(height: 20),
        ProjectInfoText(
          title: 'Created: ',
          text: projectData?.created,
          isSmall: true,
        ),
        ProjectInfoText(
          title: 'Accessed: ',
          text: projectData?.lastAccessed,
          isSmall: true,
        ),
      ],
    );
  }
}

class ProjectInfoText extends StatelessWidget {
  const ProjectInfoText({
    super.key,
    required this.title,
    required this.text,
    this.isSmall = false,
  });

  final String title;
  final String? text;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: title,
        style: isSmall
            ? Theme.of(context).textTheme.bodyMedium
            : Theme.of(context).textTheme.titleSmall,
        children: [
          TextSpan(
            text: text ?? '',
            style: isSmall
                ? Theme.of(context).textTheme.bodyMedium
                : Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}
