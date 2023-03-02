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

//Folgende klasse bilden die Stock Charts
class StockChart extends StatefulWidget {
  final List<StockHisInfo> liste;
  const StockChart({super.key, required this.liste});

  @override
  State<StockChart> createState() => StockChartState();
}

class StockChartState extends State<StockChart> {
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 330,
        child: Center(
            child: SfCartesianChart(
          trackballBehavior: _trackballBehavior,
          title: ChartTitle(text: "Stock preis Entwicklung"),
          series: <CandleSeries>[
            CandleSeries<StockHisInfo, DateTime>(
                dataSource: widget.liste,
                xValueMapper: (StockHisInfo liste, _) => liste.datetime,
                lowValueMapper: (StockHisInfo liste, _) => liste.low,
                highValueMapper: (StockHisInfo liste, _) => liste.high,
                openValueMapper: (StockHisInfo liste, _) => liste.open,
                closeValueMapper: (StockHisInfo liste, _) => liste.close)
          ],
          primaryXAxis: DateTimeAxis(
              dateFormat: DateFormat.yM(),
              majorGridLines: const MajorGridLines(width: 0)),
          primaryYAxis: NumericAxis(
              numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
        )));
  }
}
