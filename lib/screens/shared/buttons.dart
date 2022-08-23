import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/configs/colors.dart';

import 'package:nahpu/providers/project.dart';
import 'package:nahpu/screens/projects/project_home.dart';
import 'package:nahpu/providers/page_viewer.dart';

class ProjectBackButton extends ConsumerWidget {
  const ProjectBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BackButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const ProjectHome();
        }));
        ref.read(projectNavbarIndexProvider.state).state = 0;
      },
    );
  }
}

class CustomPageNavButton extends ConsumerWidget {
  final Duration _duration = const Duration(milliseconds: 300);
  final Curve _curve = Curves.easeInOut;

  const CustomPageNavButton({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(pageNavigationProvider);
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          color: NahpuColor.navColor(context),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.05,
        maxWidth: 220,
      ),
      child: Row(
        children: [
          Expanded(
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              heroTag: 'previous',
              elevation: 0,
              onPressed: () {
                if (pageController.hasClients) {
                  pageController.previousPage(
                      duration: _duration, curve: _curve);
                }
              },
              child: const Icon(Icons.navigate_before),
            ),
          ),
          FittedBox(
            child: Text(
              page.currentPage > 0
                  ? 'Page ${page.currentPage} of ${page.pageCounts}'
                  : 'Page counts: ${page.pageCounts}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              heroTag: 'next',
              elevation: 0,
              onPressed: () {
                if (pageController.hasClients) {
                  pageController.nextPage(duration: _duration, curve: _curve);
                }
              },
              child: const Icon(Icons.navigate_next),
            ),
          ),
        ],
      ),
    );
  }
}
