import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as db;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/site_services.dart';

class Geography extends StatelessWidget {
  const Geography({
    super.key,
    required this.id,
    required this.useHorizontalLayout,
    required this.siteFormCtr,
  });

  final int id;
  final bool useHorizontalLayout;
  final SiteFormCtrModel siteFormCtr;

  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: 'Geography',
      child: Column(
        children: [
          MainSiteLocality(
            id: id,
            useHorizontalLayout: useHorizontalLayout,
            siteFormCtr: siteFormCtr,
          ),
          AdaptiveLayout(
            useHorizontalLayout: useHorizontalLayout,
            children: [
              PreciseLocality(
                  id: id,
                  useHorizontalLayout: useHorizontalLayout,
                  siteFormCtr: siteFormCtr),
              LocalityNote(
                  id: id,
                  useHorizontalLayout: useHorizontalLayout,
                  siteFormCtr: siteFormCtr)
            ],
          )
        ],
      ),
    );
  }
}

class MainSiteLocality extends ConsumerWidget {
  const MainSiteLocality(
      {super.key,
      required this.id,
      required this.useHorizontalLayout,
      required this.siteFormCtr});

  final int id;
  final bool useHorizontalLayout;
  final SiteFormCtrModel siteFormCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdaptiveLayout(
      useHorizontalLayout: useHorizontalLayout,
      children: [
        TextFormField(
          controller: siteFormCtr.countryCtr,
          decoration: const InputDecoration(
            labelText: 'Country',
            hintText: 'Enter a country location',
          ),
          onChanged: (value) {
            SiteServices(ref).updateSite(
              id,
              SiteCompanion(country: db.Value(value)),
            );
          },
        ),
        TextFormField(
          controller: siteFormCtr.stateProvinceCtr,
          decoration: const InputDecoration(
            labelText: 'State/Province',
            hintText: 'Enter a state/province location',
          ),
          onChanged: (value) {
            SiteServices(ref).updateSite(
              id,
              SiteCompanion(stateProvince: db.Value(value)),
            );
          },
        ),
        TextFormField(
          controller: siteFormCtr.countyCtr,
          decoration: const InputDecoration(
            labelText: 'County/Parish/District',
            hintText: 'Enter a county/parish/district location',
          ),
          onChanged: (value) {
            SiteServices(ref).updateSite(
              id,
              SiteCompanion(county: db.Value(value)),
            );
          },
        ),
        TextFormField(
          controller: siteFormCtr.municipalityCtr,
          decoration: const InputDecoration(
            labelText: 'Municipality/City/Town',
            hintText: 'Enter municipality/city/town name',
          ),
          onChanged: (value) {
            SiteServices(ref).updateSite(
              id,
              SiteCompanion(municipality: db.Value(value)),
            );
          },
        ),
      ],
    );
  }
}

class PreciseLocality extends ConsumerWidget {
  const PreciseLocality(
      {super.key,
      required this.id,
      required this.useHorizontalLayout,
      required this.siteFormCtr});

  final int id;
  final bool useHorizontalLayout;
  final SiteFormCtrModel siteFormCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: siteFormCtr.localityCtr,
      maxLines: 3,
      decoration: const InputDecoration(
        labelText: 'Precise Locality',
        hintText: 'Enter a precise locality lower than municipality',
      ),
      onChanged: (value) {
        SiteServices(ref).updateSite(
          id,
          SiteCompanion(locality: db.Value(value)),
        );
      },
    );
  }
}

class LocalityNote extends ConsumerWidget {
  const LocalityNote(
      {super.key,
      required this.id,
      required this.useHorizontalLayout,
      required this.siteFormCtr});

  final int id;
  final bool useHorizontalLayout;
  final SiteFormCtrModel siteFormCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: siteFormCtr.remarkCtr,
      maxLines: 3,
      decoration: const InputDecoration(
        labelText: 'Remark',
        hintText: 'Enter more info about the site (optional)',
      ),
      onChanged: (value) {
        SiteServices(ref).updateSite(
          id,
          SiteCompanion(remark: db.Value(value)),
        );
      },
    );
  }
}
