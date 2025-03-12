import 'package:localizations_translator/custom_classes/button_info.dart';
import 'package:localizations_translator/custom_widgets/dialogs/default_dialog.dart';
import 'package:localizations_translator/my_theme.dart';
import 'package:flutter/material.dart';

class SimpleMessageDialog{

  static Future<void> show({String title = '', String body = '', Color? bodyColor,
    required BuildContext context, List<ButtonInfo> actions = const [],
    bool dismissible = DefaultDialog.BARRIER_DISMISSIBLE, } ) async {

    await showDialog(
      context: context,
      barrierDismissible: dismissible,
      barrierColor: DefaultDialog.BARRIER_COLOR,
      builder: (_) => DefaultDialog(
        title: title,
        dismissible: dismissible,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              body,
              style: MyTheme.TEXT_STYLE_BODY.copyWith(
                  color: bodyColor ?? MyTheme.TEXT_COLOR),
            ),
          ],
        ),
        actions: actions,
      ),
    );
  }

}
