import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/forms.dart';

class TaxonRegistryViewer extends ConsumerStatefulWidget {
  const TaxonRegistryViewer({super.key});

  @override
  TaxonRegistryViewerState createState() => TaxonRegistryViewerState();
}

class TaxonRegistryViewerState extends ConsumerState<TaxonRegistryViewer> {
  @override
  Widget build(BuildContext context) {
    return FormCard(
        title: 'Taxon Registry',
        child: Column(children: [
          const SizedBox(height: 200, child: TaxonRegistryList()),
          CommonButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => const TaxonRegistryForm());
            },
            text: 'Add taxon',
          ),
          const SizedBox(height: 10),
        ]));
  }
}

class TaxonRegistryForm extends StatelessWidget {
  const TaxonRegistryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add taxon'),
      content: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Class',
              hintText: 'Enter a class',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Order',
              hintText: 'Enter an order',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Family',
              hintText: 'Enter a family',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Notes',
              hintText: 'Enter notes',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Taxon',
              hintText: 'Enter a taxon',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Common name',
              hintText: 'Enter a common name',
            ),
          ),
        ],
      ),
    );
  }
}

class TaxonRegistryList extends ConsumerStatefulWidget {
  const TaxonRegistryList({super.key});

  @override
  TaxonRegistryListState createState() => TaxonRegistryListState();
}

class TaxonRegistryListState extends ConsumerState<TaxonRegistryList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Taxon $index'),
          subtitle: Text('Class $index'),
        );
      },
    );
  }
}
