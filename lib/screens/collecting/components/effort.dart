import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/providers/collevents.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/utility_services.dart';
import 'package:nahpu/styles/catalog_pages.dart';

class CollEffort extends StatelessWidget {
  const CollEffort({
    super.key,
    required this.collEventId,
  });

  final int collEventId;

  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: 'Collecting Effort',
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
                text: 'Add Method'),
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
        title: const Text('New Collecting Method'),
        automaticallyImplyLeading: false,
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
        title: const Text('Edit Collecting Method'),
        automaticallyImplyLeading: false,
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
      title: CollEffortTitle(
        type: collEffort.method,
        count: collEffort.count,
      ),
      subtitle: Subtitle(data: collEffort),
      trailing: CollEffortMenu(
        collEventId: collEffort.eventID!,
        collEffortId: collEffort.id,
        collToolCtr: CollEffortCtrModel.fromData(collEffort),
      ),
    );
  }
}

class CollEffortTitle extends StatelessWidget {
  const CollEffortTitle({
    super.key,
    required this.type,
    required this.count,
  });

  final String? type;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${type ?? 'Unknown'}'
      '$listTileSeparator'
      '${count ?? 'No count'}',
      style: Theme.of(context).textTheme.titleMedium,
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
    return Text(
      '${_getSize()}'
      '$listTileSeparator'
      '${_getBrand()}',
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
      itemBuilder: (context) => <PopupMenuEntry<CommonPopUpMenuItems>>[
        const PopupMenuItem(
          value: CommonPopUpMenuItems.edit,
          child: ListTile(
            leading: Icon(Icons.edit_outlined),
            title: Text('Edit'),
          ),
        ),
        const PopupMenuDivider(
          height: 10,
        ),
        const PopupMenuItem(
          value: CommonPopUpMenuItems.delete,
          child: ListTile(
            leading: Icon(Icons.delete_outline, color: Colors.red),
            title: Text('Delete', style: TextStyle(color: Colors.red)),
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
        CollEventServices(ref).deleteCollEffort(
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
    return ScrollableLayout(
      child: Column(
        children: [
          CollectionMethods(ctr: widget.collToolCtr),
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
    );
  }

  Future<void> _updateCollEffort() async {
    final form = _getForm();
    try {
      await CollEventServices(ref)
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
    await CollEventServices(ref).createCollEffort(form);
  }

  CollEffortCompanion _getForm() {
    return CollEffortCompanion(
      eventID: db.Value(widget.collEventId),
      method: db.Value(widget.collToolCtr.methodCtr),
      brand: db.Value(widget.collToolCtr.brandCtr.text),
      count: db.Value(int.tryParse(widget.collToolCtr.countCtr.text) ?? 0),
      size: db.Value(widget.collToolCtr.sizeCtr.text),
      notes: db.Value(widget.collToolCtr.noteCtr.text),
    );
  }
}

class CollectionMethods extends ConsumerWidget {
  const CollectionMethods({
    super.key,
    required this.ctr,
  });

  final CollEffortCtrModel ctr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(collEventMethodProvider).when(
          data: (data) {
            if (kDebugMode) {
              print('Collection Methods: $data');
            }
            return DropdownButtonFormField(
              value: ctr.methodCtr,
              decoration: const InputDecoration(
                labelText: 'Method',
                hintText: 'Select a method',
              ),
              items: data
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: CommonDropdownText(text: e),
                    ),
                  )
                  .toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  ctr.methodCtr = newValue;
                }
              },
            );
          },
          loading: () => const CommonProgressIndicator(),
          error: (e, __) => Text(e.toString()),
        );
  }
}
