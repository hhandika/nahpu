import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as db;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/screens/narrative/components/media.dart';
import 'package:nahpu/screens/narrative/components/top_forms.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/narrative_services.dart';

class NarrativeForm extends ConsumerStatefulWidget {
  const NarrativeForm({
    super.key,
    required this.narrativeId,
    required this.narrativeCtr,
  });

  final int narrativeId;
  final NarrativeFormCtrModel narrativeCtr;

  @override
  NarrativeFormState createState() => NarrativeFormState();
}

class NarrativeFormState extends ConsumerState<NarrativeForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.narrativeCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool useHorizontalLayout = constraints.maxWidth > 400.0;
        return FocusDetectedLayout(
          children: [
            FormCard(
              isPrimary: true,
              isWithTitle: false,
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
            FormCard(
              isPrimary: false,
              isWithTitle: false,
              child: CommonPadding(
                child: TextField(
                  controller: widget.narrativeCtr.narrativeCtr,
                  maxLines: 20,
                  decoration: const InputDecoration(
                    labelText: 'Narrative',
                    hintText: 'Enter narrative',
                  ),
                  onChanged: (value) {
                    NarrativeServices(ref: ref).updateNarrative(
                      widget.narrativeId,
                      NarrativeCompanion(narrative: db.Value(value)),
                    );
                  },
                ),
              ),
            ),
            NarrativeMediaForm(
              narrativeId: widget.narrativeId,
            ),
            const BottomPadding()
          ],
        );
      },
    );
  }
}
