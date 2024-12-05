import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:t_quiz/utils/colors.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = Offset.zero,
    super.key,
  });
  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    double sizedWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          //To avoid long text overflowing.
          isExpanded: true,
          hint: Container(
            alignment: hintAlignment,
            child: Text(
              hint,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: inactiveSwitch,
              ),
            ),
          ),
          value: value,
          items: dropdownItems
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Container(
                      alignment: valueAlignment,
                      child: Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
          selectedItemBuilder: selectedItemBuilder,
          buttonStyleData: ButtonStyleData(
            height: buttonHeight ?? 48,
            width: buttonWidth ?? sizedWidth,
            padding: buttonPadding ??
                const EdgeInsets.only(
                  left: 14,
                  right: 14,
                ),
            decoration: buttonDecoration ??
                BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: black.withOpacity(0.5), width: 2),
                ),
            elevation: buttonElevation,
          ),
          iconStyleData: IconStyleData(
            icon: icon ?? const Icon(Icons.keyboard_arrow_down_sharp),
            iconSize: iconSize ?? 12,
            iconEnabledColor: iconEnabledColor,
            iconDisabledColor: iconDisabledColor,
          ),
          dropdownStyleData: DropdownStyleData(
            //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
            maxHeight: dropdownHeight ?? 200,
            width: dropdownWidth ?? sizedWidth - 90,
            padding: dropdownPadding,
            decoration: dropdownDecoration ??
                BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
            elevation: dropdownElevation ?? 8,
            //Null or Offset(0, 0) will open just under the button. You can edit as you want.
            offset: offset,
            scrollbarTheme: ScrollbarThemeData(
              radius: scrollbarRadius ?? const Radius.circular(40),
              thickness: scrollbarThickness != null
                  ? MaterialStateProperty.all<double>(scrollbarThickness!)
                  : null,
              thumbVisibility: scrollbarAlwaysShow != null
                  ? MaterialStateProperty.all<bool>(scrollbarAlwaysShow!)
                  : null,
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            height: itemHeight ?? 40,
            padding: itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}
