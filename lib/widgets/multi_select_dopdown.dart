import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/interest_model.dart';
import 'package:dating_app_bilhalal/presentation/filter_screen/controller/filter_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
/*
class MultiSelectDropdown extends StatelessWidget {
  final String hint;
  final List<InterestModel> items;
  final List<InterestModel> selectedItems;
  final void Function(InterestModel, BuildContext) onChanged;

  const MultiSelectDropdown({
    Key? key,
    required this.hint,
    required this.items,
    required this.selectedItems,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text(hint, style: TextStyle(fontSize: 16)),
          items: items.map((item) {
            final isSelected = selectedItems.contains(item);
            return DropdownMenuItem<InterestModel>(
              value: item,
              child: Row(
                children: [
                  Checkbox(
                    value: isSelected,
                    onChanged: (_){
                      onChanged(item, context);
                    },
                    activeColor: Colors.blue,
                    checkColor: Colors.white,
                  ),
                  Text(item.name),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) => onChanged(value!, context),
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 14),
            height: 50,
            width: double.infinity,
          ),
          menuItemStyleData: const MenuItemStyleData(height: 40),
        ),
      );
    });
  }
}
*/

class MultiSelectDropdown extends StatelessWidget {
  final String hint;
  final List<InterestModel> items;
  final FilterController controller;
  final double borderRadius;
  final Color? fillColor;
  final Color? themeColor;
  final TextStyle? hintStyle;
  final EdgeInsets? contentPadding;

  const MultiSelectDropdown({
    super.key,
    required this.hint,
    required this.items,
    required this.controller,
    this.borderRadius = 12,
    this.fillColor,
    this.themeColor,
    this.hintStyle,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: fillColor ?? (PrefUtils().getThemeData() == 'light' ? Colors.white : appTheme.blueGray900),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: Color(0xFD636262)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text(hint, style: const TextStyle(fontSize: 16)),
          items: [

            // ==== Ajout du bouton fermer ====
            DropdownMenuItem(
              enabled: false,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    Navigator.pop(context); // Ferme le menu manuellement
                  },
                ),
              ),
            ),

            ...items.map((item) {
              final isSelected = controller.selectedInterests.contains(item);
              return DropdownMenuItem<InterestModel>(
                  value: item,
                  enabled: false, // Empêche la fermeture du menu
                  child: InkWell(
                    onTap: () {
                      controller.toggleInterest(item, context);
                    },
                    child: Row(
                      children: [
                        Obx(() => Checkbox(
                          value: controller.selectedInterests.value.contains(item),
                          //value: isSelected,
                          onChanged: (_) {
                            controller.toggleInterest(item, context);
                          },
                          activeColor: Colors.blue,
                          checkColor: Colors.white,
                        )),
                        Expanded(
                          child: Text(item.name, overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  )
              );
            }).toList(),
          ],
          onChanged: (_) {}, // On bloque la fermeture par défaut
          buttonStyleData: ButtonStyleData(
            padding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            height: 70.v,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: themeColor ?? appTheme.gray700,
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(height: 40),
        )
      ),
    );
  }
}