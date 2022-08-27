import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:intl/intl.dart';

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
    return SingleChildScrollView(
      child: Column(
        children: [
          _drawCollectingFields(),
          _drawActivityFields(),
          _drawTrappingFields(),
          _drawMediaFields(),
        ],
      ),
    );
  }

  Widget _drawCollectingFields() {
    return Card(
        child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Text(
                'Collecting Information',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Site ID',
                  hintText: 'Enter a new event',
                ),
              ),
              Row(children: [
                Expanded(
                  child: TextFormField(
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
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Start time',
                      hintText: 'Enter date',
                    ),
                    controller: widget.collEventCtr.startTimeCtr,
                    onTap: () async {
                      showTimePicker(
                              context: context, initialTime: _initialStartTime)
                          .then((time) {
                        if (time != null) {
                          widget.collEventCtr.startTimeCtr.text =
                              time.format(context);
                        }
                      });
                    },
                  ),
                ),
              ]),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
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
                  )),
                  const SizedBox(width: 10),
                  Expanded(
                      child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'End time',
                      hintText: 'Enter date',
                    ),
                    controller: widget.collEventCtr.endTimeCtr,
                    onTap: () async {
                      showTimePicker(
                              context: context, initialTime: _initialStartTime)
                          .then((time) {
                        if (time != null) {
                          widget.collEventCtr.endTimeCtr.text =
                              time.format(context);
                        }
                      });
                    },
                  )),
                ],
              ),
            ])));
  }

  Widget _drawActivityFields() {
    return Card(
        child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Text(
                'Collecting Activities',
                style: Theme.of(context).textTheme.titleLarge,
              ),
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
                  }),
              TextFormField(
                maxLines: 10,
                decoration: const InputDecoration(
                  labelText: 'Collecting method notes',
                  hintText: 'Enter notes',
                ),
              ),
            ])));
  }

  Widget _drawTrappingFields() {
    return Card(
        child: Container(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        Text(
          'Collecting Effort',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Live traps',
            hintText: 'Enter count',
          ),
          keyboardType: TextInputType.number,
        ),
      ]),
    ));
  }

  Widget _drawMediaFields() {
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
            children: const [
              Text('Environment Data'),
              Text('Camera'),
            ],
          ),
        ),
      ],
    );
  }
}
