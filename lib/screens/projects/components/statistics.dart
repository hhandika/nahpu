import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:nahpu/screens/projects/dashboard.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/statistics/captures.dart';
import 'package:nahpu/services/statistics/common.dart';
import 'package:nahpu/services/taxonomy_services.dart';
import 'package:nahpu/services/types/statistics.dart';
import 'package:nahpu/services/utility_services.dart';

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
          isFamily: _selectedGraph == GraphType.familyCount,
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

class StatisticFullScreen extends StatefulWidget {
  const StatisticFullScreen({
    super.key,
    required this.startingGraph,
  });
  final GraphType startingGraph;
  @override
  State<StatisticFullScreen> createState() => _StatisticFullScreenState();
}

class _StatisticFullScreenState extends State<StatisticFullScreen> {
  GraphType? _graphType;
  final bool _isMaxCount = true;
  final bool _isLarge = true;

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
                Expanded(
                  child: CountBarChart(
                    isFamily: getGraphType() == GraphType.familyCount,
                    maxCount: _isMaxCount,
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
    required this.isFamily,
    required this.maxCount,
  });

  final bool isFamily;
  final bool maxCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int screenSize = MediaQuery.of(context).size.width.toInt();
            Map<String, int> data = _getCountData(snapshot.data!);
            int dataCount = _getLength(screenSize, data.length);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                data.isEmpty
                    ? Text(
                        'No data to display',
                        style: Theme.of(context).textTheme.labelLarge,
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 42, left: 16, right: 16),
                          child: BarChartViewer(
                            title: 'Species Count',
                            data: data,
                            dataPoints: createDataPoints(
                              data,
                              _getLength(
                                screenSize,
                                data.length,
                              ),
                            ),
                          ),
                        ),
                      ),
                maxCount
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

  Future<CaptureRecordStats> _getStats(WidgetRef ref) async {
    CaptureRecordStats stats = CaptureRecordStats.empty();
    await stats.count(ref);
    return stats;
  }

  Map<String, int> _getCountData(CaptureRecordStats data) {
    return isFamily ? data.familyCount : data.speciesCount;
  }
}

class BarChartViewer extends StatelessWidget {
  const BarChartViewer({
    super.key,
    required this.data,
    required this.dataPoints,
    required this.title,
  });

  final Map<String, int> data;
  final List<DataPoint> dataPoints;
  final String title;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barGroups: dataPoints
              .map((e) => BarChartGroupData(x: e.x.toInt(), barRods: [
                    BarChartRodData(
                        toY: e.y,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        width: chartWidth,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                  ]))
              .toList(),
          borderData: FlBorderData(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
                width: 3,
              ),
              left: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
                width: 3,
              ),
            ),
          ),
          gridData: const FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: _getTitleData(),
            ),
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Theme.of(context).colorScheme.secondaryContainer,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                    rod.toY.truncateZero(),
                    TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    children: [
                      TextSpan(
                        text: '\n${data.keys.elementAt(group.x.toInt())}',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]);
              },
            ),
          )),
    );
  }

  SideTitles _getTitleData() {
    return SideTitles(
      showTitles: true,
      interval: 5,
      getTitlesWidget: (value, meta) {
        return Text(
          getTaxonFirstThreeLetters(data.keys.elementAt(value.toInt())),
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }
}

class SpeciesAccCurve extends ConsumerWidget {
  const SpeciesAccCurve({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: LineChartViewer(
        title: 'Species Curve',
        dataPoints: [
          DataPoint(0, 3),
          DataPoint(1, 4),
          DataPoint(2, 5),
          DataPoint(3, 7),
          DataPoint(4, 4),
          DataPoint(5, 5),
        ],
      ),
    );
  }
}

class LineChartViewer extends StatelessWidget {
  const LineChartViewer(
      {super.key, required this.dataPoints, required this.title});

  final List<DataPoint> dataPoints;
  final String title;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots:
                dataPoints.map((e) => FlSpot(e.x, e.y)).toList(growable: true),
            isCurved: true,
            color: Theme.of(context).colorScheme.tertiary,
            barWidth: 2.5,
            isStrokeCapRound: false,
            dotData: const FlDotData(
              show: false,
            ),
            // belowBarData: BarAreaData(
            //   show: true,
            //   color: const Color(0x00aa4cfc),
            // ),
          ),
        ],
        borderData: FlBorderData(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 3,
            ),
            left: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 3,
            ),
          ),
        ),
        gridData: const FlGridData(show: true),
        titlesData: const FlTitlesData(
          show: false,
        ),
      ),
    );
  }
}
