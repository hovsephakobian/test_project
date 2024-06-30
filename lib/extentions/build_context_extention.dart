import 'package:flutter/material.dart';


///Extension for [BuildContext] to easy get data from context
extension BuildContextExtension on BuildContext{
  ThemeData get _theme => Theme.of(this);
  TextTheme get textTheme => _theme.textTheme;
  Size get deviceSize => MediaQuery.sizeOf(this);
}