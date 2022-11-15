// ignore_for_file: depend_on_referenced_packages
import 'package:stock_x/models/metall_history_datamodel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

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
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                markerSettings: const MarkerSettings(isVisible: true),
                color: const Color.fromARGB(255, 255, 200, 0),
                dataSource: liste,
                xValueMapper: (GoldHisInfo data, _) => data.year,
                yValueMapper: (GoldHisInfo data, _) => data.price)
          ])));
}

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

//  Future<List<GoldHisInfo>> loadChartData()async{
//   List<int> years = [];
//   years = await getYears("jahren für die App", jahren);
//   List<GoldHisInfo> liste = [];
//      var docSnapshot2 = await FirebaseFirestore.instance
//       .collection('stockData')
//       .doc("Gold History")
//       .get();
//   if (docSnapshot2.exists) {
//     Map<String, dynamic>? data = docSnapshot2.data();
//     liste.add(GoldHisInfo(price: data?["1.preis"], year: years[0]));
//     liste.add(GoldHisInfo(price: data?["2.preis"], year: years[1]));
//     liste.add(GoldHisInfo(price: data?["3.preis"], year: years[2]));
//     liste.add(GoldHisInfo(price: data?["4.preis"], year: years[3]));
//   }
//   return liste;
// }