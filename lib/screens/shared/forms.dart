import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IDFormContainer extends StatelessWidget {
  const IDFormContainer({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}

class FormCard extends StatelessWidget {
  const FormCard(
      {Key? key,
      required this.child,
      this.title = '',
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
      this.mainAxisSize = MainAxisSize.max,
      this.isPrimary = false,
      this.withTitle = true})
      : super(key: key);

  final Widget child;
  final String title;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
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
        crossAxisAlignment: CrossAxisAlignment.values[1],
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.info_outline_rounded,
              size: 20,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}

void showDeleteAlertOnMenu(
    VoidCallback onDelete, String deletePrompt, BuildContext context) {
  Future.delayed(
    const Duration(milliseconds: 0),
    () => showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteAlerts(
          deletePrompt: deletePrompt,
          onDelete: onDelete,
        );
      },
    ),
  );
}

class DeleteAlerts extends ConsumerWidget {
  const DeleteAlerts({
    Key? key,
    required this.deletePrompt,
    required this.onDelete,
  }) : super(key: key);

  final String deletePrompt;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Delete'),
      content: Text(
        deletePrompt,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
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
