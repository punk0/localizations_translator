import 'dart:ui';
import 'package:localizations_translator/custom_classes/button_info.dart';
import 'package:localizations_translator/my_theme.dart';
import 'package:flutter/material.dart';

class DefaultDialog extends StatelessWidget{
  static const double FIELD_SPACING = 12;
  // Default is Colors.black54.
  //barrierColor: MyThemeNew.textColor(context).withOpacity(0.3),
  static const Color BARRIER_COLOR = Colors.transparent;
  static const bool BARRIER_DISMISSIBLE = true;

  final String title;
  final Color? titleColor;
  final bool dismissible;
  final Widget content;
  final bool blurBackground;
  final List<ButtonInfo> actions;
  final bool alwaysPopOnAction;
  final EdgeInsetsGeometry? contentPadding;

  const DefaultDialog({
    this.title = '',
    this.titleColor,
    this.dismissible = true,
    this.content = const SizedBox(),
    this.blurBackground = true,
    this.actions = const [],
    this.alwaysPopOnAction = true,
    this.contentPadding = const EdgeInsets.fromLTRB(25, 25, 25, 0, ),
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> textButtons = [];
    for (ButtonInfo bi in actions)
      textButtons.add(
        /*
        DefaultButton(
          width: 80,
          height: 35,
          buttonInfo: bi,
        ),
      );
*/
          TextButton(
            child: Text(
              bi.text ?? '',
              style: MyTheme.TEXT_STYLE_BODY.copyWith(
                color: bi.enabled
                    ? bi.color ?? MyTheme.TEXT_COLOR
                    : MyTheme.TEXT_COLOR_DISABLED,
              ),
            ),
            onPressed: bi.enabled
                ? () {
              if (alwaysPopOnAction)
                Navigator.of(context).pop();
              if (bi.onTap != null)
                bi.onTap!();
            }
                : null,
          )
      );

    return GestureDetector(
      child: ColoredBox(
        color: Colors.white10,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurBackground ? 5 : 0,
            sigmaY: blurBackground ? 5 : 0,
          ),
          child: GestureDetector(
            onTap: () {} ,
            child: AlertDialog(
              elevation: 0,
              contentPadding: contentPadding,
              title: title.isNotEmpty
                  ? Text(
                title,
                style: MyTheme.TEXT_STYLE_TITLE,
              )
                  : null,
              backgroundColor: MyTheme.COLOR_DIALOG_BACKGROUND,
              content: content,
              actions: textButtons.isNotEmpty
                  ? textButtons
                  : null,
            ),
          ),
        ),
      ),
      onTap: dismissible
          ? () => Navigator.pop(context)
          : null,
    );
  }

}
