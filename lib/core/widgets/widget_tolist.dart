import 'package:flutter/cupertino.dart';

extension WidgetToList on Widget {
  List<Widget> toList(int n) => List.generate(n, (i) => this);
}
