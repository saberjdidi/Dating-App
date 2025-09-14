import 'dart:io';
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/permissions_helper.dart';
import 'package:dating_app_bilhalal/presentation/account_screen/controller/create_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class ProfileImageStack extends StatelessWidget {
  final String defaultImage;
  final String uploadIcon;
  final double size;
  final CreateAccountController controller;

  const ProfileImageStack({
    Key? key,
    required this.defaultImage,
    required this.uploadIcon,
    required this.controller,
    this.size = 120,
  }) : super(key: key);

  Future<void> _pickImage(BuildContext context) async {
    final hasPermission = await PermissionsHelper.requestMediaPermissions();

    if (!hasPermission) {
      Get.snackbar("Permissions", "Please allow camera and gallery access");
      return;
    }

    final ImagePicker picker = ImagePicker();
    final pickedFile = await showModalBottomSheet<XFile?>(
      context: context,
      builder: (context) => _buildImagePickerOptions(context, picker),
    );

    if (pickedFile != null) {
      controller.setImage(File(pickedFile.path));
    }
  }

  Widget _buildImagePickerOptions(BuildContext context, ImagePicker picker) {
    return SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text("Gallery"),
            onTap: () async {
              final picked = await picker.pickImage(source: ImageSource.gallery);
              Navigator.pop(context, picked);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Camera"),
            onTap: () async {
              final picked = await picker.pickImage(source: ImageSource.camera);
              Navigator.pop(context, picked);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          /// Image de profil
          Obx(() {
            final imageFile = controller.selectedImage.value;
            return ClipOval(
              child: imageFile == null
                  ? Image.asset(
                defaultImage,
                height: size,
                width: size,
                fit: BoxFit.cover,
              )
                  : Image.file(
                imageFile,
                height: size,
                width: size,
                fit: BoxFit.cover,
              ),
            );
          }),

          /// Bouton upload en bas à droite
          Positioned(
            bottom: -10,
            right: -10,
            child: GestureDetector(
              onTap: () => _pickImage(context),
              child: Container(
                height: size * 0.4,
                width: size * 0.4,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: CustomImageView(
                  imagePath: uploadIcon,
                  //height: 100.adaptSize,
                  //width: 100.adaptSize,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
