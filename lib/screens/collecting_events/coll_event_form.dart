import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:intl/intl.dart';
import 'package:nahpu/providers/page_viewer.dart';
import 'package:nahpu/screens/collecting_events/components/environment_data.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/screens/shared/photos.dart';

class CollEventForm extends ConsumerStatefulWidget {
  const CollEventForm({Key? key, required this.id, required this.collEventCtr})
      : super(key: key);

  final int id;
  final CollEventFormCtrModel collEventCtr;

  @override
  CollEventFormState createState() => CollEventFormState();
}

class CollEventFormState extends ConsumerState<CollEventForm>
    with TickerProviderStateMixin {
  final DateTime _initialStartDate =
      DateTime.now().subtract(const Duration(days: 1));
  final DateTime _initialEndDate = DateTime.now();
  final TimeOfDay _initialStartTime = const TimeOfDay(hour: 8, minute: 0);

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
        bool useHorizontalLayout = c.maxWidth > 600;
        return SingleChildScrollView(
          child: Column(
            children: [
              AdaptiveLayout(
                useHorizontalLayout: useHorizontalLayout,
                children: [
                  FormCard(
                    title: 'Collecting Info',
                    isPrimary: true,
                    child: _buildCollectingFields(useHorizontalLayout),
                  ),
                  FormCard(
                    title: 'Collecting Activity',
                    child: Column(
                      children: [
                        _buildActivityFields(),
                        _buildCollectionNotes(),
                      ],
                    ),
                  ),
                ],
              ),
              AdaptiveLayout(
                useHorizontalLayout: useHorizontalLayout,
                children: [
                  FormCard(
                    title: 'Collecting Effort',
                    child: _buildTrappingFields(),
                  ),
                  FormCard(
                    title: 'Trapping Personnel',
                    child: _buildTrappingPersonnelFields(),
                  ),
                ],
              ),
              _buildMediaFields(useHorizontalLayout),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCollectingFields(bool useHorizontalLayout) {
    return Column(
      children: [
        Padding(
          // Match adaptive layout padding
          padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Site ID',
              hintText: 'Enter a new event',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Collecting Event ID',
              hintText: 'Autofill',
            ),
          ),
        ),
        AdaptiveLayout(
          useHorizontalLayout: useHorizontalLayout,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Start Date',
                hintText: 'Enter date',
              ),
              controller: widget.collEventCtr.startDateCtr,
              onTap: () async {
                showDatePicker(
                        context: context,
                        initialDate: _initialStartDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now())
                    .then((date) {
                  if (date != null) {
                    widget.collEventCtr.startDateCtr.text =
                        DateFormat.yMMMd().format(date);
                  }
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Start time',
                hintText: 'Enter date',
              ),
              controller: widget.collEventCtr.startTimeCtr,
              onTap: () async {
                showTimePicker(context: context, initialTime: _initialStartTime)
                    .then((time) {
                  if (time != null) {
                    widget.collEventCtr.startTimeCtr.text =
                        time.format(context);
                  }
                });
              },
            ),
          ],
        ),
        AdaptiveLayout(
          useHorizontalLayout: useHorizontalLayout,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'End Date',
                hintText: 'Enter date',
              ),
              controller: widget.collEventCtr.endDateCtr,
              onTap: () async {
                showDatePicker(
                        context: context,
                        initialDate: _initialEndDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now())
                    .then((date) {
                  if (date != null) {
                    widget.collEventCtr.endDateCtr.text =
                        DateFormat.yMMMd().format(date);
                  }
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'End time',
                hintText: 'Enter date',
              ),
              controller: widget.collEventCtr.endTimeCtr,
              onTap: () async {
                showTimePicker(context: context, initialTime: _initialStartTime)
                    .then((time) {
                  if (time != null) {
                    widget.collEventCtr.endTimeCtr.text = time.format(context);
                  }
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActivityFields() {
    return Column(
      children: [
        DropdownButtonFormField(
          decoration: const InputDecoration(
            labelText: 'Primary collection method',
            hintText: 'Choose a method',
          ),
          items: const [
            DropdownMenuItem(
              value: 'Trapping',
              child: Text('Trapping'),
            ),
            DropdownMenuItem(
              value: 'Song meter',
              child: Text('Song meter'),
            ),
          ],
          onChanged: (String? newValue) {
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildTrappingFields() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
          child: TrapList(),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
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
            'Add equipments',
          ),
        ),
      ],
    );
  }

  Widget _buildCollectionNotes() {
    return TextFormField(
      maxLines: 5,
      decoration: const InputDecoration(
        labelText: 'Collecting method notes',
        hintText: 'Enter notes',
      ),
    );
  }

  Widget _buildTrappingPersonnelFields() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
          child: TrapList(),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
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
            'Add personnels',
          ),
        ),
      ],
    );
  }

  Widget _buildMediaFields(bool useHorizontalLayout) {
    return Column(
      // Media inputs
      children: [
        DefaultTabController(
          length: 2,
          child: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                  icon: Icon(Icons.wb_sunny_rounded,
                      color: Theme.of(context).colorScheme.tertiary)),
              Tab(
                  icon: Icon(Icons.camera_alt_rounded,
                      color: Theme.of(context).colorScheme.tertiary)),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: TabBarView(
            controller: _tabController,
            children: [
              EnvironmentDataForm(
                useHorizontalLayout: useHorizontalLayout,
              ),
              const Text('Camera'),
            ],
          ),
        ),
      ],
    );
  }
}

class TrapList extends ConsumerWidget {
  const TrapList({
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

class TrappingPersonnelList extends ConsumerWidget {
  const TrappingPersonnelList({
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
