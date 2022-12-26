import 'package:nahpu/providers/page_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/indicators.dart';

class CoordinateFields extends StatelessWidget {
  const CoordinateFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: 'Coordinates',
      child: Column(
        children: [
          const SizedBox(
            height: 10,
            child: CoordinateList(),
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
                    return const CoordinateForms();
                  });
            },
            child: const Text(
              'Add coordinates',
            ),
          ),
        ],
      ),
    );
  }
}

class CoordinateForms extends ConsumerWidget {
  const CoordinateForms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Add a coordinate'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Latitude',
              hintText: 'Add a latitude',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Longitude',
              hintText: 'Add a longitude',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Elevation',
              hintText: 'Add an elevation',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Datum',
              hintText: 'Add a datum',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Uncertainty',
              hintText: 'Add an uncertainty',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'GPS Unit',
              hintText: 'Specify the GPS unit',
            ),
          ),
          TextFormField(
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Notes',
              hintText: 'Add notes (optional)',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              elevation: 0,
            ),
            onPressed: () {},
            child: const Text(
              'Add',
            ),
          ),
        ],
      ),
    );
  }
}

class CoordinateList extends ConsumerWidget {
  const CoordinateList({
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
