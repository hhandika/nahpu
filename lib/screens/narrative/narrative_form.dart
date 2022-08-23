import 'package:adaptive_components/adaptive_components.dart';
import 'package:flutter/material.dart';

import 'package:drift/drift.dart' as db;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';
import 'package:nahpu/configs/colors.dart';
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
      bool useHorizontalLayout = constraints.maxWidth > 400.0;
      return SingleChildScrollView(
        child: AdaptiveColumn(children: [
          AdaptiveContainer(
            columnSpan: 12,
            child: useHorizontalLayout
                ? Row(
                    children: [
                      Expanded(child: _buildDateForm()),
                      const SizedBox(width: 10),
                      Expanded(child: _buildSiteIdForm()),
                    ],
                  )
                : Column(
                    children: [
                      _buildDateForm(),
                      _buildSiteIdForm(),
                    ],
                  ),
          ),
          AdaptiveContainer(
            columnSpan: 12,
            child: TextFormField(
              controller: widget.narrativeController,
              maxLines: useHorizontalLayout ? 20 : 10,
              decoration: const InputDecoration(
                labelText: 'Narrative',
                hintText: 'Enter narrative',
              ),
              onChanged: (value) {
                _updateNarrative(
                    NarrativeCompanion(narrative: db.Value(value)));
              },
            ),
          ),
          AdaptiveContainer(
            columnSpan: 12,
            child: const MediaForm(),
          ),
        ]),
      );
    });
  }

  Widget _buildSiteIdForm() {
    return TextFormField(
      controller: widget.siteController,
      decoration: const InputDecoration(
        labelText: 'Site ID',
        hintText: 'Enter a site',
      ),
      onChanged: (value) {
        _updateNarrative(NarrativeCompanion(siteID: db.Value(value)));
      },
    );
  }

  Widget _buildDateForm() {
    return TextFormField(
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
            widget.dateController.text = DateFormat.yMMMd().format(date);
            _updateNarrative(
                NarrativeCompanion(date: db.Value(widget.dateController.text)));
          }
        });
      },
    );
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
            indicatorColor: NahpuColor.tabBarColor(context),
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
