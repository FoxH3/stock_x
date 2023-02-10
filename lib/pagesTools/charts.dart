// ignore_for_file: depend_on_referenced_packages
import 'package:stock_x/models/metall_history_datamodel.dart';
import 'package:stock_x/models/stock_history_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

/*
Die Datei beinhaltet mehere Widgets die für das
bilden die Charts verwendet wird.
*/

//diese bildet die Gold Charts
Widget goldChart(List<GoldHisInfo> liste) {
  return SizedBox(
      width: 360,
      child: Center(
          child: SfCartesianChart(
              primaryYAxis: NumericAxis(
                  numberFormat:
                      NumberFormat.simpleCurrency(decimalDigits: 0, name: "€"),
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  title: AxisTitle(text: "Preise in Euro")),
              primaryXAxis:
                  NumericAxis(title: AxisTitle(text: "Enwicklung in jahren")),
              series: <ChartSeries>[
            FastLineSeries<GoldHisInfo, int>(
                color: const Color.fromARGB(255, 255, 200, 0),
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                markerSettings: const MarkerSettings(isVisible: true),
                dataSource: liste,
                xValueMapper: (GoldHisInfo data, _) => data.year,
                yValueMapper: (GoldHisInfo data, _) => data.price)
          ])));
}

//diese bildet die Silber Charts
Widget silberChart(List<SilverHisInfo> liste) {
  return SizedBox(
      width: 360,
      child: Center(
          child: SfCartesianChart(
              primaryYAxis: NumericAxis(
                  numberFormat:
                      NumberFormat.simpleCurrency(decimalDigits: 0, name: "€"),
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  title: AxisTitle(text: "Preise in Euro")),
              primaryXAxis:
                  NumericAxis(title: AxisTitle(text: "Enwicklung in jahren")),
              series: <ChartSeries>[
            FastLineSeries<SilverHisInfo, int>(
                color: const Color.fromARGB(255, 158, 158, 158),
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                markerSettings: const MarkerSettings(isVisible: true),
                dataSource: liste,
                xValueMapper: (SilverHisInfo data, _) => data.year,
                yValueMapper: (SilverHisInfo data, _) => data.price)
          ])));
}
