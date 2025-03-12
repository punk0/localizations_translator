
import 'package:flutter/material.dart';
import 'package:localizations_translator/custom_classes/button_info.dart';
import 'package:localizations_translator/my_theme.dart';

class BasicIconButton extends StatelessWidget{
  final ButtonInfo buttonInfo;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double? iconSize;
  final double? buttonWidth;
  final double? buttonHeight;
  final double paddingHor;
  final double paddingVer;

  const BasicIconButton({
    required this.buttonInfo,
    this.foregroundColor, this.backgroundColor,
    this.iconSize,
    this.paddingHor = 0, this.paddingVer = 0,
    this.buttonWidth = MyTheme.BUTTON_HEIGHT,
    this.buttonHeight = MyTheme.BUTTON_HEIGHT,
  });

  @override
  Widget build(BuildContext context) {
    Color foreColor = buttonInfo.color ?? foregroundColor ?? MyTheme.TEXT_COLOR_BUTTON;
    Color backColor = buttonInfo.backColor ?? backgroundColor ?? MyTheme.COLOR_BUTTON_BACKGROUND;

    if ((buttonInfo.color == null && foregroundColor == null)
    && (buttonInfo.backColor == MyTheme.PRIMARY_COLOR || backgroundColor == MyTheme.PRIMARY_COLOR
        || buttonInfo.backColor == MyTheme.TEXT_COLOR_RED || backgroundColor == MyTheme.TEXT_COLOR_RED))
      foreColor = MyTheme.TEXT_COLOR_BUTTON;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: buttonInfo.enabled
            ? buttonInfo.onTap as void Function()?
            : null,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingHor, vertical: paddingVer, ),
          child: Container(
            padding: const EdgeInsets.only(top: 2),
            width: buttonWidth,
            height: buttonHeight,
            alignment: Alignment.center,
            color: buttonInfo.onTap != null && buttonInfo.enabled
                ? backColor
                : backColor.withOpacity(0.7),
            child: buttonInfo.text != null && buttonInfo.text!.isNotEmpty
                ? _getText(context, foreColor)
                : _getIcon(foreColor),
          ),
        ),
      ),
    );
  }

  Widget _getText(BuildContext context, Color textColor){
    return Text(
      buttonInfo.text!,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: MyTheme.TEXT_STYLE_BODY.copyWith(
        color: buttonInfo.onTap != null && buttonInfo.enabled
            ? textColor
            : MyTheme.TEXT_COLOR_DISABLED,
      ),
    );
  }

  Widget _getIcon(Color iconColor){
    if (buttonInfo.iconData != null)
      return Icon(
        buttonInfo.iconData,
        size: iconSize,
        color: buttonInfo.onTap != null && buttonInfo.enabled
            ? iconColor
            : MyTheme.TEXT_COLOR_DISABLED,
      );
    else if (buttonInfo.icon != null)
      return buttonInfo.icon!;
    else
      return const SizedBox();
  }

}
