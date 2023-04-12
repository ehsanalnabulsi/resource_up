import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';

class GridViewItemModel {
//  final String? image;
  final PieChart pieChart;
  final PieChart section1;
  
  final Color? color;
  final String? title;
  final String? subtitle;
  final String? route;

  GridViewItemModel(this.pieChart, this.subtitle, this.section1,
      {/* this.image ,*/ this.title, this.route, this.color});
}
