import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../model/calendar_mode.dart';

class BarChartSample3 extends StatefulWidget {
  final Map<String, int> stat;

  const BarChartSample3({required this.stat, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: _BarChart(stat: widget.stat),
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  final Map<String, int> stat;

  const _BarChart({required this.stat, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData(stat),
        titlesData: titlesData(stat),
        borderData: borderData(stat),
        barGroups: barGroups(stat),
        gridData: FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
      ),
    );
  }

  BarTouchData barTouchData(Map<String, int> stat) => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta, Map<String, int> stat) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = stat.keys.toList()[value.toInt()];

    return Center(child: Text(text, style: style));
  }

  FlTitlesData titlesData(Map<String, int> stat) => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) => getTitles(value, meta, stat),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData borderData(Map<String, int> stat) => FlBorderData(
        show: false,
      );

  final _barsGradient = const LinearGradient(
    colors: [
      Colors.lightBlueAccent,
      Colors.greenAccent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> barGroups(Map<String, int> stats) {
    final stat = stats.entries.toList();
    final list = <BarChartGroupData>[];
    for (int i = 0; i < stat.length; i++) {
      list.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: stat[i].value * 1.0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }
    return list;
  }
}
