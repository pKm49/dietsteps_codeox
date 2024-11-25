
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';

class MealCategory {

  final int id;
  final String name;
  final String arabicName;
  final List<MealItem> meals;

  MealCategory({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.meals,
  });

}

MealCategory mapMealCategory(dynamic payload){

  List<MealItem> meals = [];

  if(payload["items"] != null && payload["items"] is! String ){
    payload["items"].forEach((element) {
      if(element != null){
        meals.add(mapMealItem(element));
      }
    });
  }

  return MealCategory(
      id :payload["id"]??-1,
      name :payload["name"]!= null && payload["name"]!= false?payload["name"] :"",
      arabicName :payload["arabic_name"]!= null && payload["arabic_name"]!= false?payload["arabic_name"] :"",
      meals:meals
  );
}




class MealItem {

  final int id;
  final String imageUrl;
  final String tags;
  final String name;
  final String description;
  final String arabicName;
  final String arabicDescription;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double rating;
  final int rating_count;
  final double price;
  final List<MealIngredient> ingredients;

  MealItem({
    required this.id,
    required this.imageUrl,
    required this.tags,
    required this.name,
    required this.arabicName,
    required this.description,
    required this.arabicDescription,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.rating,
    required this.rating_count,
    required this.price,
    required this.ingredients,
  });


}

MealItem mapMealItem(dynamic payload){

  List<MealIngredient> ingredients = [];

  if(payload["ingredients"] != null && payload["ingredients"] is! String ){
    payload["ingredients"].forEach((element) {
      if(element != null){
        ingredients.add(mapMealIngredient(element));
      }
    });
  }

  return MealItem(
    id :payload["id"]??-1,
    tags :payload["tags"]!= null?payload["tags"].toString():"",
    imageUrl :payload["image"]!= null?payload["image"].toString():ASSETS_SAMPLEFOOD,
    name :payload["name"]!= null && payload["name"]!= false?payload["name"] :"",
    arabicName :payload["arabic_name"]!= null && payload["arabic_name"]!= false?payload["arabic_name"] :"",
    description :payload["description"]!= null && payload["description"]!= false?payload["description"] :"",
    arabicDescription :payload["arabic_description"]!= null && payload["arabic_description"]!= false?payload["arabic_description"] :"",
    calories :payload["calories"]??0.0,
    protein :payload["protein"]??0.0,
    carbs :payload["carbs"]??0.0,
    fat :payload["fat"]??0.0,

      price :payload["price"] !=null?double.parse(payload["price"].toString()):0.0,
      rating :payload["rating"] !=null?double.parse(payload["rating"].toString()):0.0,
    rating_count :payload["rating_count"] !=null?int.parse(payload["rating_count"].toString()):0,
    ingredients:ingredients
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

  return MealIngredient(
      imageUrl :payload["image"]!= null && payload["image"]!= ""?payload["image"].toString():ASSETS_SAMPLEFOOD,
      name :payload["name"]!= null && payload["name"]!= false?payload["name"] :"",
      arabicName :payload["arabic_name"]!= null && payload["arabic_name"]!= false?payload["arabic_name"] :""
  );
}
