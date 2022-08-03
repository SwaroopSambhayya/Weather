import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartDetails extends StatelessWidget {
  final double textOpacity;
  ChartDetails({Key? key, this.textOpacity = 1}) : super(key: key);
  final List<Color> gradientColors = [
    const Color(0xff77BBF6),
    Colors.white,
    const Color(0xff77BBF6),
  ];
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: textOpacity,
      duration: const Duration(milliseconds: 500),
      child: AspectRatio(
        aspectRatio: 1.7,
        child: LineChart(
          mainData(),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Image.asset(
          'assets/3dIcons/moon/9.png',
          width: 30,
          fit: BoxFit.contain,
        );
        break;
      case 3:
        text = Image.asset(
          'assets/3dIcons/moon/10.png',
          width: 30,
          fit: BoxFit.contain,
        );
        break;
      case 6:
        text = Text(
          DateFormat('EEE dd, MMM').format(
            DateTime.now(),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 12),
        );
        break;
      case 9:
        text = Image.asset(
          'assets/3dIcons/moon/2.1.png',
          width: 30,
          fit: BoxFit.contain,
        );
        break;
      case 11:
        text = Image.asset(
          'assets/3dIcons/moon/10.png',
          width: 30,
          fit: BoxFit.contain,
        );
        break;
      default:
        text = const Text("");
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d), width: 1),
      ),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 7,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.5, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
            FlSpot(12, 3),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 3.5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            checkToShowDot: (spotData, lineBarsData) {
              if (spotData.x == 4.9) return true;
              return false;
            },
            getDotPainter: (spot, percent, barData, index) =>
                FlDotCirclePainter(
                    strokeWidth: 0,
                    radius: 8,
                    color: Colors.white.withOpacity(0.7)),
          ),
        ),
      ],
    );
  }
}
