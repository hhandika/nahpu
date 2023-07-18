import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/platform_services.dart';

class FormCard extends StatelessWidget {
  const FormCard({
    super.key,
    required this.child,
    this.title = '',
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.mainAxisSize = MainAxisSize.max,
    this.isPrimary = false,
    this.isWithTitle = true,
    this.isWithDivider = true,
    this.isWithSidePadding = true,
  });

  final Widget child;
  final String title;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final bool isPrimary;
  final bool isWithTitle;
  final bool isWithDivider;
  final bool isWithSidePadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isPrimary
                ? Color.lerp(Theme.of(context).colorScheme.secondaryContainer,
                    Theme.of(context).colorScheme.surface, 0.2)
                : Theme.of(context).colorScheme.surfaceVariant.withAlpha(80),
            border: Border.all(
              color: isPrimary
                  ? Theme.of(context).colorScheme.secondary.withAlpha(50)
                  : Theme.of(context).dividerColor.withAlpha(50),
              width: 1.5,
            ),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: mainAxisAlignment,
              mainAxisSize: mainAxisSize,
              children: [
                isWithTitle ? TitleForm(text: title) : const SizedBox.shrink(),
                isWithTitle && !isPrimary
                    ? Divider(
                        thickness: 0.6,
                        color: Theme.of(context).tabBarTheme.dividerColor)
                    : const SizedBox.shrink(),
                isWithSidePadding
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
                        child: child)
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: child,
                      )
              ]),
        ));
  }
}

class CommonIDForm extends StatelessWidget {
  const CommonIDForm({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
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
    ScreenType deviceType = getScreenType(context);
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
            onPressed: () {
              deviceType == ScreenType.phone
                  ? showModalSheet(context)
                  : showInfoDialog(context);
            },
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

  void showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          content: const Text(
            'Info coming soon!',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void showModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Info coming soon!',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

void showDeleteAlertOnMenu({
  required BuildContext context,
  required String deletePrompt,
  required String title,
  required VoidCallback onDelete,
}) {
  Future.delayed(
    const Duration(milliseconds: 0),
    () => showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteAlerts(
          deletePrompt: deletePrompt,
          title: title,
          onDelete: onDelete,
        );
      },
    ),
  );
}

class DeleteAlerts extends ConsumerWidget {
  const DeleteAlerts({
    Key? key,
    required this.title,
    required this.deletePrompt,
    required this.onDelete,
  }) : super(key: key);

  final String title;
  final String deletePrompt;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(title),
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

class CommonTabBars extends ConsumerWidget {
  const CommonTabBars({
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
          child: CommonPadding(
              child: TabBarView(
            controller: tabController,
            children: children,
          )),
        ),
      ],
    );
  }
}
