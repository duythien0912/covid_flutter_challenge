import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SummaryChart extends StatefulWidget {
  final String totalCases;
  final String totalDeath;
  final String totalRecovery;

  SummaryChart({
    Key key,
    this.totalCases = '100',
    this.totalDeath = '0',
    this.totalRecovery = '0',
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => SummaryChartState();
}

class SummaryChartState extends State<SummaryChart> {
  int _touchedIndex;
  double _active = 100, _recovered = 0, _lost = 0;

  @override
  Widget build(BuildContext context) {
    if (_lost == 0) initData();
    return _buildChart();
    return AspectRatio(
      aspectRatio: 1.5,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.black.withOpacity(0.2),
        margin: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            const SizedBox(height: 18),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: _buildChart(),
              ),
            ),
            // _buildLegend(),
            const SizedBox(width: 28),
          ],
        ),
      ),
    );
  }

  void initData() async {
    if (widget.totalCases == null ||
        widget.totalDeath == null ||
        widget.totalRecovery == null) return;

    setState(() {
      double total = double.parse(widget.totalCases);
      double lost = double.parse(widget.totalDeath);
      double recovered = double.parse(widget.totalRecovery);

      _active = 100 * ((total - lost - recovered) / total);
      _lost = 100 * (lost / total);
      _recovered = 100 * (recovered / total);

      double sum = _active + _lost + _recovered;
      if (sum < 100) _active = 100 - sum;
    });
  }

  Widget _buildLegend() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirmed',
          style: TextStyle(fontSize: 18, color: Color(0xff676ef6)),
        ),
        Text(
          'Recovered',
          style: TextStyle(fontSize: 18, color: Color(0xff9bde78)),
        ),
        Text(
          'Deaths',
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
        SizedBox(height: 40),
      ],
    );
  }

  Widget _buildChart() {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
          setState(() {
            if (pieTouchResponse.touchInput is FlLongPressEnd ||
                pieTouchResponse.touchInput is FlPanEnd) {
              _touchedIndex = -1;
            } else {
              _touchedIndex = pieTouchResponse.touchedSectionIndex;
            }
          });
        }),
        borderData: FlBorderData(show: false),
        sectionsSpace: 0,
        centerSpaceRadius: 45,
        sections: showingSections(),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    String activeString = _active.toString();
    String recoveredString = _recovered.toString();
    String lostString = _lost.toString();
    if (activeString.length > 4) activeString = activeString.substring(0, 4);
    if (recoveredString.length > 4)
      recoveredString = recoveredString.substring(0, 4);
    if (lostString.length > 4) lostString = lostString.substring(0, 4);

    return List.generate(3, (i) {
      final isTouched = (i == _touchedIndex);
      final double fontSize = isTouched ? 18 : 14;
      final double radius = isTouched ? 60 : 50;

      switch (i) {
        // Active
        case 0:
          return PieChartSectionData(
            color: Color(0xff676ef6),
            value: _active,
            title: '$activeString%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        // Recovered
        case 1:
          return PieChartSectionData(
            color: const Color(0xff9bde78),
            value: _recovered,
            title: '$recoveredString%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        // Lost
        case 2:
          return PieChartSectionData(
            color: Colors.red,
            value: _lost,
            title: '$lostString%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}
