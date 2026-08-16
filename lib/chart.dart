import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  // _MyHomePage({Key? key}) : super(key: key);

const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {

  @override
  Widget build(BuildContext context) {

    late double h = MediaQuery.of(context).size.height;
    late double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: h*0.3,
            width: w*0.4,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 10,
                barTouchData: BarTouchData(enabled: true),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        switch (value.toInt()) {
                          case 0: return const Text('Mn');
                          case 1: return const Text('Te');
                          case 2: return const Text('Wd');
                          case 3: return const Text('Th');
                          case 4: return const Text('Fr');
                          default: return const Text('');
                        }
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 30),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8, color: Colors.blue, width: 16)]),
                  BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 4, color: Colors.blue, width: 16)]),
                  BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 6, color: Colors.blue, width: 16)]),
                  BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 9, color: Colors.blue, width: 16)]),
                  BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 5, color: Colors.blue, width: 16)]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
