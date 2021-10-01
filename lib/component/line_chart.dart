import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PointsLineChart extends StatelessWidget {
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final bool animate;

  PointsLineChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.LineRendererConfig(includePoints: true),
      behaviors: [
        new charts.ChartTitle(
          'Tanggal',
          behaviorPosition: charts.BehaviorPosition.bottom,
          titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
        ),
        new charts.ChartTitle(
          'Nilai',
          behaviorPosition: charts.BehaviorPosition.top,
          titleOutsideJustification: charts.OutsideJustification.startDrawArea,
        ),
      ],
    );
  }
}
