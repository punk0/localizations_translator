
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localizations_translator/custom_classes/button_info.dart';
import 'package:localizations_translator/custom_widgets/buttons/default_button.dart';
import 'package:localizations_translator/my_theme.dart';

class TextFrameTranslated extends StatefulWidget{
  final List<List<String>> result;

  const TextFrameTranslated({this.result = const [], });

  @override
  State<TextFrameTranslated> createState() => _TextFrameTranslatedState();
}

class _TextFrameTranslatedState extends State<TextFrameTranslated> {
  String _previousLines = '';
  String _allLines = '';
  bool _copied = false;
  bool _differentLines = false;

  Future<void> _copyText() async{
    await Clipboard.setData(ClipboardData(text: _allLines));

    _copied = true;
    if (mounted)
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _allLines = '';
    for (List<String> values in widget.result) {
      if (values.length == 2)
        _allLines += "'${values[0]}': '${values[1]}',\n";
      else if (values.length == 1)
        _allLines += '${values[0]}\n';
    }
    _allLines += "\n";

    _differentLines = _allLines != _previousLines;
    _previousLines = _allLines;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: SelectableText(
            _allLines,
            style: MyTheme.TEXT_STYLE_BODY,
          ),
        ),
        if (_allLines.length > 2)
          Positioned(
            bottom: 20,
            right: 20,
            child: DefaultButton(
              buttonInfo: ButtonInfo(
                text: 'COPY',
                onTap: _copyText,
                enabled: !_copied || _differentLines,
              ),
            ),
          )
      ],
    );
  }
}
