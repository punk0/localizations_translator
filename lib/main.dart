import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localizations_translator/custom_classes/button_info.dart';
import 'package:localizations_translator/custom_widgets/buttons/default_button.dart';
import 'package:localizations_translator/google_translate/google_translator_controller.dart';
import 'package:localizations_translator/locale_selector.dart';
import 'package:localizations_translator/my_shared_preferences.dart';
import 'package:localizations_translator/my_theme.dart';
import 'package:localizations_translator/text_frame_original.dart';
import 'package:localizations_translator/text_frame_translated.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
  }
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Localizations Translator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _apiTextController = TextEditingController();
  String _savedApiKey = '';
  bool _keySaved = false;
  String _selectedFrom = 'en';
  String _selectedTo = 'pt';
  List<List<String>> _originalText = [];
  List<List<String>> _translatedText = [];
  bool _translating = false;
  bool _textChanged = false;

  Future<void> _loadSavedApiKey() async{
    _savedApiKey = await MySharedPreferences.getGcpApiKey();

    setState(() {
    _apiTextController.text = _savedApiKey;
    _keySaved = true;
    });

    if (_savedApiKey.isNotEmpty)
      _initTranslator();
  }
  
  Future<void> _saveNewApiKey() async{
    setState(() {
      _savedApiKey = _apiTextController.text;
      MySharedPreferences.setGcpApiKey(_savedApiKey);
      _keySaved = true;
    });
  }

  Future<void> _apiKeyTextChanged(String newText) async{
    bool saved = _savedApiKey == _apiTextController.text;

    if (saved != _keySaved)
      setState(() {
        _keySaved = saved;
      });
  }

  Future<void> _originalTextChanged(String newText) async{
    _textChanged = true;
    _originalText = [];
    List<String> lines = newText.split('\n');
    for (String l in lines){
      List<String> parts = l.split(':');
      if (parts.length == 2){
        String name = parts[0].replaceAll("'", '').replaceAll(",", '').trim();
        String word = parts[1].replaceAll("'", '').replaceAll(",", '').trim();

        _originalText.add([name, word, ]);
        print('$name: $word');
      }
    }

    if (mounted)
      setState(() {});
  }

  Future<void> _initTranslator() async{
    GoogleTranslatorController.init(
      _savedApiKey,
      Locale(_selectedFrom),
      translateTo: Locale(_selectedTo),
      cacheDuration: const Duration(days: 7),
    );

    String result = await GoogleTranslatorController().translateText('exit');
    print('result: $result');

  }

  Future<void> _translate() async{
    print('translating: ${_originalText.length} lines');

    setState(() {
      _translating = true;
    });

    _translatedText = [];
    for (List<String> word in _originalText)
      if (word.length == 2 && word[1].isNotEmpty){
        String result = await GoogleTranslatorController().translateText(word[1]);
        _translatedText.add([word[0], result, ]);
      }

    _translating = false;
    _textChanged = false;
    if (mounted)
      setState(() {});
  }

  void _sourceLocaleChanged(String newLocale){
    _selectedFrom = newLocale;
    _initTranslator();
    _textChanged = true;

    if (mounted)
      setState(() {});
    print('new source locale: $_selectedFrom');
  }

  void _destLocaleChanged(String newLocale){
    _selectedTo = newLocale;
    _initTranslator();
    _textChanged = true;

    if (mounted)
      setState(() {});
    print('new dest locale: $_selectedTo');
  }

  @override
  void initState() {
    super.initState();

    _loadSavedApiKey();

    _translatedText = [
      ['111111', '222222'],
      ['3333333', '444444444'],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.BACKGROUND_MAIN,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _apiKeyForm(),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _getOriginalForm()),
                Expanded(child: _getTranslatedForm()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getOriginalForm(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LocaleSelector(
          localeChanged: _sourceLocaleChanged,
        ),
        const SizedBox(height: 10,),
        Expanded(
          child: TextFrameOriginal(
            textChanged: _originalTextChanged,
          ),
        ),
      ],
    );
  }

  Widget _getTranslatedForm(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: LocaleSelector(
                localeChanged: _destLocaleChanged,
                initialValue: _selectedTo,
              ),
            ),
            const SizedBox(width: 10,),
            DefaultButton(
              buttonInfo: ButtonInfo(
                text: 'TRANSLATE',
                onTap: _translate,
                enabled: _originalText.isNotEmpty && _textChanged,
              ),
              isLoading: _translating,
            ),
            const SizedBox(width: 20,),
          ],
        ),
        const SizedBox(height: 10,),
        Expanded(
          child: TextFrameTranslated(
              result: _translatedText,
          ),
        ),
      ],
    );
  }
  
  Widget _apiKeyForm(){
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(child: _apiKeyEdit()),
          DefaultButton(
            buttonInfo: ButtonInfo(
              text: 'SAVE',
              onTap: _saveNewApiKey,
              enabled: !_keySaved,
            ),
          ),
        ],
      ),
    );
  }

  Widget _apiKeyEdit(){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15, ),
            child: SizedBox(
              width: 80,
              child: Text(
                'GCP API Key',
                style: MyTheme.TEXT_STYLE_BODY,
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: ColoredBox(
              color: MyTheme.BACKGROUND_SEC,
              child: TextFormField(
                maxLines: 1,
                controller: _apiTextController,
                style: MyTheme.TEXT_STYLE_BODY,
                onChanged: _apiKeyTextChanged,
              ),
            ),
          )
        ],
      ),
    );
  }

}
