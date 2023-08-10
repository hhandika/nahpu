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
              IconButton(
                icon: const Icon(
                  Icons.fullscreen,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    _openFullscreen(),
                  );
                },
              )
            ],
          ),
        ),
        Expanded(
            child: CountBarChart(
          graphType: _selectedGraph,
          siteID: null,
          maxCount: false,
        )),
      ],
    ));
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
  GraphType? _graphType;
  final bool _isMaxCount = true;
  final bool _isLarge = true;
  int? _siteID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Statistics'),
        leading: IconButton(
          icon: const Icon(Icons.close),
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
                    selectedGraph: getGraphType(),
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
                Visibility(
                  visible: _graphType == GraphType.speciesPerSiteCount,
                  child: FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DropdownButton(
                            value: _siteID,
                            items: snapshot.data!.entries
                                .map((e) => DropdownMenuItem(
                                      value: e.key,
                                      child: Text(
                                        e.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _siteID = value;
                              });
                            },
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                      future: _getSiteForFromAllEvents()),
                ),
                Expanded(
                  child: CountBarChart(
                    graphType: getGraphType(),
                    maxCount: _isMaxCount,
                    siteID: _siteID,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  GraphType getGraphType() {
    if (_graphType == null) {
      return widget.startingGraph;
    } else {
      return _graphType!;
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
    required this.siteID,
    required this.maxCount,
  });

  final GraphType graphType;
  final int? siteID;
  final bool maxCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int screenSize = MediaQuery.of(context).size.width.toInt();
            int dataCount = _getLength(screenSize, snapshot.data!.length);
            List<DataPoint> data = getMaxCount(snapshot.data!, dataCount);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                snapshot.data!.isEmpty
                    ? Text(
                        _emptyText,
                        style: Theme.of(context).textTheme.labelLarge,
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 42, left: 16, right: 16),
                          child: BarChartViewer(
                            dataPoints: data,
                          ),
                        ),
                      ),
                maxCount && data.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Showing top $dataCount of ${data.length} results',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
        future: _getStats(ref));
  }

  int _getLength(int screenSize, int dataLength) {
    if (!maxCount) {
      return 5;
    }
    int fit = screenSize ~/ (chartWidth + 22);
    return dataLength > fit ? fit : dataLength;
  }

  Future<List<DataPoint>> _getStats(WidgetRef ref) async {
    CaptureRecordStats data = CaptureRecordStats(ref: ref);
    switch (graphType) {
      case GraphType.speciesCount:
        return data.getSpeciesDataPoint();
      case GraphType.familyCount:
        return data.getFamilyDataPoint();
      case GraphType.speciesPerSiteCount:
        return data.getSpeciesPerSiteDataPoint(siteID);
    }
  }

  String get _emptyText {
    if (graphType == GraphType.speciesPerSiteCount) {
      return siteID == null
          ? 'Select a site to view data'
          : 'No data to display for this site';
    } else {
      return 'No data to display';
    }
  }
}

// class SpeciesAccumulation extends ConsumerWidget {
//   const SpeciesAccumulation({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
//       child: LineChartViewer(
//         title: 'Species Curve',
//         dataPoints: [
//           DataPoint(0, 3),
//           DataPoint(1, 4),
//           DataPoint(2, 5),
//           DataPoint(3, 7),
//           DataPoint(4, 4),
//           DataPoint(5, 5),
//         ],
//       ),
//     );
//   }
// }
