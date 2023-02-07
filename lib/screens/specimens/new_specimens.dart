import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/settings.dart';
import 'package:nahpu/screens/specimens/shared/menu_bar.dart';
import 'package:nahpu/screens/specimens/specimen_form.dart';
import 'package:nahpu/screens/specimens/specimen_view.dart';
import 'package:nahpu/services/specimen_services.dart';

Future<void> createNewSpecimens(BuildContext context, WidgetRef ref) {
  String specimenUuid = SpecimenServices(ref).createSpecimen();
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => NewSpecimenForm(
        specimenUuid: specimenUuid,
      ),
    ),
  );
}

class NewSpecimens extends ConsumerWidget {
  const NewSpecimens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.add_circle_outline_rounded),
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
            ref.invalidate(specimenEntryProvider);
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
