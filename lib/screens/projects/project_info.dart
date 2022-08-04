import 'package:flutter/material.dart';

import 'package:nahpu/database/database.dart';

class ProjectInfo extends StatelessWidget {
  const ProjectInfo({Key? key, required this.projectData}) : super(key: key);

  final ProjectData? projectData;

  @override
  Widget build(BuildContext context) {
    return ListBody(children: <Widget>[
      Text('Project Name: ${projectData?.projectName ?? 'Empty!'}'),
      RichText(
          text: TextSpan(
              text: 'Project UUID: ',
              style: DefaultTextStyle.of(context).style,
              children: [
            TextSpan(
                text: '${projectData?.projectUuid}',
                style: const TextStyle(fontSize: 12))
          ])),
      Text(
          'Project Description: ${projectData?.projectDescription ?? 'Empty!'}'),
      Text(
          'Principal Investigator: ${projectData?.principalInvestigator ?? 'No PI'}'),
      Text('Collector Name: ${projectData?.collector ?? 'No Collector'}'),
      Text(
          'Collector Email: ${projectData?.collectorEmail ?? 'No Collector Email'}'),
      Text(
          'Start collector number at: ${projectData?.catNumStart ?? 'No CatNumStart'}'),
      Text(
          'End collector number at: ${projectData?.catNumEnd ?? 'No CatNumEnd'}'),
    ]);
  }
}
