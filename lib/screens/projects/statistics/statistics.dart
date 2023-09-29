import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/screens/projects/dashboard.dart';
import 'package:nahpu/screens/projects/statistics/charts.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/statistics/captures.dart';
import 'package:nahpu/services/statistics/common.dart';
import 'package:nahpu/services/types/statistics.dart';

const double chartWidth = 32;
const int maxCount = 5;

class StatisticViewer extends ConsumerStatefulWidget {
  const StatisticViewer({
    super.key,
  });

  @override
  StatisticViewerState createState() => StatisticViewerState();
}

class StatisticViewerState extends ConsumerState<StatisticViewer> {
  GraphType _selectedGraph = GraphType.speciesCount;
  final bool _isLarge = false;

  @override
  Widget build(BuildContext context) {
    return CommonPadding(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StatisticDropdown(
                selectedGraph: _selectedGraph,
                isLarge: _isLarge,
                onChanged: (GraphType? newValue) {
                  setState(() {
                    _selectedGraph = newValue!;
                  });
                },
                graphOptions: dashboardGraphOptions,
              ),
              Tooltip(
                message: 'Open fullscreen',
                child: IconButton(
                  icon: const Icon(
                    Icons.fullscreen,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      _openFullscreen(),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        Expanded(
            child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CountBarChart(
                graphType: _selectedGraph,
                dataPoints: snapshot.data!,
                isFullScreen: false,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          future: _getData(ref),
        )),
      ],
    ));
  }

  Future<DataPoints> _getData(WidgetRef ref) async {
    CaptureRecordStats data = CaptureRecordStats(ref: ref);
    GraphType graph = _selectedGraph;
    switch (graph) {
      case GraphType.speciesCount:
        return data.getSpeciesDataPoint();
      case GraphType.familyCount:
        return data.getFamilyDataPoint();
      default:
        return data.getSpeciesDataPoint();
    }
  }

  /// We use custom transitions to make the fullscreen graph slide up from the
  /// bottom of the screen.
  Route _openFullscreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          StatisticFullScreen(
        startingGraph: _selectedGraph,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}

class StatisticFullScreen extends ConsumerStatefulWidget {
  const StatisticFullScreen({
    super.key,
    required this.startingGraph,
  });
  final GraphType startingGraph;
  @override
  StatisticFullScreenState createState() => StatisticFullScreenState();
}

class StatisticFullScreenState extends ConsumerState<StatisticFullScreen> {
  final TextEditingController _controller = TextEditingController();
  GraphType? _graphType;
  final bool _isisFullScreen = true;
  final bool _isLarge = true;
  int? _selectedID;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Statistics'),
        leading: IconButton(
          tooltip: 'Close',
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              _closeFullscreen(),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 8, 18, 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: StatisticDropdown(
                    selectedGraph: _getGraphType,
                    graphOptions: fullScreenGraphOptions,
                    isLarge: _isLarge,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _graphType = value;
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 0, 0),
                  child: Visibility(
                    visible: _graphType == GraphType.speciesPerSiteCount,
                    child: FutureBuilder(
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            bool enabledFeature =
                                snapshot.data!.length > 5 ? true : false;
                            return DropdownMenu(
                              initialSelection: _selectedID,
                              controller: _controller,
                              enableSearch: enabledFeature,
                              enabled: snapshot.data!.entries.isNotEmpty,
                              hintText: 'Select site',
                              textStyle:
                                  Theme.of(context).textTheme.titleMedium,
                              inputDecorationTheme: const InputDecorationTheme(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              trailingIcon:
                                  _controller.text.isEmpty || !enabledFeature
                                      ? null
                                      : IconButton(
                                          icon: const Icon(Icons.clear_rounded),
                                          onPressed: () {
                                            setState(() {
                                              _selectedID = null;
                                              _controller.clear();
                                            });
                                          }),
                              leadingIcon:
                                  const Icon(Icons.location_on_outlined),
                              dropdownMenuEntries: snapshot.data!.entries
                                  .map((e) => DropdownMenuEntry(
                                        value: e.key,
                                        label: e.value,
                                      ))
                                  .toList(),
                              onSelected: (value) {
                                setState(() {
                                  _selectedID = value;
                                });
                              },
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                        future: _getSiteForFromAllEvents()),
                  ),
                ),
                Expanded(
                    child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CountBarChart(
                        graphType: _getGraphType,
                        dataPoints: snapshot.data!,
                        isFullScreen: _isisFullScreen,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                  future: _getData(ref),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  GraphType get _getGraphType {
    if (_graphType == null) {
      return widget.startingGraph;
    } else {
      return _graphType!;
    }
  }

  Future<DataPoints> _getData(WidgetRef ref) async {
    CaptureRecordStats data = CaptureRecordStats(ref: ref);
    GraphType graph = _getGraphType;
    switch (graph) {
      case GraphType.speciesCount:
        return data.getSpeciesDataPoint();
      case GraphType.familyCount:
        return data.getFamilyDataPoint();
      case GraphType.speciesPerSiteCount:
        return data.getSpeciesPerSiteDataPoint(_selectedID);
      case GraphType.specimenPartCount:
        return data.getSpecimenPartDataPoint();
    }
  }

  Future<Map<int, String>> _getSiteForFromAllEvents() async {
    return await CollEventServices(ref: ref).getSitesForAllEvents();
  }

  Route _closeFullscreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const Dashboard(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}

class StatisticDropdown extends StatelessWidget {
  const StatisticDropdown({
    super.key,
    required this.selectedGraph,
    required this.onChanged,
    required this.graphOptions,
    required this.isLarge,
  });

  final GraphType selectedGraph;
  final void Function(GraphType?) onChanged;
  final List<String> graphOptions;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<GraphType>(
      value: selectedGraph,
      underline: const SizedBox.shrink(),
      items: graphOptions
          .map((String value) => DropdownMenuItem<GraphType>(
                value: GraphType.values[graphOptions.indexOf(value)],
                child: Text(
                  value,
                  style: isLarge
                      ? Theme.of(context).textTheme.titleLarge
                      : Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.fade,
                ),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}

class CountBarChart extends ConsumerWidget {
  const CountBarChart({
    super.key,
    required this.graphType,
    required this.dataPoints,
    required this.isFullScreen,
  });

  final GraphType graphType;
  final DataPoints dataPoints;
  final bool isFullScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        dataPoints.data.isEmpty
            ? Text(
                _emptyText,
                style: Theme.of(context).textTheme.labelLarge,
              )
            : Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 42, left: 16, right: 16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: getChartWidth(dataPoints.data.length),
                      child: BarChartViewer(
                        labels: dataPoints.labels,
                        data: isFullScreen
                            ? dataPoints.data
                            : DataPoints(
                                    data: dataPoints.data,
                                    labels: dataPoints.labels)
                                .getMaxCount(maxCount),
                      ),
                    ),
                  ),
                ),
              ),
        !isFullScreen || dataPoints.data.isEmpty
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 4),
                child: Text('Taxon counts: ${dataPoints.data.length}',
                    style: Theme.of(context).textTheme.labelMedium),
              ),
      ],
    );
  }

  double getChartWidth(int dataLength) {
    if (isFullScreen) {
      return dataLength * (chartWidth + 24);
    } else {
      return maxCount * (chartWidth + 28);
    }
  }

  String get _emptyText {
    return 'No data to display';
  }
}
