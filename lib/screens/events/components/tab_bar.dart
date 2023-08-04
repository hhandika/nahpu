import 'package:flutter/material.dart';
import 'package:nahpu/screens/events/components/personnel.dart';
import 'package:nahpu/screens/events/components/weather_data.dart';
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
    return FormCard(
      isWithTitle: false,
      isWithSidePadding: false,
      child: CommonTabBars(
        length: _length,
        tabController: _tabController,
        height: 421,
        tabs: [
          const Tab(
            icon: Icon(Icons.groups_2_outlined),
          ),
          Tab(icon: Icon(MdiIcons.weatherPartlyCloudy)),
        ],
        children: [
          CollectingPersonnelForm(eventID: widget.eventID),
          WeatherDataView(
            useHorizontalLayout: widget.useHorizontalLayout,
            eventID: widget.eventID,
          ),
        ],
      ),
    );
  }
}
