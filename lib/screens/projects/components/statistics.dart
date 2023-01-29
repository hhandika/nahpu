import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticViewer extends ConsumerStatefulWidget {
  const StatisticViewer({Key? key}) : super(key: key);

  @override
  StatisticViewerState createState() => StatisticViewerState();
}

class StatisticViewerState extends ConsumerState<StatisticViewer> {
  final List<String> graphOptions = [
    'Species accumulation curve',
    'Collecting success',
  ];

  String? selectedGraph = 'Species accumulation curve';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: DropdownButton<String>(
            value: selectedGraph,
            items: graphOptions
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedGraph = value;
              });
            },
          ),
        ),
        const SizedBox(height: 5),
        Expanded(
            child: Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.fullscreen_outlined),
            ),
            GraphViewer(
              selectedGraph: selectedGraph!,
            ),
          ],
        )),
      ],
    );
  }
}

class GraphViewer extends StatelessWidget {
  const GraphViewer({
    super.key,
    required this.selectedGraph,
  });

  final String selectedGraph;

  @override
  Widget build(BuildContext context) {
    switch (selectedGraph) {
      case 'Species accumulation curve':
        return const SpeciesAccCurve();
      case 'Collecting success':
        return const Text('Collecting success');
      default:
        return const Text('No graph selected');
    }
    ;
  }
}

class SpeciesAccCurve extends ConsumerWidget {
  const SpeciesAccCurve({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: LineChartViewer(
        title: 'Specie Curve',
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

class DataPoint {
  final double x;
  final double y;

  DataPoint(this.x, this.y);
}
