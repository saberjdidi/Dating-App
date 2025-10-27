import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/country_model.dart';
import 'package:dating_app_bilhalal/data/models/selection_popup_model.dart';
import 'package:flutter/material.dart';
import '../core/utils/pref_utils.dart';
import '../theme/custom_text_style.dart';
import '../theme/theme_helper.dart';

class CustomDropDownCountry extends StatelessWidget {
  CustomDropDownCountry({
    Key? key,
    this.alignment,
    this.width,
    this.borderRadius = 12,
    this.focusNode,
    this.icon,
    this.autofocus = true,
    this.textStyle,
    this.items,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.themeColor,
    this.filled = true,
    this.enabled = true,
    this.validator,
    this.onChanged,
    this.selectedValue,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final double borderRadius;

  final FocusNode? focusNode;

  final Widget? icon;

  final bool? autofocus;

  final TextStyle? textStyle;

  final List<CountryModel>? items;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final Color? themeColor;

  final bool? filled;

  final bool enabled;

  //final FormFieldValidator<String>? validator;
  final FormFieldValidator<CountryModel>? validator;

  final Function(CountryModel)? onChanged;

  final CountryModel? selectedValue;
  //final String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildDropDownWidget(context),
          )
        : buildDropDownWidget(context);
  }

  Widget buildDropDownWidget(BuildContext context) => SizedBox(
        width: width ?? double.maxFinite,
        child: Theme(
          data: Theme.of(context).copyWith(canvasColor: themeColor ?? appTheme.gray700), //background dropdown list
          child: DropdownButtonFormField<CountryModel>(
            value: items!.isNotEmpty ? selectedValue : null,
            //value:  selectedValue,
            focusNode: focusNode ?? FocusNode(),
            icon: icon,
            isExpanded: true,
            autofocus: autofocus!,
            style: textStyle ?? CustomTextStyles.titleMediumSourceSansPro,
            items: items?.map((item) => DropdownMenuItem(
              value: item,
              child: Row(
                children: [
                  if (item.flag != null)
                    CustomImageView(imagePath: item.flag,
                      height: 20.adaptSize,
                      width: 20.adaptSize,
                      fit: BoxFit.fill,),
                  const SizedBox(width: 5),
                  Text(item.name ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: hintStyle ?? CustomTextStyles.titleMediumSourceSansPro,),
                ],
              ),
            )).toList(),
           /* items: items?.map((CountryModel item) {
              return DropdownMenuItem<CountryModel>(
                //value: selectedValue,
                value: item,
                enabled: enabled,
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.v),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                     // mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(item.name != "الکل")
                          CustomImageView(
                            imagePath: item.flag,
                            height: 20.adaptSize,
                            width: 20.adaptSize,
                            fit: BoxFit.fill,
                          ),
                        SizedBox(width: 5.adaptSize),
                        Text(
                          item.name!,
                          overflow: TextOverflow.ellipsis,
                          style: hintStyle ?? CustomTextStyles.titleMediumSourceSansPro,
                          //maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(), */
            decoration: decoration,
            validator: validator,
            onChanged: (value) => onChanged?.call(value!),
            //onChanged: (value) {onChanged!(value!);},
          ),
        ),
      );
  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        labelText: hintText ?? "",
        hintStyle: hintStyle ?? CustomTextStyles.titleSmallGray400,
        labelStyle: hintStyle ?? (PrefUtils.getTheme() =='light'
            ? CustomTextStyles.titleMediumSemiBoldBlack
            : CustomTextStyles.titleMediumSourceSansPro),
        errorStyle: hintStyle ?? CustomTextStyles.bodyMediumOnError, //CustomTextStyles.bodyMediumOnError,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.only(
              left: 19.hw,
              top: 19.v,
              bottom: 19.v,
            ),
        fillColor: fillColor ?? (PrefUtils.getTheme() =='light' ? TColors.darkerGrey : appTheme.blueGray900),
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius.hw),
              borderSide: BorderSide(color: TColors.darkGrey, width: 1),
              //borderSide: BorderSide.none,
            ),
            enabledBorder: borderDecoration ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius.hw),
                  borderSide: BorderSide(color: Color(0xFD636262), width: 1)
                  //borderSide: BorderSide.none,
                ),
            focusedBorder: borderDecoration ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius.hw),
                  borderSide: BorderSide(color: TColors.primaryColorApp, width: 2)
                  //borderSide: BorderSide.none,
                ),
      );
}
