import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/catalogs.dart';

import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/projects/dashboard.dart';

class ProjectBackButton extends ConsumerWidget {
  const ProjectBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BackButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const Dashboard();
        }));
        ref.read(projectNavbarIndexProvider.notifier).state = 0;
      },
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
      {super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ),
        foregroundColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).colorScheme.surface,
        // elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class CustomPageNavButton extends ConsumerWidget {
  final Duration _duration = const Duration(milliseconds: 300);
  final Curve _curve = Curves.easeInOut;

  const CustomPageNavButton({
    Key? key,
    required this.pageController,
    required this.pageNav,
  }) : super(key: key);

  final PageController pageController;
  final PageNavigation pageNav;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final page = ref.watch(pageNavigationProvider);
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: pageNav.isFirstPage
                ? null
                : () {
                    if (pageController.hasClients) {
                      pageController.previousPage(
                          duration: _duration, curve: _curve);
                    }
                  },
            child: const Icon(Icons.navigate_before),
          ),
          FittedBox(
            child: Text(
              'Page ${pageNav.currentPage} of ${pageNav.pageCounts}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          TextButton(
            onPressed: pageNav.isLastPage
                ? null
                : () {
                    if (pageController.hasClients) {
                      pageController.nextPage(
                          duration: _duration, curve: _curve);
                    }
                  },
            child: const Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}
