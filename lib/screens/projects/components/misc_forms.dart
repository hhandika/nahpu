import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/screens/projects/components/expenses.dart';
import 'package:nahpu/screens/projects/components/permits.dart';
import 'package:nahpu/screens/projects/components/statistics.dart';
import 'package:nahpu/screens/shared/forms.dart';

class MiscForm extends ConsumerStatefulWidget {
  const MiscForm({Key? key}) : super(key: key);

  @override
  MiscFormState createState() => MiscFormState();
}

class MiscFormState extends ConsumerState<MiscForm>
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 10,
        ),
        child: MediaTabBars(
          tabController: _tabController,
          length: _length,
          height: 0.4,
          tabs: [
            Tab(
                icon: Icon(Icons.bar_chart_rounded,
                    color: Theme.of(context).colorScheme.tertiary)),
            Tab(
                icon: Icon(Icons.receipt_long_rounded,
                    color: Theme.of(context).colorScheme.tertiary)),
            Tab(
                icon: Icon(MdiIcons.fileDocumentMultipleOutline,
                    color: Theme.of(context).colorScheme.tertiary)),
          ],
          children: const [
            StatisticViewer(),
            ReceiptViewer(),
            PermitViewer(),
          ],
        ),
      ),
    );
  }
}
