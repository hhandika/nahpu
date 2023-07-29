import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:nahpu/services/utility_services.dart';

class ProjectInfo extends ConsumerWidget {
  const ProjectInfo({super.key, required this.projectData});

  final ProjectData? projectData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ProjectIcon(
          path: SpecimenServices(ref: ref).getIconPath(),
        ),
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
        const SizedBox(height: 24),
        ProjectInfoText(
          title: 'Created: ',
          text: _parseDate(projectData?.created),
          isSmall: true,
        ),
        ProjectInfoText(
          title: 'Last accessed: ',
          text: _parseDate(projectData?.lastAccessed),
          isSmall: true,
        ),
      ],
    );
  }

  String _parseDate(String? date) {
    final value = parseDate(date);
    return '${value.date} ${value.time}';
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
      textAlign: TextAlign.center,
      text: TextSpan(
        text: title,
        style: isSmall
            ? Theme.of(context).textTheme.labelMedium
            : Theme.of(context).textTheme.titleSmall,
        children: [
          TextSpan(
            text: text ?? '',
            style: isSmall
                ? Theme.of(context).textTheme.labelMedium
                : Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}

class ProjectIcon extends StatelessWidget {
  const ProjectIcon({super.key, required this.path});
  final String path;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.primary,
        BlendMode.srcIn,
      ),
      width: 96,
      height: 96,
    );
  }
}
