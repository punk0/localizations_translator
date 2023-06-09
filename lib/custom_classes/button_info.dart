import 'package:flutter/material.dart';

class ButtonInfo{
  final IconData? iconData;
  final Widget? icon;
  final String? text;
  final Function? onTap;
  final bool enabled;
  final Color? color;
  final Color? backColor;

  ButtonInfo({this.iconData, this.icon, this.text = '',
    required this.onTap, this.enabled = true,
    this.color,  this.backColor, });
}
