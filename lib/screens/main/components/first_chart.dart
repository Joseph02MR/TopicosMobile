import 'package:ecommerce_int2/screens/main/components/first_series.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class FirstChart extends StatelessWidget {
  final List<FirstSeries> data;
  const FirstChart({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<charts.Series<FirstSeries, String>> series = [
      charts.Series(
          id: "players",
          data: data,
          domainFn: (FirstSeries series, _) => series.year,
          measureFn: (FirstSeries series, _) => series.players,
          colorFn: (FirstSeries series, _) => series.barColor)
    ];
    return Container(
      height: 300,
      padding: const EdgeInsets.all(25),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: [
              Text(
                "Sales Growth",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}