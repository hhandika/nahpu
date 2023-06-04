import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:nahpu/providers/settings.dart';
import 'package:nahpu/screens/collecting/components/menu_bar.dart';
import 'package:nahpu/screens/sites/components/menu_bar.dart';
import 'package:nahpu/screens/narrative/components/menu_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/specimens/shared/menu_bar.dart';
import 'package:nahpu/services/types/types.dart';

class ActionButtons extends ConsumerWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CatalogFmt catalogFmt = ref.read(catalogFmtNotifier);
    return SpeedDial(
      icon: Icons.add,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      direction: SpeedDialDirection.down,
      children: [
        SpeedDialChild(
          child: Icon(Icons.place_outlined,
              color: Theme.of(context).colorScheme.onSecondary),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          label: 'Create Site',
          onTap: () async {
            await createNewSite(context, ref);
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.timeline,
              color: Theme.of(context).colorScheme.onSecondary),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          label: 'Create CollEvent',
          onTap: () async {
            await createNewCollEvents(context, ref);
          },
        ),
        SpeedDialChild(
          child: Icon(matchCatFmtToIcon(catalogFmt, false),
              color: Theme.of(context).colorScheme.onSecondary),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          label: 'Create Specimen',
          onTap: () async {
            await createNewSpecimens(context, ref);
          },
        ),
        SpeedDialChild(
            child: Icon(Icons.book_outlined,
                color: Theme.of(context).colorScheme.onSecondary),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: 'Create Narrative',
            onTap: () async {
              await createNewNarrative(context, ref);
            }),
      ],
    );
  }
}
