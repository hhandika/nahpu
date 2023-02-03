import 'package:flutter/material.dart';

import 'package:nahpu/services/database/database.dart';

class ProjectInfo extends StatelessWidget {
  const ProjectInfo({Key? key, required this.projectData}) : super(key: key);

  final ProjectData? projectData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: 'Project Name: ',
            style: Theme.of(context).textTheme.titleSmall,
            children: [
              TextSpan(
                text: projectData?.name ?? 'Empty!',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ),
        RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: 'UUID: ',
            style: Theme.of(context).textTheme.titleSmall,
            children: [
              TextSpan(
                text: '${projectData?.uuid}',
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: 'Project Description: ',
            style: Theme.of(context).textTheme.titleSmall,
            children: [
              TextSpan(
                text: projectData?.description ?? 'Empty!',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: 'Principal Investigator: ',
            style: Theme.of(context).textTheme.titleSmall,
            children: [
              TextSpan(
                text: projectData?.principalInvestigator ?? 'No PI name found!',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: 'Created: ',
            style: Theme.of(context).textTheme.titleSmall,
            children: [
              TextSpan(
                text: projectData?.created ?? 'No DateCreated',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: 'Modified: ',
            style: Theme.of(context).textTheme.titleSmall,
            children: [
              TextSpan(
                text: projectData?.lastModified ?? 'No DateModified',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ),
      ],
    );
  }
}
