import 'package:adaptive_components/adaptive_components.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as db;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/providers/project.dart';

enum MenuSelection { newSite, pdfExport, deleteRecords, deleteAllRecords }

class SiteForm extends ConsumerStatefulWidget {
  const SiteForm({
    Key? key,
    required this.id,
    required this.siteIDController,
    required this.siteTypeController,
    required this.countryController,
    required this.stateProvinceController,
    required this.countyController,
    required this.municipalityController,
    required this.localityController,
  }) : super(key: key);

  final int id;
  final TextEditingController siteIDController;
  final TextEditingController siteTypeController;
  final TextEditingController countryController;
  final TextEditingController stateProvinceController;
  final TextEditingController countyController;
  final TextEditingController municipalityController;
  final TextEditingController localityController;

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
    return SingleChildScrollView(
        child: AdaptiveColumn(
      children: [
        AdaptiveContainer(
          columnSpan: 12,
          child: Column(children: [
            TextFormField(
              controller: widget.siteIDController,
              decoration: const InputDecoration(
                labelText: 'Site ID',
                hintText: 'Enter a site',
              ),
              onChanged: (value) {
                _updateSite(widget.id, SiteCompanion(siteID: db.Value(value)));
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
            TextFormField(
              controller: widget.countryController,
              decoration: const InputDecoration(
                labelText: 'Country',
                hintText: 'Enter a country location',
              ),
              onChanged: (value) {
                _updateSite(widget.id, SiteCompanion(country: db.Value(value)));
              },
            ),
            TextFormField(
              controller: widget.stateProvinceController,
              decoration: const InputDecoration(
                labelText: 'State/Province',
                hintText: 'Enter a state/province location',
              ),
              onChanged: (value) {
                _updateSite(
                    widget.id, SiteCompanion(stateProvince: db.Value(value)));
              },
            ),
            TextFormField(
              controller: widget.countyController,
              decoration: const InputDecoration(
                labelText: 'County',
                hintText: 'Enter a county name',
              ),
              onChanged: (value) {
                _updateSite(widget.id, SiteCompanion(county: db.Value(value)));
              },
            ),
            TextFormField(
              controller: widget.municipalityController,
              decoration: const InputDecoration(
                labelText: 'Municipality',
                hintText: 'Enter a municipality name',
              ),
              onChanged: (value) {
                _updateSite(
                    widget.id, SiteCompanion(municipality: db.Value(value)));
              },
            ),
            TextFormField(
              controller: widget.localityController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Locality',
                hintText:
                    'Enter a complete locality, excluding country and state/province',
              ),
              onChanged: (value) {
                _updateSite(
                    widget.id, SiteCompanion(locality: db.Value(value)));
              },
            ),
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
            Column(
              children: [
                DefaultTabController(
                  length: 2,
                  child: TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(
                          icon: Icon(Icons.photo_album_rounded,
                              color: Theme.of(context).colorScheme.tertiary)),
                      Tab(
                          icon: Icon(Icons.video_library_rounded,
                              color: Theme.of(context).colorScheme.tertiary)),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      Text('Photos'),
                      Text('Videos'),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        )
      ],
    ));
  }

  void _updateSite(int id, SiteCompanion site) {
    ref.read(databaseProvider).updateSiteEntry(id, site);
  }
}
