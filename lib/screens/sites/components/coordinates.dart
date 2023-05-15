import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/site_services.dart';
import 'package:url_launcher/url_launcher.dart';

class CoordinateFields extends StatelessWidget {
  const CoordinateFields({super.key, required this.siteId});

  final int siteId;

  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: 'Coordinates',
      mainAxisAlignment: MainAxisAlignment.start,
      child: Column(
        children: [
          SizedBox(
            height: 255,
            child: CoordinateList(
              sideId: siteId,
            ),
          ),
          const SizedBox(height: 15),
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
          const WidgetSpan(
              child: TileIcon(icon: Icons.pin_drop_outlined),
              alignment: PlaceholderAlignment.middle),
          TextSpan(
              style: Theme.of(context).textTheme.labelLarge,
              text:
                  '${coordinate.decimalLatitude}, ${coordinate.decimalLongitude}'),
          const TextSpan(text: '  '),
          const WidgetSpan(
              child: TileIcon(icon: Icons.landscape_outlined),
              alignment: PlaceholderAlignment.middle),
          TextSpan(
            style: Theme.of(context).textTheme.labelLarge,
            text: '${coordinate.elevationInMeter} m',
          ),
          const TextSpan(text: '  '),
          const WidgetSpan(
              child: TileIcon(icon: Icons.circle_outlined),
              alignment: PlaceholderAlignment.middle),
          TextSpan(
            style: Theme.of(context).textTheme.labelLarge,
            text: '±${coordinate.uncertaintyInMeters} m',
          ),
          const TextSpan(text: '  '),
          const WidgetSpan(
              child: TileIcon(icon: Icons.map_outlined),
              alignment: PlaceholderAlignment.middle),
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
      itemBuilder: (context) => <PopupMenuEntry<CoordinatePopUpMenuItems>>[
        const PopupMenuItem<CoordinatePopUpMenuItems>(
          value: CoordinatePopUpMenuItems.edit,
          child: ListTile(
            leading: Icon(Icons.edit_outlined),
            title: Text('Edit'),
          ),
        ),
        const PopupMenuItem<CoordinatePopUpMenuItems>(
          value: CoordinatePopUpMenuItems.copy,
          child: ListTile(
            leading: Icon(Icons.copy_outlined),
            title: Text('Copy'),
          ),
        ),
        const PopupMenuItem<CoordinatePopUpMenuItems>(
          value: CoordinatePopUpMenuItems.open,
          child: ListTile(
            leading: Icon(Icons.open_in_browser_outlined),
            title: Text('Open'),
          ),
        ),
        const PopupMenuDivider(height: 10),
        const PopupMenuItem<CoordinatePopUpMenuItems>(
          value: CoordinatePopUpMenuItems.delete,
          child: ListTile(
            leading: Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
            title: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ),
      ],
    );
  }

  Future<void> _onSelected(CoordinatePopUpMenuItems item) async {
    switch (item) {
      case CoordinatePopUpMenuItems.edit:
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
      case CoordinatePopUpMenuItems.copy:
        await Clipboard.setData(ClipboardData(text: _latLong));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Latitude and Longitude copied to clipboard'),
            ),
          );
        }
        break;
      case CoordinatePopUpMenuItems.open:
        await _launchGoogleMap();
        break;
      case CoordinatePopUpMenuItems.delete:
        CoordinateServices(ref).deleteCoordinate(widget.coordinateId);
        ref.invalidate(coordinateBySiteProvider);
        break;
    }
  }

  Future<void> _launchGoogleMap() async {
    const host = 'www.google.com';
    const path = 'maps/search/';
    final queryParameters = {
      'api': '1',
      'query': _latLong,
    };
    Uri url = Uri.https(host, path, queryParameters);
    if (kDebugMode) print(url.toString());
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  String get _latLong {
    return '${widget.coordCtr.latitudeCtr.text},'
        '${widget.coordCtr.longitudeCtr.text}';
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
  final List<String> _datum = ['WGS84', 'NAD83', 'NAD27', 'Other'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
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
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                controller: widget.coordCtr.longitudeCtr,
                decoration: const InputDecoration(
                  labelText: 'Decimal Longitude',
                  hintText: 'Add a longitude',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                controller: widget.coordCtr.elevationCtr,
                decoration: const InputDecoration(
                  labelText: 'Elevation (m)',
                  hintText: 'Add an elevation',
                ),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField(
                value: _getDatum(),
                decoration: const InputDecoration(
                  labelText: 'Datum',
                  hintText: 'Specify the datum',
                ),
                items: _datum
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  widget.coordCtr.datumCtr.text = value.toString();
                },
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
                      widget.isEditing
                          ? _updateCoordinate()
                          : _createCoordinate();
                      ref.invalidate(coordinateBySiteProvider);
                      Navigator.pop(context);
                    },
                    text: widget.isEditing ? 'Update' : 'Add',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String _getDatum() {
    if (widget.coordCtr.datumCtr.text.isEmpty) {
      setState(() {
        widget.coordCtr.datumCtr.text = _datum[0];
      });
      return widget.coordCtr.datumCtr.text;
    } else {
      return widget.coordCtr.datumCtr.text;
    }
  }

  Future<void> _createCoordinate() async {
    CoordinateCompanion form = _getform();

    await CoordinateServices(ref).createCoordinate(form);
  }

  Future<void> _updateCoordinate() async {
    CoordinateCompanion form = _getform();

    try {
      await CoordinateServices(ref)
          .updateCoordinate(widget.coordinateId!, form);
    } catch (e) {
      // Error dialog box
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
