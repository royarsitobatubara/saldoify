import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Graph extends StatelessWidget {
  final List<Color> listColor;
  final Map<String, double> dataMap;
  final String title;
  const Graph({super.key, required this.listColor, required this.title, required this.dataMap});

  @override
  Widget build(BuildContext context) {
    if(dataMap.isEmpty){
      return PieChart(
        dataMap: {'none': 0},
        colorList: [Colors.grey.shade100],
        chartType: ChartType.ring,
        centerText: title,
        chartRadius: MediaQuery.of(context).size.width / 2.2,
        ringStrokeWidth: 20,
        chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: false,
          showChartValuesInPercentage: false,
          showChartValuesOutside: false,
          decimalPlaces: 1,
        ),
        legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: false,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return PieChart(
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 2.2,
      colorList: listColor,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 20,
      centerText: title,
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: false,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: false,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
    );
  }
}
