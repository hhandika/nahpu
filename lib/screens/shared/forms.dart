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
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}

class FormCard extends StatelessWidget {
  const FormCard({
    super.key,
    required this.child,
    this.title = '',
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.mainAxisSize = MainAxisSize.max,
    this.isPrimary = false,
    this.withTitle = true,
    this.withDivider = true,
  });

  final Widget child;
  final String title;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final bool isPrimary;
  final bool withTitle;
  final bool withDivider;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isPrimary
                  ? [
                      Theme.of(context).colorScheme.primaryContainer,
                      Theme.of(context).colorScheme.secondaryContainer,
                    ]
                  : [
                      Theme.of(context).cardColor,
                      Theme.of(context).colorScheme.surface,
                    ],
              stops: const [0.0, 0.4],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
            color: isPrimary
                ? Color.lerp(Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.surface, 0.6)
                : Theme.of(context).cardColor,
            border: Border.all(
              color: Theme.of(context).dividerColor.withOpacity(0.4),
              width: 0.65,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: [
              withTitle ? TitleForm(text: title) : const SizedBox.shrink(),
              withTitle && !isPrimary
                  ? Divider(
                      thickness: 0.3,
                      color: Theme.of(context).tabBarTheme.dividerColor)
                  : const SizedBox.shrink(),
              child
            ],
          ),
        ));
  }
}

class TitleForm extends StatelessWidget {
  const TitleForm({
    super.key,
    required this.text,
    this.isCentered = true,
  });

  final String text;
  final bool isCentered;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isCentered
          ? const EdgeInsets.fromLTRB(46, 0, 0, 4)
          : const EdgeInsets.only(right: 10),
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
              color: Theme.of(context).dividerColor,
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
      children: [
        DefaultTabController(
          length: length,
          child: TabBar(
            indicatorColor: Theme.of(context).colorScheme.primary,
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
