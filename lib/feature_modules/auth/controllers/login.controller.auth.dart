import 'package:dietsteps/feature_modules/auth/models/login_credential.model.auth.dart';
import 'package:dietsteps/feature_modules/auth/services/http.services.auth.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {

  Rx<TextEditingController> mobileTextEditingController = TextEditingController().obs;
  Rx<TextEditingController> passwordTextEditingController = TextEditingController().obs;
  var isLoginSubmitting = false.obs;

  handleLogin() async {
    isLoginSubmitting.value = true;
    var authHttpService = new AuthHttpService();
     bool isSuccess = await authHttpService.login(
         LoginCredential(mobile: mobileTextEditingController.value.text,
             password: passwordTextEditingController.value.text));
    isLoginSubmitting.value = false;

     if(isSuccess){
       var sharedPreferences = await SharedPreferences.getInstance();
       sharedPreferences.setString("mobile", mobileTextEditingController.value.text);
       final sharedController = Get.find<SharedController>();

       sharedController.fetchUserData(AppRouteNames.homeRoute,mobileTextEditingController.value.text);
     }

  }


}