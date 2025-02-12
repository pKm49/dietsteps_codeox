import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
 import 'package:dietsteps/feature_modules/auth/services/http.services.auth.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/available_genders.shared.constant.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class ResetPasswordController extends GetxController {
  Rx<TextEditingController> emailTextEditingController =
      TextEditingController().obs;
  var selectedDOB = DateTime
      .now()
      .obs;
  var gender = VALID_GENDERS.male.name.obs;
  Rx<TextEditingController> birthDayController = TextEditingController().obs;

  Rx<TextEditingController> passwordTextEditingController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordTextEditingController = TextEditingController().obs;
  var isOtpVerifying = false.obs;
  var isOtpSending = false.obs;
  var isResetingPassword = false.obs;
  var mobile = "".obs;

  updateMobile(String nMobile){
    mobile.value = nMobile;
  }


  void changeGender(String s) {
    gender.value = s;
  }

  void changeDob(DateTime selectedDob) {
    selectedDOB.value = selectedDob;
    final f = new DateFormat('dd-MM-yyyy');
    birthDayController.value.text = f.format(selectedDob);
  }

  resetPassword() async {
    isResetingPassword.value = true;
    var authHttpService = new AuthHttpService();
    final f = new DateFormat('yyyy-MM-dd');
    String bday = birthDayController.value.text.trim() !=""?f.format(selectedDOB.value):'';
    bool isResetSuccess = await authHttpService.resetPassword( "${mobile}",
        passwordTextEditingController.value.text,
        gender.value,bday,emailTextEditingController.value.text
    );
    isResetingPassword.value = false;

    if(isResetSuccess){
      // Get.offAllNamed(AppRouteNames.loginRoute);
      Get.toNamed(AppRouteNames.otpVerificationSuccessRoute,arguments: [
        ASSETS_SUCCESSMARK,"password_changed","password_changed_message",
        'back_to_login',false,AppRouteNames.loginRoute,mobile.value
      ])?.then((value) => Get.toNamed(AppRouteNames.loginRoute));
    }
  }

}