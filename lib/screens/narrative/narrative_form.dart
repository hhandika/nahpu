import 'package:flutter/material.dart';
import 'package:adaptive_components/adaptive_components.dart';

import 'package:drift/drift.dart' as db;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/providers/project.dart';
import 'package:nahpu/providers/narrative.dart';

class NarrativeForm extends ConsumerStatefulWidget {
  const NarrativeForm({
    Key? key,
    required this.narrativeId,
    required this.dateController,
    required this.siteController,
    required this.narrativeController,
  }) : super(key: key);

  final TextEditingController dateController;
  final TextEditingController siteController;
  final TextEditingController narrativeController;
  final int narrativeId;

  @override
  NarrativeFormState createState() => NarrativeFormState();
}

class NarrativeFormState extends ConsumerState<NarrativeForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: AdaptiveColumn(
      children: [
        AdaptiveContainer(
            columnSpan: 12,
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
                        widget.dateController.text =
                            DateFormat.yMMMd().format(date);
                        _updateNarrative(NarrativeCompanion(
                            date: db.Value(widget.dateController.text)));
                      }
                    });
                  },
                ),
                TextFormField(
                  controller: widget.siteController,
                  decoration: const InputDecoration(
                    labelText: 'Site ID',
                    hintText: 'Enter a site',
                  ),
                  onChanged: (value) {
                    _updateNarrative(
                        NarrativeCompanion(siteID: db.Value(value)));
                  },
                ),
                TextFormField(
                  controller: widget.narrativeController,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    labelText: 'Narrative',
                    hintText: 'Enter narrative',
                  ),
                  onChanged: (value) {
                    _updateNarrative(
                        NarrativeCompanion(narrative: db.Value(value)));
                  },
                ),
                const MediaForm(),
              ],
            ))
      ],
    ));
  }

  void _updateNarrative(NarrativeCompanion entries) {
    ref
        .watch(databaseProvider)
        .updateNarrativeEntry(widget.narrativeId, entries);
    ref.refresh(narrativeEntryProvider.future);
  }
}

class MediaForm extends ConsumerStatefulWidget {
  const MediaForm({Key? key}) : super(key: key);

  @override
  MediaFormState createState() => MediaFormState();
}

class MediaFormState extends ConsumerState<MediaForm>
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
    return Column(
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
    );
  }
}
