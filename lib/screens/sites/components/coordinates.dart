import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/services/coordinate_queries.dart';
import 'package:nahpu/services/database.dart';
import 'package:drift/drift.dart' as db;

class CoordinateFields extends StatelessWidget {
  const CoordinateFields({super.key, required this.siteId});

  final int siteId;

  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: 'Coordinates',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: CoordinateList(
              sideId: siteId,
            ),
          ),
          PrimaryButton(
            text: 'Add Coordinate',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewCoordinate(siteId: siteId),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class NewCoordinate extends ConsumerWidget {
  const NewCoordinate({Key? key, required this.siteId}) : super(key: key);

  final int siteId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coordCtr = CoordinateCtrModel.empty();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add coordinates'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: CoordinateForms(
          coordinateId: null,
          siteId: siteId,
          coordCtr: coordCtr,
        ),
      ),
    );
  }
}

class EditCoordinate extends ConsumerWidget {
  const EditCoordinate({
    super.key,
    required this.coordinateId,
    required this.siteId,
    required this.coordCtr,
  });

  final int coordinateId;
  final int siteId;
  final CoordinateCtrModel coordCtr;
  final bool isEditing = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Coordinates'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: CoordinateForms(
          coordinateId: coordinateId,
          siteId: siteId,
          coordCtr: coordCtr,
          isEditing: isEditing,
        ),
      ),
    );
  }
}

class CoordinateForms extends ConsumerStatefulWidget {
  const CoordinateForms({
    Key? key,
    required this.coordinateId,
    required this.siteId,
    required this.coordCtr,
    this.isEditing = false,
  }) : super(key: key);

  final int? coordinateId;
  final int siteId;
  final CoordinateCtrModel coordCtr;
  final bool isEditing;

  @override
  CoordinateFormsState createState() => CoordinateFormsState();
}

class CoordinateFormsState extends ConsumerState<CoordinateForms> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: widget.coordCtr.nameIdCtr,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Add a name',
                ),
              ),
              TextFormField(
                controller: widget.coordCtr.latitudeCtr,
                decoration: const InputDecoration(
                  labelText: 'Decimal Latitude',
                  hintText: 'Add a latitude',
                ),
              ),
              TextFormField(
                controller: widget.coordCtr.longitudeCtr,
                decoration: const InputDecoration(
                  labelText: 'Decimal Longitude',
                  hintText: 'Add a longitude',
                ),
              ),
              TextFormField(
                controller: widget.coordCtr.elevationCtr,
                decoration: const InputDecoration(
                  labelText: 'Elevation (m)',
                  hintText: 'Add an elevation',
                ),
              ),
              TextFormField(
                controller: widget.coordCtr.datumCtr,
                decoration: const InputDecoration(
                  labelText: 'Datum',
                  hintText: 'Add a datum',
                ),
              ),
              TextFormField(
                controller: widget.coordCtr.uncertaintyCtr,
                decoration: const InputDecoration(
                  labelText: 'Uncertainty (m)',
                  hintText: 'Add an uncertainty',
                ),
              ),
              TextFormField(
                controller: widget.coordCtr.gpsUnitCtr,
                decoration: const InputDecoration(
                  labelText: 'GPS Unit',
                  hintText: 'Specify the GPS unit',
                ),
              ),
              TextFormField(
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  hintText: 'Add notes (optional)',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                children: [
                  SecondaryButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'Cancel',
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  PrimaryButton(
                    onPressed: () {
                      widget.isEditing ? _updateCoordinate() : _getCoordinate();
                      ref.invalidate(coordinateBySiteProvider);
                      Navigator.pop(context);
                    },
                    text: widget.isEditing ? 'Update' : 'Add',
                  ),
                ],
              )
            ],
          )),
    );
  }

  Future<void> _getCoordinate() async {
    CoordinateCompanion form = _getform();

    await CoordinateQuery(ref.read(databaseProvider)).createCoordinate(form);
  }

  Future<void> _updateCoordinate() async {
    CoordinateCompanion form = _getform();

    try {
      await CoordinateQuery(ref.read(databaseProvider))
          .updateCoordinate(widget.coordinateId!, form);
    } catch (e) {
      // Errror dialog box
      AlertDialog alert = AlertDialog(
        title: const Text('Error'),
        content: const Text('There was an error updating the coordinate'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  CoordinateCompanion _getform() {
    return CoordinateCompanion(
      nameId: db.Value(widget.coordCtr.nameIdCtr.text),
      decimalLatitude:
          db.Value(double.tryParse(widget.coordCtr.latitudeCtr.text) ?? 0.0),
      decimalLongitude:
          db.Value(double.tryParse(widget.coordCtr.longitudeCtr.text) ?? 0.0),
      elevationInMeter:
          db.Value(int.tryParse(widget.coordCtr.elevationCtr.text) ?? 0),
      datum: db.Value(widget.coordCtr.datumCtr.text),
      uncertaintyInMeters:
          db.Value(int.tryParse(widget.coordCtr.uncertaintyCtr.text) ?? 0),
      gpsUnit: db.Value(widget.coordCtr.gpsUnitCtr.text),
      siteID: db.Value(widget.siteId),
      notes: db.Value(widget.coordCtr.noteCtr.text),
    );
  }
}

class CoordinateList extends ConsumerWidget {
  const CoordinateList({
    super.key,
    required this.sideId,
  });

  final int sideId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coordinates = ref.watch(coordinateBySiteProvider(sideId));
    return coordinates.when(
      data: (data) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${data[index].nameId}'),
              subtitle: CoordinateSubtitle(coordinate: data[index]),
              trailing: CoordinateMenu(
                coordinateId: data[index].id!,
                siteId: data[index].siteID!,
                coordCtr: CoordinateCtrModel.fromData(data[index]),
              ),
            );
          },
        );
      },
      loading: () => const CommonProgressIndicator(),
      error: (error, stack) => Text(error.toString()),
    );
  }
}

