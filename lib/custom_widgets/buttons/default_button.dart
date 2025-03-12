import 'package:localizations_translator/custom_classes/button_info.dart';
import 'package:localizations_translator/my_theme.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget{
  final ButtonInfo? buttonInfo;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? foregroundColorDisabled;
  final Color? backgroundColorDisabled;
  final double? textSize;
  final double iconSize;
  final double width;
  final double height;
  final double paddingHor;
  final double paddingVer;
  final bool isLoading;
  final Color? progressIndicatorColor;

  const DefaultButton({
    this.buttonInfo,
    this.textSize,
    this.iconSize = MyTheme.ICON_SIZE,
    this.foregroundColor, this.backgroundColor,
    this.foregroundColorDisabled, this.backgroundColorDisabled,
    this.width = MyTheme.BUTTON_WIDTH,
    this.height = MyTheme.BUTTON_HEIGHT,
    this.paddingHor = 0,
    this.paddingVer = 0,
    this.isLoading = false,
    this.progressIndicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    bool hasText = buttonInfo != null && buttonInfo!.text != null && buttonInfo!.text!.isNotEmpty;
    bool hasIcon = buttonInfo?.iconData != null || buttonInfo?.icon != null;

    if (!hasText && !hasIcon)
      return Text(
        'missing button info',
        style: MyTheme.TEXT_STYLE_BODY.copyWith(color: MyTheme.TEXT_COLOR_RED),
      );

    Function buttonOnTap = buttonInfo?.onTap ?? () => {};
    Color color = foregroundColor ?? buttonInfo?.color ?? MyTheme.TEXT_COLOR_BUTTON;
    Color backColor = backgroundColor ?? buttonInfo?.backColor ?? MyTheme.COLOR_BUTTON_BACKGROUND;
    Color colorDisabled = foregroundColorDisabled ?? color;
    Color backColorDisabled = backgroundColorDisabled ?? MyTheme.TEXT_COLOR_DISABLED;
    Color progressIndColor = progressIndicatorColor ?? MyTheme.PRIMARY_COLOR;
    double? fontSize = textSize;
    if (fontSize == null){
      if (!hasIcon)
        fontSize = MyTheme.TEXT_SIZE_TITLE;
      else
        fontSize = MyTheme.TEXT_SIZE_BODY;
    }
    TextStyle style = MyTheme.TEXT_STYLE_BODY.copyWith(color: color, fontSize: fontSize);

    return InkWell(
      child: SizedBox(
        width: width,
        height: height,
        child: ColoredBox(
          color: buttonInfo?.onTap != null && buttonInfo!.enabled && !isLoading
              ? backColor
              : backColorDisabled,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingHor, vertical: paddingVer, ),
            child: isLoading
                ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CircularProgressIndicator(color: progressIndColor,),
                ),
              ),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (hasText)
                  ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 2, left: 5, right: 5, ),
                      child: Text(
                        buttonInfo!.text!,
                        style: style.copyWith(color: buttonInfo!.onTap != null && buttonInfo!.enabled
                            ? color
                            : colorDisabled,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                if (buttonInfo?.iconData != null)
                  ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Icon(
                        buttonInfo!.iconData,
                        size: iconSize,
                        color: buttonInfo!.onTap != null && buttonInfo!.enabled
                            ? color
                            : colorDisabled,
                      ),
                    ),
                  ],
                if (buttonInfo?.icon != null)
                  ...[
                    buttonInfo!.icon!,
                  ],
              ],
            ),
          ),
        ),
      ),
      onTap: buttonInfo!.onTap != null && buttonInfo!.enabled
          ? buttonOnTap as void Function()?
          : null,
    );
  }

}
