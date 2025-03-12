import 'package:localizations_translator/custom_classes/button_info.dart';
import 'package:localizations_translator/my_theme.dart';
import 'package:flutter/material.dart';

class BasicTextButton extends StatelessWidget{
  final ButtonInfo? buttonInfo;
  final String? text;
  final Color? color;
  final Function? onTap;
  final TextStyle? textStyle;
  final double paddingHor;
  final double paddingVer;
  final double minWidth;
  final int maxLines;
  final Alignment alignment;

  const BasicTextButton({
    this.buttonInfo,
    this.text,
    this.color,
    this.onTap,
    this.textStyle,
    this.paddingHor = 4,
    this.paddingVer = 4,
    this.minWidth = 30,
    this.maxLines = 1,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    if ((buttonInfo == null || buttonInfo!.text == null) && text == null)
      return Text(
        'missing button info',
        style: MyTheme.TEXT_STYLE_BODY.copyWith(color: MyTheme.TEXT_COLOR_RED),
      );

    String buttonText = buttonInfo?.text ?? text ?? '';
    Function buttonOnTap = buttonInfo?.onTap ?? onTap ?? () => {};
    Color textColor = color ?? buttonInfo?.color ?? textStyle?.color ?? MyTheme.TEXT_COLOR;
    if (buttonInfo != null && !buttonInfo!.enabled)
      textColor = MyTheme.TEXT_COLOR_DISABLED;
    TextStyle style = textStyle ?? MyTheme.TEXT_STYLE_BODY;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          constraints: BoxConstraints(
            minWidth: minWidth,
          ),
          alignment: alignment,
          padding: EdgeInsets.fromLTRB(paddingHor, paddingVer + 2, paddingHor, paddingVer - 2, ),
          child: Text(
            buttonText,
            style: style.copyWith(
              color: Colors.transparent,
              decoration: TextDecoration.underline,
              decorationColor: textColor,
              decorationThickness: 2,
              shadows: [
                Shadow(
                    color: textColor,
                    offset: const Offset(0, -3))
              ],
            ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
        onTap: (onTap != null || buttonInfo?.onTap != null) && (buttonInfo?.enabled ?? true)
            ? buttonOnTap as void Function()?
            : null,
      ),
    );
  }

}
