import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/services/database.dart';

class TaxonRegistryViewer extends ConsumerStatefulWidget {
  const TaxonRegistryViewer({super.key});

  @override
  TaxonRegistryViewerState createState() => TaxonRegistryViewerState();
}

class TaxonRegistryViewerState extends ConsumerState<TaxonRegistryViewer> {
  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: 'Taxon registry',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: const TaxonRegistryInfo()),
          Wrap(
            spacing: 10,
            children: [
              SecondaryButton(
                  text: 'Show',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TaxonRegistryList(),
                      ),
                    );
                  }),
              PrimaryButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TaxonEntryForm(),
                    ),
                  );
                },
                text: 'Add taxon',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TaxonRegistryInfo extends ConsumerWidget {
  const TaxonRegistryInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(children: const []);
  }
}

class TaxonEntryForm extends ConsumerStatefulWidget {
  const TaxonEntryForm({super.key});

  @override
  TaxonEntryFormState createState() => TaxonEntryFormState();
}

class TaxonEntryFormState extends ConsumerState<TaxonEntryForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taxon entry'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                  labelText: 'Genus',
                  hintText: 'Enter a genus',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Specific epithet',
                  hintText: 'Enter specific epithet',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Intraspecific epithet',
                  hintText: 'Enter intraspecific epithet',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Common name',
                  hintText: 'Enter a common name',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  hintText: 'Enter notes',
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taxon registry'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Taxon $index'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TaxonEntryForm(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TaxonList extends ConsumerWidget {
  const TaxonList({super.key, required this.taxonList});

  final List<TaxonomyData> taxonList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: taxonList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(taxonList[index].taxonFamily ?? 'Unknown family'),
          subtitle: Text(
              '${taxonList[index].genus} ${taxonList[index].specificEpithet}'),
          onTap: () {},
        );
      },
    );
  }
}
