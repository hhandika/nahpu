import 'package:flutter/material.dart';

import 'package:nahpu/database/database.dart';

class ProjectInfo extends StatelessWidget {
  const ProjectInfo({Key? key, required this.projectData}) : super(key: key);

  final ProjectData? projectData;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Project UUID: ${projectData?.projectUuid}'),
          Text('Project Name: ${projectData?.projectName ?? 'Empty!'}'),
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
