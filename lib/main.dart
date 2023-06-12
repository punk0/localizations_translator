import 'package:flutter/material.dart';
import 'package:localizations_translator/custom_classes/button_info.dart';
import 'package:localizations_translator/custom_widgets/buttons/default_button.dart';
import 'package:localizations_translator/my_shared_preferences.dart';
import 'package:localizations_translator/my_theme.dart';
import 'package:localizations_translator/text_frame_original.dart';
import 'package:localizations_translator/text_frame_translated.dart';

void main() {
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

  Future<void> _loadSavedApiKey() async{
    _savedApiKey = await MySharedPreferences.getGcpApiKey();

    setState(() {
    _apiTextController.text = _savedApiKey;
    _keySaved = true;
    });
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
  }

  Future<void> _test() async{








  }

  @override
  void initState() {
    super.initState();

    _loadSavedApiKey();

    _test();
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
                Expanded(
                  child: TextFrameOriginal(
                    textChanged: _originalTextChanged,
                  ),
                ),
                const Expanded(child: TextFrameTranslated()),
              ],
            ),
          ),
        ],
      ),
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
