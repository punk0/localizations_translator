
import 'package:flutter/material.dart';
import 'package:localizations_translator/custom_widgets/buttons/my_dropdown_button.dart';
import 'package:localizations_translator/google_translate/locales_available.dart';
import 'package:localizations_translator/my_theme.dart';

class LocaleSelector extends StatefulWidget{
  final Function(String) localeChanged;
  final String initialValue;

  const LocaleSelector({required this.localeChanged, this.initialValue = 'en', });

  @override
  State<LocaleSelector> createState() => _LocaleSelectorState();
}

class _LocaleSelectorState extends State<LocaleSelector> {
  String _selectedLocale = '';

  void _newLocaleSelected(String? selected){
    if (selected == null || selected.split('-').length != 2)
      return;

    String code = selected.split('-')[0].trim();
    
    setState(() {
      _selectedLocale = code;
    });

    widget.localeChanged(code);
  }

  @override
  void initState() {
    super.initState();

    _selectedLocale = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: MyTheme.BACKGROUND_SEC,
      padding: const EdgeInsets.all(8.0),
      child: MyDropdownButton(
        itemNames: LocalesAvailable.getAllLocales(),
        selectedValue: LocalesAvailable.getLocale(_selectedLocale),
        itemValues: LocalesAvailable.getAllLocales(),
        onChanged: _newLocaleSelected,
      ),
    );
  }

}
