import 'package:adaptive_components/adaptive_components.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as db;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/configs/colors.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/providers/page_viewer.dart';
import 'package:nahpu/providers/updater.dart';
import 'package:nahpu/screens/shared/photos.dart';
import 'package:nahpu/screens/shared/layout.dart';

class SiteForm extends ConsumerStatefulWidget {
  const SiteForm({Key? key, required this.id, required this.siteFormCtr})
      : super(key: key);

  final int id;
  final SiteFormCtrModel siteFormCtr;

  @override
  SiteFormState createState() => SiteFormState();
}

class SiteFormState extends ConsumerState<SiteForm>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints c) {
        bool useHorizontalLayout = c.maxWidth > 600.0;
        return SingleChildScrollView(
          child: AdaptiveColumn(
            children: [
              AdaptiveContainer(
                columnSpan: 12,
                child: Column(
                  children: [
                    Card(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: AdaptiveLayout(
                        useHorizontalLayout: useHorizontalLayout,
                        children: _buildSiteID(),
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          AdaptiveLayout(
                            useHorizontalLayout: useHorizontalLayout,
                            children: _buildMainSiteLocality(),
                          ),
                          AdaptiveLayout(
                              useHorizontalLayout: useHorizontalLayout,
                              children: [
                                _buildPreciseLocalities(),
                                _buildLocalityNotes()
                              ])
                        ],
                      ),
                    ),
                    AdaptiveLayout(
                      useHorizontalLayout: useHorizontalLayout,
                      children: [
                        _buildCordinateForm(),
                        Card(
                          child: Column(
                            children: [
                              for (var form in _buildHabitatInfo())
                                Container(
                                    padding: const EdgeInsets.all(10),
                                    child: form),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        DefaultTabController(
                          length: 2,
                          child: TabBar(
                            indicatorColor: NahpuColor.tabBarColor(context),
                            controller: _tabController,
                            tabs: [
                              Tab(
                                  icon: Icon(Icons.photo_album_rounded,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary)),
                              Tab(
                                  icon: Icon(Icons.video_library_rounded,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: TabBarView(
                            controller: _tabController,
                            children: const [
                              PhotoViewer(),
                              Text('Videos'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildSiteID() {
    return [
      TextFormField(
        controller: widget.siteFormCtr.siteIDCtr,
        decoration: const InputDecoration(
          labelText: 'Site ID',
          hintText: 'Enter a site',
        ),
        onChanged: (value) {
          updateSite(widget.id, SiteCompanion(siteID: db.Value(value)), ref);
        },
      ),
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Lead staff',
          hintText: 'Enter a name',
        ),
      ),
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Site Type',
          hintText: 'Enter a site type, e.g. "Camp", "City", "etc."',
        ),
      ),
    ];
  }

  List<Widget> _buildMainSiteLocality() {
    return [
      TextFormField(
        controller: widget.siteFormCtr.countryCtr,
        decoration: const InputDecoration(
          labelText: 'Country',
          hintText: 'Enter a country location',
        ),
        onChanged: (value) {
          updateSite(widget.id, SiteCompanion(country: db.Value(value)), ref);
        },
      ),
      TextFormField(
        controller: widget.siteFormCtr.stateProvinceCtr,
        decoration: const InputDecoration(
          labelText: 'State/Province',
          hintText: 'Enter a state/province location',
        ),
        onChanged: (value) {
          updateSite(
              widget.id, SiteCompanion(stateProvince: db.Value(value)), ref);
        },
      ),
      TextFormField(
        controller: widget.siteFormCtr.countyCtr,
        decoration: const InputDecoration(
          labelText: 'County/Parish/District',
          hintText: 'Enter a county name',
        ),
        onChanged: (value) {
          updateSite(widget.id, SiteCompanion(county: db.Value(value)), ref);
        },
      ),
      TextFormField(
        controller: widget.siteFormCtr.municipalityCtr,
        decoration: const InputDecoration(
          labelText: 'Municipality',
          hintText: 'Enter a municipality name',
        ),
        onChanged: (value) {
          updateSite(
              widget.id, SiteCompanion(municipality: db.Value(value)), ref);
        },
      ),
    ];
  }

  Widget _buildPreciseLocalities() {
    return TextFormField(
      controller: widget.siteFormCtr.localityCtr,
      maxLines: 3,
      decoration: const InputDecoration(
        labelText: 'Precise Locality',
        hintText: 'Enter a precise locality lower than municipality',
      ),
      onChanged: (value) {
        updateSite(widget.id, SiteCompanion(locality: db.Value(value)), ref);
      },
    );
  }

  Widget _buildLocalityNotes() {
    return TextFormField(
      controller: widget.siteFormCtr.localityCtr,
      maxLines: 3,
      decoration: const InputDecoration(
        labelText: 'Remark',
        hintText: 'Enter more info about the trapping site',
      ),
      onChanged: (value) {
        updateSite(widget.id, SiteCompanion(locality: db.Value(value)), ref);
      },
    );
  }

  List<Widget> _buildHabitatInfo() {
    return [
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Habitat',
          hintText: 'Enter a habitat type',
        ),
      ),
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Habitat condition',
          hintText:
              'Enter habitat condition, e.g. "Prestine", "Disturbed", "etc."',
        ),
      ),
      TextFormField(
        maxLines: 5,
        decoration: const InputDecoration(
          labelText: 'Site description',
          hintText:
              'Describe the site, e.g. "A camp site in the middle of the forest."',
        ),
      ),
    ];
  }

  Widget _buildCordinateForm() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Coordinates',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 10,
              child: CoordinateList(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                elevation: 0,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const PhotoForm();
                    });
              },
              child: const Text(
                'Add coordinates',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CoordinateList extends ConsumerWidget {
  const CoordinateList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coordinates = ref.watch(coordinateListProvider);
    return coordinates.when(
      data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.person_rounded),
              title: Text(data[index].siteID ?? ''),
              subtitle: Text(data[index].id ?? ''),
              trailing: IconButton(
                icon: const Icon(Icons.delete_rounded),
                onPressed: () {
                  // ref.read(personnelListProvider.notifier).deletePersonnel(
                  //     data[index].id, data[index].name, data[index].email);
                },
              ),
            );
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text(error.toString()),
    );
  }
}
