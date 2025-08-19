import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  void popDialog() => Navigator.pop(this);

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  dynamic push(Widget route) async {
    final result = await Navigator.push(
      this,
      CupertinoPageRoute(builder: (context) => route),
    );
    return result;
  }

  // dynamic pushNames(String name) async {
  //   final route = RouteMap.maps[name];
  //   if (route == null) throw Exception('No route find for the given name');
  //   final result = await push(route);
  //   return result;
  // }

  void pop({dynamic result}) {
    Navigator.pop(this, result);
  }

  void popBack() {
    Navigator.pop(this);
  }

  void pushRemoveUntil(Widget route, {dynamic argument}) {
    Navigator.pushAndRemoveUntil(
      this,
      CupertinoPageRoute(builder: (context) => route),
      (Route<dynamic> route) => false,
    );
  }

  void pushReplace(Widget route) {
    Navigator.pushReplacement(
      this,
      CupertinoPageRoute(builder: (context) => route),
    );
  }
}
