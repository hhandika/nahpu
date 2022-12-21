import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as db;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nahpu/configs/colors.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/providers/updater.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/screens/shared/photos.dart';
import 'package:nahpu/screens/shared/videos.dart';

class NarrativeForm extends ConsumerStatefulWidget {
  const NarrativeForm({
    Key? key,
    required this.narrativeId,
    required this.narrativeCtr,
  }) : super(key: key);

  final int narrativeId;
  final NarrativeFormCtrModel narrativeCtr;

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
        child: Column(
          children: [
            Card(
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: AdaptiveLayout(
                useHorizontalLayout: useHorizontalLayout,
                children: [
                  _buildDateForm(),
                  _buildSiteIdForm(),
                ],
              ),
            ),
            Card(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: widget.narrativeCtr.narrativeCtr,
                  maxLines: useHorizontalLayout ? 20 : 10,
                  decoration: const InputDecoration(
                    labelText: 'Narrative',
                    hintText: 'Enter narrative',
                  ),
                  onChanged: (value) {
                    updateNarrative(widget.narrativeId,
                        NarrativeCompanion(narrative: db.Value(value)), ref);
                  },
                ),
              ),
            ),
            const MediaForm(),
          ],
        ),
      );
    });
  }

  Widget _buildSiteIdForm() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: widget.narrativeCtr.siteCtr,
        decoration: const InputDecoration(
          labelText: 'Site ID',
          hintText: 'Enter a site',
        ),
        onChanged: (value) {
          updateNarrative(widget.narrativeId,
              NarrativeCompanion(siteID: db.Value(value)), ref);
        },
      ),
    );
  }

  Widget _buildDateForm() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Date',
          hintText: 'Enter date',
        ),
        controller: widget.narrativeCtr.dateCtr,
        onTap: () async {
          final selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime.now());
          if (selectedDate != null) {
            widget.narrativeCtr.dateCtr.text =
                DateFormat.yMMMd().format(selectedDate);
            updateNarrative(
                widget.narrativeId,
                NarrativeCompanion(
                    date: db.Value(widget.narrativeCtr.dateCtr.text)),
                ref);
          }
        },
      ),
    );
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
              PhotoViewer(),
              VideoViewer(),
            ],
          ),
        ),
      ],
    );
  }
}
