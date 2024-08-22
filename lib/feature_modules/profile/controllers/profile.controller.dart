import 'package:dietsteps/feature_modules/profile/models/referral_data.profile.model.dart';
import 'package:dietsteps/feature_modules/profile/services/http.profile.service.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/available_genders.shared.constant.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/models/general_item.model.shared.dart';
import 'package:dietsteps/shared_module/models/user_data.model.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  Rx<TextEditingController> firstNameEnglishTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> lastNameEnglishTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> firstNameArabicTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> lastNameArabicTextEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> emailTextEditingController =
      TextEditingController().obs;

  var selectedDOB = DateTime
      .now()
      .obs;

  var gender = VALID_GENDERS.male.name.obs;
  Rx<TextEditingController> birthDayController = TextEditingController().obs;


  var profilePictureUrl = ASSETS_DEFAULTPROFILEPIC.obs;
  var isFileSelected = false.obs;
  var referralData = mapReferralData({}).obs;

  var isAllregyDislikeForRegisterComplete = false.obs;
  var isUserDataFetching = false.obs;
  var isRefferalDataFetching = false.obs;
  var userData = mapUserData({}).obs;
  var isProfileUpdating = false.obs;
  var isAllergiesFetching = false.obs;
  var isDislikesFetching = false.obs;
  var isAllergiesUpdating = false.obs;
  var isDislikesUpdating = false.obs;
  var isIngredientsFetching = false.obs;
  var ingredients = <GeneralItem>[].obs;
  var allergies = <GeneralItem>[].obs;
  var dislikes = <GeneralItem>[].obs;
  var ingredientsToShow = <GeneralItem>[].obs;

  void updateProfilePicture(String base64encode) {
    isFileSelected.value = true;
    profilePictureUrl.value = base64encode;
    update();
  }

  getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tMobile = prefs.getString('mobile');
    if (tMobile != null && tMobile != '') {
      isUserDataFetching.value = true;
      var profileHttpService = ProfileHttpService();
      userData.value = await profileHttpService.getProfileData(tMobile);
      isUserDataFetching.value = false;
      if (userData.value.id == -1) {
        showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
        showSnackbar(Get.context!, "login_message".tr, "error");
        Get.offAllNamed(AppRouteNames.loginRoute);
      } else {
        firstNameEnglishTextEditingController.value.text =
            userData.value.firstName;
        firstNameArabicTextEditingController.value.text =
            userData.value.firstNameArabic;
        lastNameEnglishTextEditingController.value.text =
            userData.value.lastName;
        lastNameArabicTextEditingController.value.text =
            userData.value.lastNameArabic;
        selectedDOB.value = userData.value.birthday==""?DateTime.now():getParsableDate(userData.value.birthday);
        birthDayController.value.text = userData.value.birthday;
        gender.value = userData.value.gender;
        emailTextEditingController.value.text = userData.value.email;
        profilePictureUrl.value = userData.value.profilePictureUrl;
      }
    } else {
      showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
      showSnackbar(Get.context!, "login_message".tr, "error");
      Get.offAllNamed(AppRouteNames.loginRoute);
    }
  }

  getParsableDate(payload) {
    List<String> dateItem = [];
    List<String> dateItems = [];
    List<String> dateItemsInt = [];
    dateItem = payload.toString().split(" ").toList() ;
    dateItems = dateItem[0].split("-").toList();
    dateItems.forEach((element) {
      if(int.parse(element)<10 && !element.startsWith("0")){
        dateItemsInt.add('0$element');
      }else{
        dateItemsInt.add(element);
      }
    });
    return DateTime.parse(dateItemsInt.join("-"));
  }
  updateProfile() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    final String? mobile = sharedPreferences.getString('mobile');

    if (mobile != null && mobile != "") {
      isProfileUpdating.value = true;
      var profileHttpService = new ProfileHttpService();
      String message = await profileHttpService.updateProfileData(
          UserData(
            id: userData.value.id,
            gender:  gender.value,
            height: userData.value.height,
            birthday: birthDayController.value.text,
            weight: userData.value.weight,
            subscriptionEndDate: userData.value.subscriptionEndDate,
            subscriptionNameArabic: userData.value.subscriptionNameArabic,
            subscriptionName: userData.value.subscriptionName,
            subscriptionRemainingDays: userData.value.subscriptionRemainingDays,
            mobile: userData.value.mobile,
            firstName: firstNameEnglishTextEditingController.value.text,
            firstNameArabic: firstNameArabicTextEditingController.value.text,
            lastName: lastNameEnglishTextEditingController.value.text,
            lastNameArabic: lastNameArabicTextEditingController.value.text,
            email: emailTextEditingController.value.text,
            customerCode: userData.value.customerCode,
            profilePictureUrl:
                isFileSelected.value ? profilePictureUrl.value : "",
              shift:""
          ),
          mobile);
      isProfileUpdating.value = false;

      if (message == "") {
        final sharedController = Get.find<SharedController>();
        sharedController.fetchUserData("", mobile);
        Get.back();
        showSnackbar(Get.context!, "profile_updated_successfully".tr, "info");

      } else {
        showSnackbar(Get.context!, message, "error");
      }
    } else {
      showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
      showSnackbar(Get.context!, "login_message".tr, "error");
      Get.offAllNamed(AppRouteNames.loginRoute);
    }
  }

  void changeDob(DateTime selectedDob) {
    selectedDOB.value = selectedDob;
    final f = new DateFormat('yyyy-MM-dd');
    birthDayController.value.text = f.format(selectedDob);
  }

  void changeGender(String s) {
    gender.value = s;
  }
  getRefferalData() async {
    if(! isRefferalDataFetching.value){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? tMobile = prefs.getString('mobile');
      if (tMobile != null && tMobile != '') {
        isRefferalDataFetching.value = true;
        var profileHttpService = ProfileHttpService();
        referralData.value = await profileHttpService.getRefferalData(tMobile);
        isRefferalDataFetching.value = false;
      }else {
        showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
        showSnackbar(Get.context!, "login_message".tr, "error");
        Get.offAllNamed(AppRouteNames.loginRoute);
      }

    }

  }

  getIngredients() async {

    if(! isIngredientsFetching.value && ingredients.isEmpty){
      isIngredientsFetching.value = true;
      var profileHttpService = ProfileHttpService();
      ingredients.value = await profileHttpService.getIngredients();
      ingredientsToShow.value = ingredients;

      isIngredientsFetching.value = false;
    }else{
      isIngredientsFetching.value = false;
    }
  }

  getAllergies() async {
    if(! isAllergiesFetching.value){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? tMobile = prefs.getString('mobile');
      if (tMobile != null && tMobile != '') {
        isAllergiesFetching.value = true;
        var profileHttpService = ProfileHttpService();
        allergies.value = await profileHttpService.getAllergies(tMobile);

        isAllergiesFetching.value = false;

      }else {
        showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
        showSnackbar(Get.context!, "login_message".tr, "error");
        Get.offAllNamed(AppRouteNames.loginRoute);
      }

    }

  }

  getDislikes() async {
    if(! isDislikesFetching .value){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? tMobile = prefs.getString('mobile');
      if (tMobile != null && tMobile != '') {
        isDislikesFetching.value = true;
        var profileHttpService = ProfileHttpService();
        dislikes.value = await profileHttpService.getDislikes(tMobile);
        isDislikesFetching.value = false;
      }else {
        showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
        showSnackbar(Get.context!, "login_message".tr, "error");
        Get.offAllNamed(AppRouteNames.loginRoute);
      }

    }

  }

  updateDislikes(bool isRegisterComplete) async {
    if(! isDislikesUpdating.value && dislikes.isNotEmpty){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? tMobile = prefs.getString('mobile');
      if (tMobile != null && tMobile != '') {
        isDislikesUpdating.value = true;
        var profileHttpService = ProfileHttpService();
        bool isSuccess = await profileHttpService.updateDislikes(dislikes,tMobile);
        isDislikesUpdating.value = false;
        if(isSuccess){
          if(isRegisterComplete){
            Get.toNamed(AppRouteNames.planPurchaseSubscriptionPlansCategoryListRoute);
          }else{
            Get.back();
          }
          showSnackbar(Get.context!, "dislikes_updated_successfully".tr, "info");
        }
      }else {
        showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
        showSnackbar(Get.context!, "login_message".tr, "error");
        Get.offAllNamed(AppRouteNames.loginRoute);
      }

    }

  }

  updateAllergies(bool isRegisterComplete) async {
    if(! isAllergiesUpdating.value && allergies.isNotEmpty){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? tMobile = prefs.getString('mobile');
      if (tMobile != null && tMobile != '') {
        isAllergiesUpdating.value = true;
        var profileHttpService = ProfileHttpService();
        bool isSuccess = await profileHttpService.updateAllergies(allergies,tMobile);
        isAllergiesUpdating.value = false;
        if(isSuccess){
          // if(isRegisterComplete){
          //   Get.toNamed(AppRouteNames.dislikeAuditRoute,arguments: [true]);
          // }else{
          //   Get.back();
          // }
          Get.back();
          showSnackbar(Get.context!, "allergies_updated_successfully".tr, "info");

        }
      }else {
        showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
        showSnackbar(Get.context!, "login_message".tr, "error");
        Get.offAllNamed(AppRouteNames.loginRoute);
      }

    }

  }

  Future<void> deleteAccount() async {
    print("deleteAccount clicked");
    var sharedPreferences = await SharedPreferences.getInstance();
    final String? mobile = sharedPreferences.getString('mobile');

    if (mobile != null && mobile != "") {
      var profileHttpService = new ProfileHttpService();
      bool isSuccess = await profileHttpService.deleteAccount(mobile);

      if (isSuccess) {
        showSnackbar(Get.context!, "account_delete_success_message".tr, "info");
        showSnackbar(Get.context!, "our_rep_will_contact".tr, "info");
      }
    }
  }

  void updateIngredientsListByQuery(String query) {
    if (query== "") {
      ingredientsToShow.value = ingredients;
    } else {
       List<GeneralItem> tIngredients = [];
       for (var element in ingredients) {
         if(element.name.toLowerCase().contains(query) ||
         element.arabicName.contains(query)){
           tIngredients.add(element);
         }
       }
       ingredientsToShow.value = tIngredients;
    }
  }

  void updateIngredientValues(GeneralItem ingredient) {
    if(dislikes.map((element) => element.id).toList().contains(ingredient.id)){
      List<GeneralItem> tAllergies = [];
      for (var element in dislikes) {
        if(element.id != ingredient.id){
          tAllergies.add(element);
        }
      }
      dislikes.value = tAllergies;
    }else{
      dislikes.add(ingredient);
    }
  }

  void updateAllergyValues(GeneralItem ingredient) {
    if(allergies.map((element) => element.id).toList().contains(ingredient.id)){
      List<GeneralItem> tAllergies = [];
      for (var element in allergies) {
        if(element.id != ingredient.id){
          tAllergies.add(element);
        }
      }
      allergies.value = tAllergies;
    }else{
      allergies.add(ingredient);
    }
  }

  void updateAllergyDislikePurpose(bool isRegisterComplete) {

    isAllregyDislikeForRegisterComplete.value = isRegisterComplete;
  }

}
