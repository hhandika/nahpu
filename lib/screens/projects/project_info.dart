import 'package:flutter/material.dart';

import 'package:nahpu/database/database.dart';

class ProjectInfo extends StatelessWidget {
  const ProjectInfo({Key? key, required this.projectData}) : super(key: key);

  final ProjectData? projectData;

  @override
  Widget build(BuildContext context) {
    return ListBody(children: <Widget>[
      Text('Project Name: ${projectData?.name ?? 'Empty!'}'),
      RichText(
          text: TextSpan(
              text: 'UUID: ',
              style: DefaultTextStyle.of(context).style,
              children: [
            TextSpan(
                text: '${projectData?.uuid}',
                style: const TextStyle(fontSize: 12))
          ])),
      Text('Project Description: ${projectData?.description ?? 'Empty!'}'),
      Text(
          'Principal Investigator: ${projectData?.principalInvestigator ?? 'No PI'}'),
      Text('Budget: ${projectData?.budget ?? 'No budget'}'),
      Text('Date Created: ${projectData?.created ?? 'No DateCreated'}'),
      Text('Date Modified: ${projectData?.lastModified ?? 'No DateModified'}'),
    ]);
  }
}
