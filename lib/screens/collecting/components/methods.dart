import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/services/database/collevent_queries.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/styles/catalogs.dart';

class CollMethodForm extends StatelessWidget {
  const CollMethodForm({
    super.key,
    required this.collEventId,
  });

  final int collEventId;

  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: 'Collecting Methods',
      child: SizedBox(
        height: bottomCollEventHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: CollEffortList(collEventId: collEventId),
            ),
            PrimaryButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewCollEffort(collEventId: collEventId),
                    ),
                  );
                },
                text: 'Add Tool'),
            const CommonTextField(
              labelText: 'Notes',
              hintText: 'Notes',
              maxLines: 5,
              isLastField: true,
            ),
          ],
        ),
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
            return CollEffortTile(collEffort: data[index]);
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text(error.toString()),
    );
  }
}

class NewCollEffort extends ConsumerWidget {
  const NewCollEffort({
    super.key,
    required this.collEventId,
  });

  final int collEventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collToolCtr = CollEffortCtrModel.empty();
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Collecting Effort'),
      ),
      body: Center(
          child: CollEffortForm(
        collEffortId: null,
        collEventId: collEventId,
        collToolCtr: collToolCtr,
      )),
    );
  }
}

class EditCollEffort extends ConsumerWidget {
  const EditCollEffort({
    super.key,
    required this.collEffortId,
    required this.collEventId,
    required this.collToolCtr,
  });

  final int collEffortId;
  final int collEventId;
  final CollEffortCtrModel collToolCtr;
  final bool isEditing = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Collecting Effort'),
      ),
      body: Center(
        child: CollEffortForm(
          collEffortId: collEffortId,
          collEventId: collEventId,
          collToolCtr: collToolCtr,
          isEditing: true,
        ),
      ),
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
      subtitle: Subtitle(data: collEffort),
      trailing: CollEffortMenu(
        collEventId: collEffort.eventID!,
        collEffortId: collEffort.id,
        collToolCtr: CollEffortCtrModel.fromData(collEffort),
      ),
    );
  }
}

class Subtitle extends StatelessWidget {
  const Subtitle({
    super.key,
    required this.data,
  });

  final CollEffortData data;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const WidgetSpan(
              child: Icon(Icons.shopping_bag_outlined),
              alignment: PlaceholderAlignment.middle),
          TextSpan(
            text: data.count != null ? '${data.count}' : '0',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const TextSpan(text: ' '),
          const WidgetSpan(
              child: Icon(Icons.domain),
              alignment: PlaceholderAlignment.middle),
          TextSpan(
            text: _getBrand(),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const TextSpan(text: ' '),
          const WidgetSpan(
              child: Icon(MdiIcons.weight),
              alignment: PlaceholderAlignment.middle),
          TextSpan(
            text: _getSize(),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }

  String _getBrand() {
    if (data.brand == null || data.brand!.isEmpty) {
      return 'Unknown';
    } else {
      return data.brand!;
    }
  }

  String _getSize() {
    if (data.size == null || data.size!.isEmpty) {
      return 'N/A';
    } else {
      return data.size!;
    }
  }
}

class CollEffortMenu extends ConsumerStatefulWidget {
  const CollEffortMenu({
    super.key,
    required this.collEventId,
    required this.collEffortId,
    required this.collToolCtr,
  });

  final int collEventId;
  final int collEffortId;
  final CollEffortCtrModel collToolCtr;

  @override
  CollEffortMenuState createState() => CollEffortMenuState();
}

class CollEffortMenuState extends ConsumerState<CollEffortMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CommonPopUpMenuItems>(
      icon: const Icon(Icons.more_vert),
      onSelected: _onSelected,
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: CommonPopUpMenuItems.edit,
          child: ListTile(
            leading: Icon(Icons.edit_outlined),
            title: Text('Edit'),
          ),
        ),
        const PopupMenuItem(
          value: CommonPopUpMenuItems.delete,
          child: ListTile(
            leading: Icon(Icons.delete_outline),
            title: Text('Delete'),
          ),
        ),
      ],
    );
  }

  void _onSelected(CommonPopUpMenuItems item) {
    switch (item) {
      case CommonPopUpMenuItems.edit:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditCollEffort(
              collEffortId: widget.collEffortId,
              collEventId: widget.collEventId,
              collToolCtr: widget.collToolCtr,
            ),
          ),
        );
        break;
      case CommonPopUpMenuItems.delete:
        CollEffortQuery(ref.read(databaseProvider)).deleteCollEffort(
          widget.collEffortId,
        );
        ref.invalidate(collEffortByEventProvider);
        break;
    }
  }
}

class CollEffortForm extends ConsumerStatefulWidget {
  const CollEffortForm({
    super.key,
    required this.collEffortId,
    required this.collEventId,
    required this.collToolCtr,
    this.isEditing = false,
  });

  final int? collEffortId;
  final int collEventId;
  final CollEffortCtrModel collToolCtr;
  final bool isEditing;

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
              controller: widget.collToolCtr.typeCtr,
              decoration: const InputDecoration(
                labelText: 'Type',
                hintText: 'Enter the type of the tool',
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
                    widget.isEditing ? _updateCollEffort() : _addCollEffort();
                    ref.invalidate(collEffortByEventProvider);
                    Navigator.pop(context);
                  },
                  text: widget.isEditing ? 'Update' : 'Add',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateCollEffort() async {
    final form = _getForm();
    try {
      await CollEffortQuery(ref.read(databaseProvider))
          .updateCollEffortEntry(widget.collEffortId!, form);
    } catch (e) {
      AlertDialog alert = AlertDialog(
        title: const Text('Error'),
        content: Text(e.toString()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  Future<void> _addCollEffort() async {
    final form = _getForm();
    await CollEffortQuery(ref.read(databaseProvider)).createCollEffort(form);
  }

  CollEffortCompanion _getForm() {
    return CollEffortCompanion(
      eventID: db.Value(widget.collEventId),
      type: db.Value(widget.collToolCtr.typeCtr.text),
      brand: db.Value(widget.collToolCtr.brandCtr.text),
      count: db.Value(int.tryParse(widget.collToolCtr.countCtr.text) ?? 0),
      size: db.Value(widget.collToolCtr.sizeCtr.text),
      notes: db.Value(widget.collToolCtr.noteCtr.text),
    );
  }
}
