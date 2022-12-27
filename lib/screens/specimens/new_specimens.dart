import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/catalog.dart';
import 'package:nahpu/screens/specimens/shared/menu_bar.dart';
// import 'package:nahpu/providers/page_viewer.dart';
import 'package:nahpu/screens/specimens/specimen_form.dart';
import 'package:nahpu/screens/specimens/specimen_view.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/database/database.dart';
import 'package:nahpu/providers/project.dart';

Future<void> createNewSpecimens(BuildContext context, WidgetRef ref) {
  String projectUuid = ref.watch(projectUuidProvider);
  CatalogFmt catalogFmt = ref.watch(catalogFmtNotifier);
  final String specimenUuid = uuid;
  ref.read(databaseProvider).createSpecimen(SpecimenCompanion(
        uuid: db.Value(specimenUuid),
        projectUuid: db.Value(projectUuid),
        taxonGroup: db.Value(matchCatFmtToTaxonGroup(catalogFmt)),
      ));

  return Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => NewSpecimenForm(
            specimenUuid: specimenUuid,
          )));
}

class NewSpecimens extends ConsumerWidget {
  const NewSpecimens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.add_rounded),
      onPressed: () async {
        createNewSpecimens(context, ref);
      },
    );
  }
}

class NewSpecimenForm extends ConsumerStatefulWidget {
  const NewSpecimenForm({Key? key, required this.specimenUuid})
      : super(key: key);

  final String specimenUuid;

  @override
  NewSpecimenFormState createState() => NewSpecimenFormState();
}

class NewSpecimenFormState extends ConsumerState<NewSpecimenForm> {
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  final _specimenCtr = SpecimenFormCtrModel.empty();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalogFmt = ref.watch(catalogFmtNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Specimens"),
        leading: BackButton(
          onPressed: () {
            // ref.refresh(pageNavigationProvider);
            // ref.refresh(specimenEntryProvider);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Specimens()));
          },
        ),
        actions: const [
          NewSpecimens(),
          SpecimenMenu(),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SpecimenForm(
        specimenUuid: widget.specimenUuid,
        specimenCtr: _specimenCtr,
        catalogFmt: catalogFmt,
      ),
    );
  }
}
