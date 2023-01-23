import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/projects/components/expenses.dart';
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
          height: 0.3,
          tabs: [
            Tab(
                icon: Icon(Icons.bar_chart_rounded,
                    color: Theme.of(context).colorScheme.tertiary)),
            Tab(
                icon: Icon(Icons.receipt_long_rounded,
                    color: Theme.of(context).colorScheme.tertiary)),
          ],
          children: const [
            StatisticViewer(),
            ReceiptViewer(),
          ],
        ),
      ),
    );
  }
}
