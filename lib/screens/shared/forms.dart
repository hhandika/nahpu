import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/services/database.dart';

class SiteIdField extends ConsumerWidget {
  const SiteIdField({
    Key? key,
    required this.onChanges,
    required this.siteData,
    required this.value,
  }) : super(key: key);

  final void Function(int?) onChanges;
  final List<SiteData> siteData;
  final int? value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonFormField(
      value: value,
      decoration: const InputDecoration(
        labelText: 'Site ID',
        hintText: 'Enter a site',
      ),
      items: siteData
          .map((site) => DropdownMenuItem(
                value: site.id,
                child: Text(site.siteID ?? ''),
              ))
          .toList(),
      onChanged: onChanges,
    );
  }
}

class FormCard extends StatelessWidget {
  const FormCard(
      {Key? key,
      required this.child,
      this.title = '',
      this.isPrimary = false,
      this.withTitle = true})
      : super(key: key);

  final Widget child;
  final String title;
  final bool isPrimary;
  final bool withTitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isPrimary
          ? Color.lerp(Theme.of(context).colorScheme.secondaryContainer,
              Theme.of(context).colorScheme.surface, 0.5)
          : Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            withTitle ? TitleForm(title: title) : const SizedBox.shrink(),
            child,
          ],
        ),
      ),
    );
  }
}

class TitleForm extends StatelessWidget {
  const TitleForm({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        IconButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Icon(
            Icons.info_outline_rounded,
            size: 20,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }
}

class DeleteAlerts extends ConsumerWidget {
  const DeleteAlerts({
    Key? key,
    required this.projectUuid,
    required this.onDelete,
  }) : super(key: key);

  final String projectUuid;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Delete'),
      content: const Text('Are you sure you want to delete this project?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            deleteProject(ref, projectUuid);
            onDelete();
          },
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}

class MediaTabBars extends ConsumerWidget {
  const MediaTabBars({
    super.key,
    required this.tabController,
    required this.length,
    required this.tabs,
    required this.children,
    this.height = 0.5,
  });

  final TabController tabController;
  final int length;
  final List<Tab> tabs;
  final List<Widget> children;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      // Media inputs
      children: [
        DefaultTabController(
          length: length,
          child: TabBar(
            indicatorColor: Theme.of(context).colorScheme.tertiary,
            controller: tabController,
            tabs: tabs,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * height,
          child: TabBarView(
            controller: tabController,
            children: children,
          ),
        ),
      ],
    );
  }
}
