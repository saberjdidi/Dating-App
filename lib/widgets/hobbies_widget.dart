import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/interest_model.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/controller/hobbie_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HobbiesWidget extends StatelessWidget {
  const HobbiesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HobbieController());

    return Obx(() {
      if (controller.isDataProcessing.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.selectedHobbies.isEmpty) {
        return const Center(child: Text('لا توجد اهتمامات بعد'));
      }

      final selected = controller.selectedHobbies;

      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: interestsList.value.map((hobby) {
          final isSelected = selected.contains(hobby);
          return GestureDetector(
            onTap: () => controller.toggleHobby(hobby, context),
            child: Container(
              padding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? TColors.primaryColorApp
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(hobby.icon,
                      size: 18,
                      color:
                      isSelected ? Colors.white : Colors.black54),
                  const SizedBox(width: 6),
                  Text(
                    hobby.name!,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      );
    });
  }
}
