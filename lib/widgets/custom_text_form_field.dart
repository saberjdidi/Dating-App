import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    this.alignment,
    this.width,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.maxLength,
    this.hintText,
    this.counterText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.enabled = true,
    this.validator,
    this.onChange,
    this.onTap,
    this.onEditingComplete
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final int? maxLength;

  final String? hintText;

  final String? counterText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final bool? enabled;

  final FormFieldValidator<String>? validator;

  final Function(String)? onChange;
  final Function()? onTap;
  final Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    //var _appTheme = PrefUtils.getTheme();

    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget,
          )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => SizedBox(
        width: width ?? double.maxFinite,
        child: TextFormField(
          controller: controller,
          enabled: enabled,
          focusNode: focusNode ?? FocusNode(),
          autofocus: autofocus!,
          style: textStyle ?? CustomTextStyles.bodyMediumTextFormField,
          obscureText: obscureText!,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          decoration: decoration,
          validator: validator,
          onChanged: onChange,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          maxLength: maxLength,
          cursorColor: TColors.black,
        ),
      );
  InputDecoration get decoration => InputDecoration(
    border: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.hw),
          //borderSide: BorderSide.none,
        ),
        labelText: hintText ?? "",
        hintText: hintText ?? "",
        counterText: counterText ?? "",
        hintStyle: hintStyle ?? CustomTextStyles.titleLargeGray400,
        //hintStyle: hintStyle ?? CustomTextStyles.titleSmallGray400,
        labelStyle: hintStyle ?? CustomTextStyles.titleMediumSemiBoldBlack,
        errorStyle: hintStyle ?? CustomTextStyles.bodyMediumOnError,
        counterStyle: CustomTextStyles.titleMedium16YellowDark,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ?? EdgeInsets.all(19.hw),
        fillColor: fillColor ?? TColors.white,
        filled: filled,
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.hw),
              borderSide: BorderSide(color: PrefUtils.getTheme() =='light' ? Color(0xFD636262) : TColors.yellowAppLight, width: 1)
              //borderSide: BorderSide.none,
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.hw),
              borderSide: BorderSide(color: PrefUtils.getTheme() =='light' ? TColors.greyDating : TColors.yellowAppDark, width: 2)
              //borderSide: BorderSide.none,
            ),
      );
}
