import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/project_services.dart';

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
      child: Column(
        children: [
          withTitle ? TitleForm(text: title) : const SizedBox.shrink(),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: child)
        ],
      ),
    );
  }
}

class TitleForm extends StatelessWidget {
  const TitleForm({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              Icons.info_outline_rounded,
              size: 22,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
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
            ProjectServices(ref).deleteProject(projectUuid);
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
    required this.height,
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
          height: height,
          child: TabBarView(
            controller: tabController,
            children: children,
          ),
        ),
      ],
    );
  }
}
