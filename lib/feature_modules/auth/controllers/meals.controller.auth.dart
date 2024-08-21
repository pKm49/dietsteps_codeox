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
  
  var isCategoriesFetching = false.obs;
  var isMealsLoading = false.obs;
  var mealCategories = <GeneralItem>[].obs;
  var meals = <MealItem>[].obs;
  var currentMealCategoryId = (-1).obs;
  var currentMeal = mapMealItem({}).obs;

  Future<void> getMealCategories() async {
    if(!isCategoriesFetching.value && !isMealsLoading.value){
      isCategoriesFetching.value = true;
      isMealsLoading.value = true;
      mealCategories.value = [];
      var planPurchaseHttpService = new AuthHttpService();
      mealCategories.value =
      await planPurchaseHttpService.getMealCategories();
      isCategoriesFetching.value = false;
      isMealsLoading.value = false;
      currentMealCategoryId.value = -1;
      update();
      if (mealCategories.isEmpty) {
        currentMeal.value = mapMealItem({});
        meals.value = [];
      }else{
        getMealsByCategory(mealCategories[0].id);
      }
    }

  }

  Future<void> getMealsByCategory(int categoryId) async {
    if(!isCategoriesFetching.value && !isMealsLoading.value && categoryId !=-1){
      isMealsLoading.value = true;
      currentMealCategoryId.value = categoryId;
      currentMeal.value = mapMealItem({});
      meals.value = [];
      var planPurchaseHttpService = new AuthHttpService();
      meals.value =
      await planPurchaseHttpService.getMealsByCategory(categoryId);
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