import 'package:localizations_translator/my_theme.dart';
import 'package:flutter/material.dart';

class MyDropdownButton extends StatelessWidget {
  final String? selectedValue;
  final List<String> itemNames, itemValues;
  final Function(String?) onChanged;
  final double leftPadding;

  const MyDropdownButton({required this.itemNames, required this.selectedValue,
    required this.itemValues, required this.onChanged, this.leftPadding = 20, });

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<String>> dropDownItems = [];
    for (int i = 0; i < itemNames.length; i++)
      dropDownItems.add(
        DropdownMenuItem<String>(
          value: itemValues[i],
          child: ColoredBox(
            color: itemValues[i] == selectedValue ? MyTheme.PRIMARY_COLOR : Colors.transparent,
            child: SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  itemNames[i],
                  style: MyTheme.TEXT_STYLE_BODY
                      .copyWith(
                    color: MyTheme.TEXT_COLOR,
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      );

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        iconSize: 26,
        dropdownColor: MyTheme.BACKGROUND_MAIN,
        iconDisabledColor: MyTheme.TEXT_COLOR_DISABLED,
        iconEnabledColor: MyTheme.PRIMARY_COLOR,
        value: selectedValue,
        alignment: Alignment.centerLeft,
        onChanged: onChanged,
        items: dropDownItems,
        selectedItemBuilder: (_) {
          return itemNames.map((e) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, ),
            padding: EdgeInsets.only(top: 3, left: leftPadding, ),
            child: Text(
              e,
              style: MyTheme.TEXT_STYLE_BODY,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),)
              .toList();
        },
      ),
    );
  }

}
