import 'package:flutter/material.dart';

import 'package:drift/drift.dart' as db;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/providers/project.dart';

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
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool useVerticalLayout = constraints.maxWidth < 400.0;
      return SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Flex(
              direction: useVerticalLayout ? Axis.vertical : Axis.horizontal,
              children: [
                Flexible(
                    child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    hintText: 'Enter date',
                  ),
                  controller: widget.dateController,
                  onTap: () {
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
                )),
                SizedBox(width: useVerticalLayout ? 0.0 : 10.0),
                Flexible(
                  child: TextFormField(
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
                ),
              ],
            ),
          ),
          TextFormField(
            controller: widget.narrativeController,
            maxLines: 10,
            decoration: const InputDecoration(
              labelText: 'Narrative',
              hintText: 'Enter narrative',
            ),
            onChanged: (value) {
              _updateNarrative(NarrativeCompanion(narrative: db.Value(value)));
            },
          ),
          const MediaForm(),
        ]),
      );
    });
  }

  void _updateNarrative(NarrativeCompanion entries) {
    ref
        .read(databaseProvider)
        .updateNarrativeEntry(widget.narrativeId, entries);
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