class CoordinateSubtitle extends StatelessWidget {
  const CoordinateSubtitle({
    super.key,
    required this.coordinate,
  });

  final CoordinateData coordinate;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const WidgetSpan(child: Icon(Icons.pin_drop_outlined, size: 14)),
          TextSpan(
              style: Theme.of(context).textTheme.labelLarge,
              text:
                  '${coordinate.decimalLatitude}, ${coordinate.decimalLongitude}'),
          const TextSpan(text: '  '),
          const WidgetSpan(child: Icon(Icons.landscape_outlined, size: 14)),
          TextSpan(
            style: Theme.of(context).textTheme.labelLarge,
            text: '${coordinate.elevationInMeter} m',
          ),
          const TextSpan(text: '  '),
          const WidgetSpan(child: Icon(Icons.circle_outlined, size: 14)),
          TextSpan(
            style: Theme.of(context).textTheme.labelLarge,
            text: '±${coordinate.uncertaintyInMeters} m',
          ),
          const TextSpan(text: '  '),
          const WidgetSpan(child: Icon(Icons.map_outlined, size: 14)),
          TextSpan(
            style: Theme.of(context).textTheme.labelLarge,
            text: '${coordinate.datum}',
          ),
        ],
      ),
    );
  }
}

class CoordinateMenu extends ConsumerStatefulWidget {
  const CoordinateMenu({
    super.key,
    required this.coordinateId,
    required this.siteId,
    required this.coordCtr,
  });

  final int coordinateId;
  final int siteId;
  final CoordinateCtrModel coordCtr;

  @override
  CoordinateMenuState createState() => CoordinateMenuState();
}

class CoordinateMenuState extends ConsumerState<CoordinateMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      onSelected: _onSelected,
      itemBuilder: (context) => [
        const PopupMenuItem<CommonPopUpMenuItems>(
          value: CommonPopUpMenuItems.edit,
          child: Text('Edit'),
        ),
        const PopupMenuItem(
          value: CommonPopUpMenuItems.delete,
          child: Text('Delete'),
        ),
      ],
    );
  }

  void _onSelected(CommonPopUpMenuItems item) {
    switch (item) {
      case CommonPopUpMenuItems.edit:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditCoordinate(
              coordinateId: widget.coordinateId,
              siteId: widget.siteId,
              coordCtr: widget.coordCtr,
            ),
          ),
        );
        break;
      case CommonPopUpMenuItems.delete:
        CoordinateQuery(ref.read(databaseProvider))
            .deleteCoordinate(widget.coordinateId);
        ref.invalidate(coordinateBySiteProvider);
        break;
    }
  }
}
