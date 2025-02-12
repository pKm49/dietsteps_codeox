import 'package:dietsteps/feature_modules/auth/models/login_credential.model.auth.dart';
import 'package:dietsteps/feature_modules/auth/models/meal_item.model.auth.dart';
import 'package:dietsteps/feature_modules/auth/services/http.services.auth.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/models/general_item.model.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealsController extends GetxController {

  var isMealsLoading = false.obs;
  var mealCategories = <MealCategory>[].obs;
  var currentDay = "monday".obs;
  var currentMeal = mapMealItem({}).obs;



  Future<void> getMealsByDay(String day) async {
    if(  !isMealsLoading.value && day != ""){
      isMealsLoading.value = true;
      currentDay.value = day;
      currentMeal.value = mapMealItem({});
      mealCategories.value = [];
      var planPurchaseHttpService = new AuthHttpService();
      mealCategories.value =
      await planPurchaseHttpService.getMealsByDay(day);
      isMealsLoading.value = false;

    }
  }

  void viewMeal(MealItem mealItem) {
    if(mealItem.id != -1){
      currentMeal.value = mealItem;
      Get.toNamed(AppRouteNames.menuItemDetailsRoute);
    }
  }

}