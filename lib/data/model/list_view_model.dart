// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ListViewModel {
  String title;
  String subtitle;
  String route;
  Icon leading;
  // Icon trailing;
  void Function()? onTap;
  Color color;
  ListViewModel({
    required this.title,
    required this.subtitle,
    required this.route,
    required this.leading,
    // required this.trailing,
    required this.color,
    this.onTap,
  });
}
