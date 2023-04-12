import 'package:flutter/animation.dart';
class BarChartModel {
  final int id;
  final String name;
  final double value;
  final Color color;

  const BarChartModel(
    this.id,
    this.name,
    this.value,
    this.color,
  );
}

// class BarTitles {
//   static SideTitles getTopBottomTitles() => SideTitles(
//         showTitles: true,
//         getTitlesW: ((value, meta) =>
//             barData.firstWhere((element) => element.id == id.toInt).name),
//       );
// }
