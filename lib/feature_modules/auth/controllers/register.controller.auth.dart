import 'package:dietsteps/feature_modules/address/models/shipping_address.model.address.dart';
import 'package:dietsteps/feature_modules/auth/models/register_credential.model.auth.dart';
 import 'package:dietsteps/feature_modules/auth/services/http.services.auth.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/available_genders.shared.constant.dart';
import 'package:dietsteps/shared_module/constants/available_sources.shared.constant.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {

  Rx<TextEditingController> firstNameEnglishTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> lastNameEnglishTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> firstNameArabicTextEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> birthDayController = TextEditingController().obs;

  Rx<TextEditingController> lastNameArabicTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> emailTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> passwordTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> confirmPasswordTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> heightTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> weightTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> otherSourceTextEditingController =
      TextEditingController().obs;

  var isRegisterSubmitting = false.obs;
  var isOtpSending = false.obs;
  var selectedDOB = DateTime
      .now()
      .obs;
  var gender = VALID_GENDERS.male.name.obs;
  var source = VALID_SOURCES.social.name.obs;
  var mobile = "".obs;

  var address = mapAddress({}).obs;

  var profilePictureUrl = ASSETS_DEFAULTPROFILEPIC.obs;
  var isFileSelected = false.obs;

  void updateProfilePicture(String base64encode) {
    isFileSelected.value = true;
    profilePictureUrl.value = base64encode;
  }

  void updateMobile(String newMobile) {
    mobile.value = newMobile;
  }

  void changeGender(String s) {
    gender.value = s;
  }
  void changeSource(String s) {
    source.value = s;
  }

  void changeDob(DateTime selectedDob) {
    selectedDOB.value = selectedDob;
    final f = new DateFormat('dd-MM-yyyy');
    birthDayController.value.text = f.format(selectedDob);
  }

  void updateAddressData(Address tAddress){
    address.value = tAddress;
  }

  handleRegistration() async {

    isRegisterSubmitting.value = true;
    var authHttpService = new AuthHttpService();
    bool isSuccess = await authHttpService.register(RegisterCredential(
        mobile: mobile.value,
        password: passwordTextEditingController.value.text,
        firstName: firstNameEnglishTextEditingController.value.text,
        lastName: lastNameEnglishTextEditingController.value.text,
        firstNameArabic: firstNameArabicTextEditingController.value.text,
        lastNameArabic: lastNameArabicTextEditingController.value.text,
        email: emailTextEditingController.value.text,
        dateOfBirth: selectedDOB.value,
        gender: gender.value,
        height: double.parse(heightTextEditingController.value.text.toString().trim()),
        weight: double.parse(weightTextEditingController.value.text.toString().trim()),
        source: source.value,
        nickname: address.value.nickname,
        area: address.value.areaId,
        block: address.value.blockId,
        street: address.value.street,
        jedha:address.value.jedha,
        houseNumber: address.value.houseNumber,
        floorNumber: address.value.floorNumber,
        apartmentNumber:address.value.apartmentNo,
        comments:address.value.comments,
        profile_picture:isFileSelected.value? profilePictureUrl.value:"",
        other_source: otherSourceTextEditingController.value.text));
    isRegisterSubmitting.value = false;
    if (isSuccess) {
      var sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(
          "mobile", mobile.value);
      showSnackbar(Get.context!, "account_created".tr, "info");
      final sharedController = Get.find<SharedController>();
      sharedController.fetchUserData(
          AppRouteNames.dislikeAuditRoute,
          mobile.value);
    }
  }

}
