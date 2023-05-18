import 'package:flutter/material.dart';

class ScrollableLayout extends StatelessWidget {
  const ScrollableLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ScreenLayout(
        child: child,
      ),
    );
  }
}

class CommonPadding extends StatelessWidget {
  const CommonPadding({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0), child: child);
  }
}

class ScreenLayout extends StatelessWidget {
  const ScreenLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: child,
        ),
      ),
    );
  }
}

class AdaptiveMainLayout extends StatelessWidget {
  const AdaptiveMainLayout({
    super.key,
    required this.useHorizontalLayout,
    required this.children,
    required this.height,
  });

  final List<Widget> children;
  final bool useHorizontalLayout;
  final double height;

  @override
  Widget build(BuildContext context) {
    return useHorizontalLayout
        ? ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: height,
            ),
            child: LayoutRow(
              children: children,
            ))
        : LayoutContainer(children: children);
  }
}

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({
    super.key,
    required this.useHorizontalLayout,
    required this.children,
  });

  final List<Widget> children;
  final bool useHorizontalLayout;
  @override
  Widget build(BuildContext context) {
    return useHorizontalLayout
        ? LayoutRow(
            children: children,
          )
        : LayoutContainer(children: children);
  }
}

class LayoutContainer extends StatelessWidget {
  const LayoutContainer({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Column(
        children: children,
      ),
    );
  }
}

class LayoutRow extends StatelessWidget {
  const LayoutRow({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var textField in children)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: textField,
            ),
          ),
      ],
    );
  }
}
