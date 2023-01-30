import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/indicators.dart';

class CollectingPersonnelForm extends ConsumerWidget {
  const CollectingPersonnelForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
          child: CollectingPersonnelTile(),
        ),
        PrimaryButton(
          text: 'Add Personnel',
          onPressed: () {},
        )
      ],
    );
  }
}

class CollectingPersonnelTile extends ConsumerWidget {
  const CollectingPersonnelTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coordinates = ref.watch(personnelListProvider);
    return coordinates.when(
      data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.person_rounded),
              title: Text(data[index].name ?? ''),
              subtitle: Text(data[index].role ?? ''),
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
