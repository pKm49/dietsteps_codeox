// import 'dart:convert';
// import 'dart:io';
//
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lifebalance/feature-modules/profile/models/allergy_dislikes.profile.model.dart';
// import 'package:lifebalance/shared-module/constants/ui_specific/style_params.shared.constant.dart';
// import 'package:lifebalance/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
// import 'package:lifebalance/shared-module/models/user_details.dart';
// import 'package:lifebalance/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
// import 'package:lifebalance/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class ProfileHelperServices {
//
//   ProfileHelperServices();
//
//
//   Future<String?> getMedicalReport() async {
//
//     FilePickerResult? result1 = await FilePicker.platform.pickFiles(
//         type: FileType.custom, allowedExtensions: ['pdf','jpg', 'png', 'jpeg']);
//
//     if (result1 == null) return null;
//
//     if (result1.files.isEmpty) return null;
//
//     File medicalReport1File = File(result1.files.first.path!);
//
//     List<int> imageBytes = medicalReport1File.readAsBytesSync();
//     return base64Encode(imageBytes);
//
//   }
//
//   List<AllergyDislikes> removeAllergyDislikes( UserData userData, int itemType, int id) {
//
//     List<int> tempAllergies = [];
//     List<int> tempAllergyCategories = [];
//     List<int> tempDislikes = [];
//     List<int> tempDislikeCategories = [];
//
//     if (itemType == 2) {
//       tempAllergies = userData.allergies
//           .where((element) => element.id != id)
//           .toList()
//           .map((e) => e.id)
//           .toList();
//     } else {
//       tempAllergies = userData.allergies.map((e) => e.id).toList();
//     }
//
//
//
//     if (itemType == 1) {
//       tempAllergyCategories = userData.allergyCategories
//           .where((element) => element.id != id)
//           .toList()
//           .map((e) => e.id)
//           .toList();
//     } else {
//       tempAllergyCategories =
//           userData.allergyCategories.map((e) => e.id).toList();
//     }
//
//     if (itemType == 4) {
//       tempDislikes = userData.dislikes
//           .where((element) => element.id != id)
//           .toList()
//           .map((e) => e.id)
//           .toList();
//     } else {
//       tempDislikes = userData.dislikes.map((e) => e.id).toList();
//     }
//     if (itemType == 3) {
//       tempDislikeCategories = userData.dislikeCategories
//           .where((element) => element.id != id)
//           .toList()
//           .map((e) => e.id)
//           .toList();
//     } else {
//       tempDislikeCategories =
//           userData.dislikeCategories.map((e) => e.id).toList();
//     }
//
//     List<AllergyDislikes> allergyDislikes = [];
//     allergyDislikes.add(AllergyDislikes(
//         allergies: tempAllergies,
//         allergyCategories: tempAllergyCategories,
//         dislikes: tempDislikes,
//         dislikeCategories: tempDislikeCategories));
//     return allergyDislikes;
//     // context.read<ProfileBloc>().add(
//     //     UpdateAllergyDislikeSubmitting(userAllergyDislikes: allergyDislikes ));
//   }
//
// }
//
