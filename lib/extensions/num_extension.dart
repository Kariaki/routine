import 'package:flutter/cupertino.dart';

extension DoubleExtension on double{

  SizedBox get height => SizedBox(height: this);

  SizedBox get width => SizedBox(width: this);

}
extension IntExtension on int{
  SizedBox get height => SizedBox(height: toDouble());

  SizedBox get width => SizedBox(width: toDouble());

}