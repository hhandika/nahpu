import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/collecting/components/collecting_activities.dart';
import 'package:nahpu/screens/collecting/components/collecting_info.dart';
import 'package:nahpu/screens/collecting/components/media.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/indicators.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/screens/shared/photos.dart';

class CollEventForm extends ConsumerStatefulWidget {
  const CollEventForm({Key? key, required this.id, required this.collEventCtr})
      : super(key: key);

  final int id;
  final CollEventFormCtrModel collEventCtr;

  @override
  CollEventFormState createState() => CollEventFormState();
}

class CollEventFormState extends ConsumerState<CollEventForm> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints c) {
        bool useHorizontalLayout = c.maxWidth > 600;
        return SingleChildScrollView(
          child: Column(
            children: [
              AdaptiveLayout(
                useHorizontalLayout: useHorizontalLayout,
                children: [
                  CollectingInfoFields(
                      collEventId: widget.id,
                      useHorizontalLayout: useHorizontalLayout,
                      collEventCtr: widget.collEventCtr),
                  CollActivityFields(
                    collEventId: widget.id,
                    collEventCtr: widget.collEventCtr,
                  ),
                ],
              ),
              AdaptiveLayout(
                useHorizontalLayout: useHorizontalLayout,
                children: [
                  FormCard(
                    title: 'Collecting Effort',
                    child: _buildTrappingFields(),
                  ),
                  FormCard(
                    title: 'Trapping Personnel',
                    child: _buildTrappingPersonnelFields(),
                  ),
                ],
              ),
              CollEventMediaTabBar(useHorizontalLayout: useHorizontalLayout),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTrappingFields() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
          child: TrapList(),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            elevation: 0,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const PhotoForm();
                });
          },
          child: const Text(
            'Add equipments',
          ),
        ),
      ],
    );
  }

  Widget _buildTrappingPersonnelFields() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
          child: TrapList(),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            elevation: 0,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const PhotoForm();
                });
          },
          child: const Text(
            'Add personnels',
          ),
        ),
      ],
    );
  }
}

class TrapList extends ConsumerWidget {
  const TrapList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coordinates = ref.watch(coordinateListProvider);
    return coordinates.when(
      data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.person_rounded),
              title: Text(data[index].siteID ?? ''),
              subtitle: Text(data[index].id ?? ''),
              trailing: IconButton(
                icon: const Icon(Icons.delete_rounded),
                onPressed: () {
                  // ref.read(personnelListProvider.notifier).deletePersonnel(
                  //     data[index].id, data[index].name, data[index].email);
                },
              ),
            );
          },
        );
      },
      loading: () => const CommmonProgressIndicator(),
      error: (error, stack) => Text(error.toString()),
    );
  }
}

class TrappingPersonnelList extends ConsumerWidget {
  const TrappingPersonnelList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coordinates = ref.watch(coordinateListProvider);
    return coordinates.when(
      data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.person_rounded),
              title: Text(data[index].siteID ?? ''),
              subtitle: Text(data[index].id ?? ''),
              trailing: IconButton(
                icon: const Icon(Icons.delete_rounded),
                onPressed: () {
                  // ref.read(personnelListProvider.notifier).deletePersonnel(
                  //     data[index].id, data[index].name, data[index].email);
                },
              ),
            );
          },
        );
      },
      loading: () => const CommmonProgressIndicator(),
      error: (error, stack) => Text(error.toString()),
    );
  }
}
