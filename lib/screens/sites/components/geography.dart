import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as db;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/controller/updaters.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/services/database.dart';

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
            updateSite(id, SiteCompanion(country: db.Value(value)), ref);
          },
        ),
        TextFormField(
          controller: siteFormCtr.stateProvinceCtr,
          decoration: const InputDecoration(
            labelText: 'State/Province',
            hintText: 'Enter a state/province location',
          ),
          onChanged: (value) {
            updateSite(id, SiteCompanion(stateProvince: db.Value(value)), ref);
          },
        ),
        TextFormField(
          controller: siteFormCtr.countyCtr,
          decoration: const InputDecoration(
            labelText: 'County/Parish/District',
            hintText: 'Enter a county name',
          ),
          onChanged: (value) {
            updateSite(id, SiteCompanion(county: db.Value(value)), ref);
          },
        ),
        TextFormField(
          controller: siteFormCtr.municipalityCtr,
          decoration: const InputDecoration(
            labelText: 'Municipality',
            hintText: 'Enter a municipality name',
          ),
          onChanged: (value) {
            updateSite(id, SiteCompanion(municipality: db.Value(value)), ref);
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
        updateSite(id, SiteCompanion(locality: db.Value(value)), ref);
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
      controller: siteFormCtr.localityCtr,
      maxLines: 3,
      decoration: const InputDecoration(
        labelText: 'Remark',
        hintText: 'Enter more info about the trapping site',
      ),
      onChanged: (value) {
        updateSite(id, SiteCompanion(locality: db.Value(value)), ref);
      },
    );
  }
}
