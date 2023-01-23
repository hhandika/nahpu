import 'package:flutter/material.dart';
import 'package:nahpu/screens/collecting/components/environment_data.dart';
import 'package:nahpu/screens/shared/forms.dart';

class CollEventMediaTabBar extends StatefulWidget {
  const CollEventMediaTabBar({super.key, required this.useHorizontalLayout});

  final bool useHorizontalLayout;

  @override
  State<CollEventMediaTabBar> createState() => _CollEventMediaTabBarState();
}

class _CollEventMediaTabBarState extends State<CollEventMediaTabBar>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final int _length = 2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaTabBars(
      length: 2,
      tabController: _tabController,
      tabs: [
        Tab(
            icon: Icon(Icons.wb_sunny_rounded,
                color: Theme.of(context).colorScheme.tertiary)),
        Tab(
            icon: Icon(Icons.camera_alt_rounded,
                color: Theme.of(context).colorScheme.tertiary)),
      ],
      children: [
        EnvironmentDataForm(
          useHorizontalLayout: widget.useHorizontalLayout,
        ),
        const Text('Camera'),
      ],
    );
  }
}
