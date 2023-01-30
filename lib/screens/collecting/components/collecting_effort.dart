import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/forms.dart';

class CollectingEffortFrom extends StatelessWidget {
  const CollectingEffortFrom({super.key});

  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: 'Collecting Effort',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const ToolTile(),
          PrimaryButton(onPressed: () {}, text: 'Add Tool'),
        ],
      ),
    );
  }
}

class ToolTile extends ConsumerWidget {
  const ToolTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Text('ToolTile');
    // final coordinates = ref.watch(coordinateListProvider);
    // return coordinates.when(
    //   data: (data) {
    //     return ListView.builder(
    //       itemCount: data.length,
    //       itemBuilder: (context, index) {
    //         return ListTile(
    //           leading: const Icon(Icons.person_rounded),
    //           title: Text(data[index].nameId ?? ''),
    //           subtitle: Text(data[index].gpsUnit ?? ''),
    //           trailing: IconButton(
    //             icon: const Icon(Icons.delete_rounded),
    //             onPressed: () {
    //               // ref.read(personnelListProvider.notifier).deletePersonnel(
    //               //     data[index].id, data[index].name, data[index].email);
    //             },
    //           ),
    //         );
    //       },
    //     );
    //   },
    //   loading: () => const CommmonProgressIndicator(),
    //   error: (error, stack) => Text(error.toString()),
    // );
  }
}
