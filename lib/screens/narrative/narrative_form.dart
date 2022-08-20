import 'package:flutter/material.dart';

import 'package:drift/drift.dart' as db;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/providers/project.dart';

class NarrativeForm extends ConsumerStatefulWidget {
  const NarrativeForm(
      {Key? key,
      required this.narrativeId,
      required this.narrativeController,
      required this.dateController})
      : super(key: key);

  final TextEditingController dateController;
  final TextEditingController narrativeController;
  final int narrativeId;

  @override
  NarrativeFormState createState() => NarrativeFormState();
}

class NarrativeFormState extends ConsumerState<NarrativeForm>
    with TickerProviderStateMixin {
  late TabController _tabController;
  // final int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final narrative = ref.watch(databaseProvider);
    return SingleChildScrollView(
        child: Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Date',
            hintText: 'Enter date',
          ),
          controller: widget.dateController,
          onTap: () async {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now())
                .then((date) {
              if (date != null) {
                widget.dateController.text = DateFormat.yMMMd().format(date);
                narrative.updateNarrativeEntry(
                    widget.narrativeId,
                    NarrativeCompanion(
                        date: db.Value(widget.dateController.text)));
              }
            });
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Site ID',
            hintText: 'Enter a site',
          ),
          onChanged: (value) {
            narrative.updateNarrativeEntry(widget.narrativeId,
                NarrativeCompanion(siteID: db.Value(value)));
          },
        ),
        TextFormField(
          maxLines: 10,
          decoration: const InputDecoration(
            labelText: 'Narrative',
            hintText: 'Enter narrative',
          ),
          onChanged: (value) {
            narrative.updateNarrativeEntry(
                1, NarrativeCompanion(narrative: db.Value(value)));
          },
        ),
        Column(
          children: [
            DefaultTabController(
              length: 2,
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                      icon: Icon(Icons.photo_album_rounded,
                          color: Theme.of(context).colorScheme.tertiary)),
                  Tab(
                      icon: Icon(Icons.video_library_rounded,
                          color: Theme.of(context).colorScheme.tertiary)),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  Text('Photos'),
                  Text('Videos'),
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
