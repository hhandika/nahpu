import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
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

class CollEffortForm extends ConsumerStatefulWidget {
  const CollEffortForm({
    super.key,
    required this.collEventId,
    required this.collToolCtr,
  });

  final int? collEventId;
  final CollectingToolCtrModel collToolCtr;

  @override
  CollEffortFormState createState() => CollEffortFormState();
}

class CollEffortFormState extends ConsumerState<CollEffortForm> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: widget.collToolCtr.nameCtr,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter name of the tool',
              ),
            ),
            TextFormField(
              controller: widget.collToolCtr.brandCtr,
              decoration: const InputDecoration(
                labelText: 'Brand and Model',
                hintText: 'Enter brand and Model of the tool',
              ),
            ),
            TextFormField(
              controller: widget.collToolCtr.countCtr,
              decoration: const InputDecoration(
                labelText: 'Count',
                hintText: 'How many of this tool were used?',
              ),
            ),
            TextFormField(
              controller: widget.collToolCtr.sizeCtr,
              decoration: const InputDecoration(
                labelText: 'Size',
                hintText: 'Enter size of the tool (if applicable)',
              ),
            ),
            TextFormField(
              controller: widget.collToolCtr.noteCtr,
              decoration: const InputDecoration(
                labelText: 'Notes',
                hintText: 'Enter any notes about the tool (if applicable)',
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                SecondaryButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Cancel',
                ),
                const SizedBox(width: 20),
                PrimaryButton(
                  onPressed: () {
                    // ref.read(personnelListProvider.notifier).addPersonnel(
                    //     widget.personnelCtr.nameCtr.text,
                    //     widget.personnelCtr.emailCtr.text,
                    //     widget.personnelCtr.roleCtr.text);
                    // Navigator.pop(context);
                  },
                  text: 'Add',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
