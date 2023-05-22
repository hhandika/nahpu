import 'package:flutter/material.dart';
import 'package:nahpu/screens/collecting/components/personnel.dart';
import 'package:nahpu/screens/collecting/components/weather_data.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/styles/catalog_pages.dart';

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
      withTitle: false,
      child: MediaTabBars(
        length: _length,
        tabController: _tabController,
        height: bottomCollEventHeight,
        tabs: [
          Tab(
            icon: Icon(Icons.group_outlined,
                color: Theme.of(context).colorScheme.tertiary),
          ),
          Tab(
              icon: Icon(MdiIcons.weatherPartlyCloudy,
                  color: Theme.of(context).colorScheme.tertiary)),
        ],
        children: [
          CollPersonnelForm(eventID: widget.eventID),
          WeatherDataView(
            useHorizontalLayout: widget.useHorizontalLayout,
            eventID: widget.eventID,
          ),
        ],
      ),
    );
  }
}
