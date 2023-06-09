
import 'package:flutter/material.dart';

class MyTheme {

  static const Color PRIMARY_COLOR = Colors.blueAccent;

  static const Color TEXT_COLOR = Colors.white;
  static const Color TEXT_COLOR_SEC = Colors.white70;
  static const Color TEXT_COLOR_RED = Colors.red;
  static const Color TEXT_COLOR_DISABLED = Colors.grey;
  static const Color TEXT_COLOR_BUTTON = Colors.black;
  static const Color COLOR_DIALOG_BACKGROUND = Color(0xFF666666);
  static const Color COLOR_BUTTON_BACKGROUND = Colors.white;

  static const Color BACKGROUND_MAIN = Color(0xFF000000);
  static const Color BACKGROUND_SEC = Color(0xFF333333);

  static const double TEXT_SIZE_BODY = 12;
  static const double TEXT_SIZE_TITLE = 24;

  static const TextStyle TEXT_STYLE_TITLE =
  TextStyle(
    fontSize: TEXT_SIZE_TITLE,
    color: TEXT_COLOR,
  );

  static const TextStyle TEXT_STYLE_BODY =
  TextStyle(
    fontSize: TEXT_SIZE_BODY,
    color: TEXT_COLOR,
  );
  static const TextStyle TEXT_STYLE_BODY_SEC =
  TextStyle(
    fontSize: TEXT_SIZE_BODY,
    color: TEXT_COLOR_SEC,
  );

  static const double ICON_SIZE = 24;
  static const double BUTTON_WIDTH = 120;
  static const double BUTTON_HEIGHT = 45;

}
