import 'package:flutter/material.dart';

/// A layout that centers its child and constrains its width to 500.
/// Add padding to the child.
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
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 16),
          child: child,
        ),
      ),
    );
  }
}

class CommonScrollbar extends StatelessWidget {
  const CommonScrollbar({
    super.key,
    required this.scrollController,
    required this.child,
  });

  final ScrollController scrollController;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        thumbVisibility: true,
        controller: scrollController,
        thickness: 3,
        child: child);
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
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0), child: child);
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
              withPadding: false,
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
    return CommonPadding(
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
    this.withPadding = true,
  });

  final List<Widget> children;
  final bool withPadding;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var textField in children)
          Expanded(
            child: withPadding ? CommonPadding(child: textField) : textField,
          ),
      ],
    );
  }
}
