import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../theme/custom_text_style.dart';

class CustomSearchView extends StatelessWidget {
  CustomSearchView({
    Key? key,
    this.alignment,
    this.width,
    this.controller,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.onChanged,
    this.onTapSuffix
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final Function(String)? onChanged;

  final VoidCallback? onTapSuffix;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: searchViewWidget,
          )
        : searchViewWidget;
  }

  Widget get searchViewWidget => SizedBox(
        width: width ?? double.maxFinite,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode ?? FocusNode(),
          autofocus: autofocus!,
          style: textStyle ?? CustomTextStyles.bodyMediumTextFormFieldGrey,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          decoration: decoration,
          validator: validator,
          onChanged: (String value) {
            onChanged!.call(value);
          },
          cursorColor: TColors.black,
        ),
      );
  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? CustomTextStyles.bodyMediumTextFormFieldGrey,
        prefixIcon: prefix ??
            Container(
              margin: EdgeInsets.fromLTRB(20.hw, 18.v, 12.hw, 18.v),
              child: Icon(Iconsax.search_normal_1),
            ),
        prefixIconConstraints: prefixConstraints ??
            BoxConstraints(
              maxHeight: 56.v,
            ),
       /* suffixIcon: suffix ??
            Container(
              margin: EdgeInsets.fromLTRB(30.hw, 21.v, 23.hw, 21.v),
              child: InkWell(
                onTap: onTapSuffix,
                child: CustomImageView(
                  imagePath: ImageConstant.imgMenu,
                  height: 30.v,
                  width: 25.hw,
                ),
              ),
            ),
        suffixIconConstraints: suffixConstraints ??
            BoxConstraints(
              maxHeight: 56.v,
            ), */
        isDense: true,
        contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 10.v),
        fillColor: fillColor ?? (PrefUtils.getTheme() =='light' ? TColors.white : appTheme.gray700),
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.hw),
              borderSide: BorderSide(color: TColors.grey500, width: 1)
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.hw),
              borderSide: BorderSide(color: TColors.grey500, width: 1)
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.hw),
              borderSide: BorderSide(color: TColors.grey500, width: 1),
              //borderSide: BorderSide.none,
            ),
      );
}
