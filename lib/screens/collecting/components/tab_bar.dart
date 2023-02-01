import 'package:flutter/material.dart';
import 'package:nahpu/screens/collecting/components/collecting_personnel.dart';
import 'package:nahpu/screens/collecting/components/environment_data.dart';
import 'package:nahpu/screens/collecting/components/tool_management.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CollEventTabBar extends StatefulWidget {
  const CollEventTabBar({
    super.key,
    required this.useHorizontalLayout,
    required this.eventID,
  });

  final bool useHorizontalLayout;
  final int eventID;

  @override
  State<CollEventTabBar> createState() => _CollEventTabBarState();
}

class _CollEventTabBarState extends State<CollEventTabBar>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final int _length = 3;

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
    return FormCard(
      withTitle: false,
      child: MediaTabBars(
        length: 2,
        tabController: _tabController,
        tabs: [
          Tab(
            icon: Icon(Icons.group_outlined,
                color: Theme.of(context).colorScheme.tertiary),
          ),
          Tab(
              icon: Icon(MdiIcons.weatherPartlyCloudy,
                  color: Theme.of(context).colorScheme.tertiary)),
          Tab(
              icon: Icon(MdiIcons.toolboxOutline,
                  color: Theme.of(context).colorScheme.tertiary)),
        ],
        children: [
          CollPersonnelForm(eventID: widget.eventID),
          EnvironmentDataView(
            useHorizontalLayout: widget.useHorizontalLayout,
            eventID: widget.eventID,
          ),
          const ToolManagement(),
        ],
      ),
    );
  }
}
