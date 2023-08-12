import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/screens/projects/statistics/statistics.dart';
import 'package:nahpu/services/statistics/common.dart';
import 'package:nahpu/services/taxonomy_services.dart';
import 'package:nahpu/services/utility_services.dart';

class BarChartViewer extends StatelessWidget {
  const BarChartViewer({
    super.key,
    required this.labels,
    required this.data,
  });

  final List<String> labels;
  final List<({int x, double y})> data;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barGroups: data
              .map((e) => BarChartGroupData(x: e.x, barRods: [
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
              tooltipRoundedRadius: 16,
              direction: TooltipDirection.top,
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              tooltipBgColor: Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withOpacity(0.9),
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                    rod.toY.truncateZero(),
                    TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    children: [
                      TextSpan(
                        text: '\n${labels[group.x.toInt()]}',
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
      getTitlesWidget: (value, meta) {
        return Text(
          getTaxonFirstThreeLetters(labels[value.toInt()]),
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }
}

class LineChartViewer extends StatelessWidget {
  const LineChartViewer(
      {super.key, required this.dataPoints, required this.title});

  final DataPoints dataPoints;
  final String title;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: dataPoints.data
                .map((e) => FlSpot(e.x.toDouble(), e.y))
                .toList(growable: true),
            isCurved: true,
            color: Theme.of(context).colorScheme.tertiary,
            barWidth: 2.5,
            isStrokeCapRound: false,
            dotData: const FlDotData(
              show: false,
            ),
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
