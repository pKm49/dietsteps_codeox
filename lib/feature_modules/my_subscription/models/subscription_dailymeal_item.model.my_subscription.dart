

import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';

class SubscriptoinDailyMealItem {
  final int id;
  final String name;
  final String arabicName;
  final String description;
  final String arabicDescription;
  final String image;
  final double calories;
  final double carbs;
  final double fat;
  final double protien;
  final int ratingCount;
  final int rating;
  final bool isSelected;
  final bool isDislike;
  final int selectedCount;
  final List<MealIngredient> ingredients;

  SubscriptoinDailyMealItem(
      {
        required this.ingredients,

        required this.id,
        required this.name,
        required this.arabicName,
        required this.description,
        required this.arabicDescription,
        required this.calories,
        required this.isSelected,
        required this.image,
        required this.carbs,
        required this.fat,
        required this.protien,
        required this.rating,
        required this.ratingCount,
        required this.isDislike,
        required this.selectedCount,
      });
}

SubscriptoinDailyMealItem mapSubscriptoinDailyMealItem(dynamic payload) {
  print("mapSubscriptoinDailyMealItem");
  print(payload);


  List<MealIngredient> ingredients = [];

  if(payload["ingredients"] != null && payload["ingredients"] is! String ){
    payload["ingredients"].forEach((element) {
      if(element != null){
        ingredients.add(mapMealIngredient(element));
      }
    });
  }

  return SubscriptoinDailyMealItem(
    id: payload["id"] ?? -1,
    ingredients:ingredients,

    arabicName: payload["arabic_name"]!=null && payload["arabic_name"] != false?payload["arabic_name"] : "",
    name: payload["name"]!=null && payload["name"] != false?payload["name"] : "",
    description: payload["description"]!=null && payload["description"] != false?payload["description"] : "",
    arabicDescription: payload["arabic_description"]!=null && payload["arabic_description"] != false?payload["arabic_description"] : "",

    calories: payload["calories"] ?? 0.0,
    carbs: payload["carbs"] ?? 0.0,
    fat: payload["fat"] ?? 0.0,
    protien: payload["protein"] ?? 0.0,
    rating :payload["rating"] !=null?payload["rating"].round():0,
    ratingCount :payload["rating_count"] ?? 0,
    selectedCount: payload["selected_count"] ?? 0,
    isSelected: payload["is_selected"] ?? false,
    isDislike: payload["is_dislike"] ?? false,
    image :payload["image"]!= null && payload["image"]!= ""?payload["image"].toString():ASSETS_SAMPLEFOOD,

  );
}

class MealIngredient {

  final String imageUrl;
  final String name;
  final String arabicName;

  MealIngredient({
    required this.imageUrl,
    required this.name,
    required this.arabicName,
  });


}

MealIngredient mapMealIngredient(dynamic payload){

  print("mapMealIngredient");
  print(payload);
  if( payload is String){
    return MealIngredient(
        imageUrl : ASSETS_SAMPLEFOOD,
        name :payload ,
        arabicName :payload
    );
  }else{
    return MealIngredient(
        imageUrl :payload["image"]!= null && payload["image"]!= ""?payload["image"].toString():ASSETS_SAMPLEFOOD,
        name :payload["name"]!= null && payload["name"]!= false?payload["name"] :"",
        arabicName :payload["arabic_name"]!= null && payload["arabic_name"]!= false?payload["arabic_name"] :""
    );
  }

}
