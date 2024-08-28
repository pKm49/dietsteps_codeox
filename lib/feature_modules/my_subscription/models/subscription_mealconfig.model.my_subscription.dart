

 import 'package:dietsteps/feature_modules/my_subscription/models/subscription_dailymeal.model.my_subscription.dart';

class SubscriptoinMealConfig {

  final String date;
  final double recommendedCalories;
  final List<SubscriptoinDailyMeal> meals;

  SubscriptoinMealConfig(
      {required this.date,
        required this.recommendedCalories,
        required this.meals  });
}

SubscriptoinMealConfig mapSubscriptoinMealConfig(dynamic payload, String date) {
  print("mapSubscriptoinMealConfig");
  print(payload);
  List<SubscriptoinDailyMeal> meals = [];

  if(payload["meals"] != null && payload["meals"] is! String ){
    payload["meals"].forEach((element) {
      if(element != null){
        print(element["item_count"]);
        if(element["item_count"] != null){
          if(element["item_count"] > 0){
            meals.add(mapSubscriptoinDailyMeal(element));
          }
        }
      }
    });
  }

  return SubscriptoinMealConfig(
    recommendedCalories: payload["subscription_recommended_calories"] ?? 0.0,
    date: payload["state"] ?? "",
    meals: meals,

  );
}


 List<Map<String, List<int>>> mapSubscriptoinMealConfigForSubmit(SubscriptoinMealConfig subscriptoinMealConfig) {
   List<Map<String, List<int>>> mealConfigList = [];
   Map<String, List<int>> mealConfig = {};

   for (var element in subscriptoinMealConfig.meals) {
     mealConfig.addAll({element.id.toString():  element.items.map((e) => e.id).toList()});
   }
   mealConfigList.add(mealConfig);
   return mealConfigList;

 }