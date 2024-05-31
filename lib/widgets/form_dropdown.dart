import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kelpet/constants/colors.dart';

class FormDropDown extends StatelessWidget {
  final double? fontSize;
  final Color? dropColor;
  final Object? value;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final List<DropdownMenuItem<Object>>? items;
  final void Function(Object?)? onChanged;
  final Widget? Icon;
  final String? hint;
  const FormDropDown({
    super.key,
    required this.fontSize,
    required this.onChanged,
    required this.value,
    required this.selectedItemBuilder,
    required this.items,
    required this.dropColor,
    this.Icon,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      borderRadius: BorderRadius.circular(8),
      focusColor: primary,
      icon: Icon,
      value: value,
      elevation: 0,
      style: TextStyle(
        fontSize: fontSize,
        color: primary,
        overflow: TextOverflow.ellipsis,
      ),
      dropdownColor: dropColor,
      isExpanded: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: name,
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      selectedItemBuilder: selectedItemBuilder,
      items: items,
      onChanged: onChanged,
    );
  }
}
