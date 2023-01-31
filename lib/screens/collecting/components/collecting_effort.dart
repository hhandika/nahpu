import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/services/database.dart';

class CollectingEffortFrom extends StatelessWidget {
  const CollectingEffortFrom({
    super.key,
    required this.collEventId,
  });

  final int collEventId;

  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: 'Collecting Effort',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CollEffortList(collEventId: collEventId),
          PrimaryButton(onPressed: () {}, text: 'Add Tool'),
        ],
      ),
    );
  }
}

class CollEffortList extends ConsumerWidget {
  const CollEffortList({
    super.key,
    required this.collEventId,
  });

  final int collEventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collEffort = ref.watch(collEffortByEventProvider(collEventId));
    return collEffort.when(
      data: (data) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            data.isEmpty
                ? const Text('No tools used')
                : CollEffortTile(collEffort: data[index]);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Text(error.toString()),
    );
  }
}

class CollEffortTile extends StatelessWidget {
  const CollEffortTile({
    super.key,
    required this.collEffort,
  });

  final CollEffortData collEffort;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(collEffort.type ?? ''),
      subtitle: Text(collEffort.brand ?? ''),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {},
      ),
    );
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
