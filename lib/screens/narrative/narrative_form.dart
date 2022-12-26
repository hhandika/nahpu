import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as db;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/providers/updater.dart';
import 'package:nahpu/screens/narrative/components/media.dart';
import 'package:nahpu/screens/narrative/components/top_forms.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';

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
              FormCard(
                isPrimary: true,
                withTitle: false,
                child: AdaptiveLayout(
                  useHorizontalLayout: useHorizontalLayout,
                  children: [
                    DateForm(
                      narrativeId: widget.narrativeId,
                      narrativeCtr: widget.narrativeCtr,
                    ),
                    SiteForm(
                      narrativeId: widget.narrativeId,
                      narrativeCtr: widget.narrativeCtr,
                    ),
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
      },
    );
  }
}
