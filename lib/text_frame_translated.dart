
import 'package:flutter/material.dart';
import 'package:localizations_translator/my_theme.dart';

class TextFrameTranslated extends StatelessWidget{
  final List<List<String>> result;

  const TextFrameTranslated({this.result = const [], });

  @override
  Widget build(BuildContext context) {
    String allLines = '';
    for (List<String> values in result)
      if (values.length == 2)
        allLines += "'${values[0]}': '${values[1]}',\n";
    allLines += "\n";

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SelectableText(
        allLines,
        style: MyTheme.TEXT_STYLE_BODY,
      ),
    );
  }

}
