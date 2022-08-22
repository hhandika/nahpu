import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nahpu/providers/project.dart';
import 'package:nahpu/screens/projects/project_home.dart';

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

class CustomNavButton extends ConsumerWidget {
  final Duration _duration = const Duration(milliseconds: 300);
  final Curve _curve = Curves.easeInOut;

  const CustomNavButton({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(pageNavigationProvider);
    return Container(
      color: Theme.of(context).colorScheme.primary,
      width: double.infinity,
      child: Row(
        children: [
          FloatingActionButton(
            heroTag: 'previous',
            elevation: 0,
            onPressed: () {
              if (pageController.hasClients) {
                pageController.previousPage(duration: _duration, curve: _curve);
              }
            },
            child: const Icon(Icons.navigate_before),
          ),
          Text(page.currentPage > 0
              ? 'Page ${page.currentPage} of ${page.pageCounts}'
              : 'Page ${page.pageCounts}'),
          FloatingActionButton(
            heroTag: 'next',
            elevation: 0,
            onPressed: () {
              if (pageController.hasClients) {
                pageController.nextPage(duration: _duration, curve: _curve);
              }
            },
            child: const Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}
