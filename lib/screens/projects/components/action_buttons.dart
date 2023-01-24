import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:nahpu/screens/collecting/components/menu_bar.dart';
import 'package:nahpu/screens/sites/components/menu_bar.dart';
import 'package:nahpu/screens/narrative/components/menu_bar.dart';
import 'package:nahpu/screens/specimens/new_specimens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActionButtons extends ConsumerWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SpeedDial(
      icon: Icons.add,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      direction: SpeedDialDirection.down,
      children: [
        SpeedDialChild(
            child: Icon(Icons.book_rounded,
                color: Theme.of(context).colorScheme.onSecondary),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: 'New Narrative',
            onTap: () async {
              await createNewNarrative(context, ref);
            }),
        SpeedDialChild(
          child: Icon(Icons.place_rounded,
              color: Theme.of(context).colorScheme.onSecondary),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          label: 'New Sites',
          onTap: () async {
            await createNewSite(context, ref);
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.timeline,
              color: Theme.of(context).colorScheme.onSecondary),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          label: 'New CollEvents',
          onTap: () async {
            await createNewCollEvents(context, ref);
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.pets_rounded,
              color: Theme.of(context).colorScheme.onSecondary),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          label: 'New Specimens',
          onTap: () async {
            await createNewSpecimens(context, ref);
          },
        ),
      ],
    );
  }
}
