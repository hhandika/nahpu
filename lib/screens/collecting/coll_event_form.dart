import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';

class CollEventForm extends ConsumerStatefulWidget {
  const CollEventForm({Key? key, required this.collEventFormController})
      : super(key: key);

  final CollEventFormCtrModel collEventFormController;

  @override
  CollEventFormState createState() => CollEventFormState();
}

class CollEventFormState extends ConsumerState<CollEventForm> {
  @override
  Widget build(BuildContext context) {
    return const Text("Collecting Event Form");
  }
}
