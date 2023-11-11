import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../values/values.dart';

class CustomTextField2 extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? bordercolor;
  final Color? background;
  final String text;
  final int length;
  final TextInputType keyboardType;
  final TextInputFormatter inputFormatters;
  bool? Readonly = false;
  final Icon? icon;
  final InputBorder? border;
  final String? errorText;
  final FocusNode? focusNode;
  final String? suffixtext;
  final Color? hintColor;
  final int? maxlines;
  final Color? color;

  TextEditingController? controller;
  FormFieldValidator<String>? validator;
  ValueChanged<String>? onChanged;

  CustomTextField2({
    Key? key,
    this.height,
    this.width,
    this.bordercolor,
    this.background,
    this.controller,
    this.border,
    this.maxlines,
    required this.text,
    this.validator,
    this.onChanged,
    this.errorText,
    this.Readonly,
    this.focusNode,
    this.hintColor,
    this.icon,
    this.color,
    this.suffixtext,
    required this.length,
    required this.keyboardType,
    required this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: background??Colors.white,
      ),
      child: TextFormField(
        maxLength: length,
        cursorHeight: 25,
        maxLines: maxlines ?? 1,
        focusNode: focusNode,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        style: textTheme.bodyLarge!.copyWith(fontSize: 16,color: Colors.black),
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        inputFormatters: <TextInputFormatter>[inputFormatters],
        textInputAction: TextInputAction.next,
        readOnly: Readonly == true ? true : false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: text,
          hintStyle: textTheme.bodyText1!.copyWith(color: MyColors.grey),
          // border: OutlineInputBorder(
          //   borderSide: BorderSide(color: color ?? MyColors.purple, width: 0.5),
          // ),
          errorText: errorText,
          counterText: "",
          errorStyle: const TextStyle(fontSize: 0),
          //enabledBorder: OutlineInputBorder(
            //borderSide:
               // BorderSide(color: MyColors.black.withOpacity(0.5), width: 0.5),
          //),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.red500, width: 0.5),
          ),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: color ?? MyColors.purple, width: 0.5),
          // ),
          contentPadding: const EdgeInsets.only(bottom: 8, left: 15, right: 10),
          prefixIcon: icon,
          suffixText: suffixtext,
          focusColor: MyColors.purple,
        ),
      ),
    );
  }
}
