
import 'package:flutter/material.dart';
import 'package:localizations_translator/my_theme.dart';

class TextFrameOriginal extends StatelessWidget{
  final Function(String)? textChanged;

  const TextFrameOriginal({this.textChanged, });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: ColoredBox(
        color: MyTheme.BACKGROUND_SEC,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: TextFormField(
            maxLines: 1000,
            style: MyTheme.TEXT_STYLE_BODY,
            onChanged: textChanged,
          ),
        ),
      ),
    );
  }

}
