import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/taxa.dart';
import 'package:nahpu/screens/projects/taxonomy/import_taxa.dart';
import 'package:nahpu/screens/projects/taxonomy/new_taxa.dart';
import 'package:nahpu/screens/projects/taxonomy/taxon_list.dart';
import 'package:nahpu/providers/specimens.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/projects/taxonomy/specimen_list.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/statistics/captures.dart';

class TaxonRegistryViewer extends ConsumerStatefulWidget {
  const TaxonRegistryViewer({
    super.key,
  });

  @override
  TaxonRegistryViewerState createState() => TaxonRegistryViewerState();
}

class TaxonRegistryViewerState extends ConsumerState<TaxonRegistryViewer> {
  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: 'Taxon Registry',
      infoContent: const TaxonRegistryInfoContent(),
      mainAxisAlignment: MainAxisAlignment.start,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              constraints: const BoxConstraints(maxWidth: 460, maxHeight: 250),
              padding: const EdgeInsets.all(8),
              child: const RegistryInfo(),
            ),
            const SizedBox(height: 25),
            Wrap(
              spacing: 8,
              children: [
                SecondaryButton(
                    text: 'Import from file',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TaxonImportForm(),
                        ),
                      );
                    }),
                PrimaryButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const NewTaxon(),
                      ),
                    );
                  },
                  label: 'Add taxon',
                  icon: Icons.add,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TaxonRegistryInfoContent extends StatelessWidget {
  const TaxonRegistryInfoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoContainer(
      content: [
        InfoContent(
          header: 'Overview',
          content: 'This section contains the list of taxa '
              'that are registered in the project.'
              ' You can add new taxa or import taxa from a file.',
        ),
        InfoContent(
          content: 'For file input, input only UTF-8 encoded CSV files.',
        ),
        InfoContent(
          header: 'Term definitions',
          content: 'Registered taxa - The number of taxa that are registered '
              'in the project. '
              '\nRecorded taxa - Information about recorded specimens/captures.'
              ' It will update when you add a new specimen/capture.',
        ),
      ],
    );
  }
}

class RegistryInfo extends ConsumerWidget {
  const RegistryInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(taxonRegistryProvider).when(
          data: (data) {
            return data.isEmpty
                ? const EmptyTaxa()
                : TaxonRegistryLayout(
                    children: [
                      RegisteredTaxa(taxonData: data),
                      const RecordedTaxa(),
                    ],
                  );
          },
          loading: () => const CommonProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        );
  }
}

class EmptyTaxa extends StatelessWidget {
  const EmptyTaxa({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No taxon found.\n'
        'Add/import taxa to start recording captures.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}

class RegisteredTaxa extends StatelessWidget {
  const RegisteredTaxa({
    super.key,
    required this.taxonData,
  });

  final List<TaxonomyData> taxonData;

  @override
  Widget build(BuildContext context) {
    return TaxonDataContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TaxonStatText(
            text: 'Registered',
          ),
          FittedBox(
              fit: BoxFit.fill,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${taxonData.length}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    TextSpan(
                      text: ' species\n',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: '${_countFamily(taxonData)}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    TextSpan(
                      text: ' families',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              )),
          taxonData.isEmpty
              ? const SizedBox.shrink()
              : TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TaxonRegistryPage(),
                      ),
                    );
                  },
                  child: const Text('View all'),
                )
        ],
      ),
    );
  }

  int _countFamily(List<TaxonomyData> data) {
    return data.fold(<String, int>{}, (Map<String, int> map, e) {
      if (e.taxonFamily != null) {
        map[e.taxonFamily!] = (map[e.taxonFamily!] ?? 0) + 1;
      }
      return map;
    }).length;
  }
}

class RecordedTaxa extends ConsumerWidget {
  const RecordedTaxa({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(specimenEntryProvider).when(
          data: (data) => RecordedTaxaView(data: data),
          loading: () => const CommonProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        );
  }
}

class RecordedTaxaView extends ConsumerWidget {
  const RecordedTaxaView({
    super.key,
    required this.data,
  });

  final List<SpecimenData> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TaxonDataContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TaxonStatText(
            text: 'Recorded',
          ),
          data.isEmpty
              ? Text(
                  'No record found',
                  style: Theme.of(context).textTheme.labelLarge,
                )
              : const FittedBox(
                  fit: BoxFit.fill,
                  child: RecordedCounts(),
                ),
          data.isEmpty
              ? const SizedBox.shrink()
              : TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SpecimenListPage(),
                      ),
                    );
                  },
                  child: const Text('View all'),
                )
        ],
      ),
    );
  }
}

class RecordedCounts extends ConsumerWidget {
  const RecordedCounts({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: RichText(
                  text: TextSpan(
                children: [
                  TextSpan(
                    text: '${snapshot.data!.specimenCount}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextSpan(
                    text: ' specimens\n',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextSpan(
                    text: '${snapshot.data!.speciesCount.length}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextSpan(
                    text: ' species\n',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextSpan(
                    text: '${snapshot.data!.familyCount.length}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextSpan(
                    text: ' families',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              )),
            );
          } else {
            return const CommonProgressIndicator();
          }
        },
        future: _getStats(ref));
  }

  Future<CaptureRecordStats> _getStats(WidgetRef ref) async {
    CaptureRecordStats stats = CaptureRecordStats.empty();
    await stats.count(ref);
    return stats;
  }
}

class CountText extends StatelessWidget {
  const CountText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}

class TaxonDataContainer extends StatelessWidget {
  const TaxonDataContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 220,
          width: 200,
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).dividerColor.withAlpha(50),
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          child: child,
        ));
  }
}

class TaxonStatText extends StatelessWidget {
  const TaxonStatText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
