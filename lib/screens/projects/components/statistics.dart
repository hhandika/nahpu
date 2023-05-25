import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:nahpu/screens/projects/dashboard.dart';
import 'package:nahpu/services/stats/captures.dart';
import 'package:nahpu/services/stats/common.dart';
import 'package:nahpu/services/taxonomy_services.dart';
import 'package:nahpu/services/types/statistics.dart';
import 'package:nahpu/services/types/types.dart';

const double chartWidth = 28;

/// TODO: Clean all the code in this file
class StatisticFullScreen extends StatelessWidget {
  const StatisticFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        leading: IconButton(
          icon: Icon(Icons.adaptive.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Dashboard(),
              ),
            );
          },
        ),
      ),
      body: const SafeArea(
        child: Center(
            child: StatisticViewer(
          maxCount: true,
        )),
      ),
    );
  }
}

class StatisticViewer extends ConsumerStatefulWidget {
  const StatisticViewer({
    super.key,
    this.maxCount = false,
  });

  final bool maxCount;

  @override
  StatisticViewerState createState() => StatisticViewerState();
}

class StatisticViewerState extends ConsumerState<StatisticViewer> {
  GraphType selectedGraph = GraphType.speciesCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton<GraphType>(
                value: selectedGraph,
                underline: const SizedBox.shrink(),
                items: graphOptions
                    .map((String value) => DropdownMenuItem<GraphType>(
                          value: GraphType.values[graphOptions.indexOf(value)],
                          child: Text(
                            value,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedGraph = value;
                    });
                  }
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.fullscreen_outlined,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StatisticFullScreen(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        Expanded(
            child: CountBarChart(
          isFamily: selectedGraph == GraphType.familyCount,
          maxCount: widget.maxCount,
        )),
      ],
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
            return Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: BarChartViewer(
                title: 'Species Count',
                data: data,
                dataPoints: createDataPoints(
                    data,
                    _getLength(
                      screenSize,
                      data.length,
                    )),
              ),
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
    int fit = screenSize ~/ (chartWidth + 25);
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
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
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
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: _getTitleData(),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
            dotData: FlDotData(
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
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          show: false,
        ),
      ),
    );
  }
}
