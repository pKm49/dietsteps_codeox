class SubscriptionPlan {
  final int id;
  final String name;
  final String arabicName;
  final String durationType;
  final String durationTypeArabic;
  final String days;
  final String offerText;
  final double price;
  final double strikePrice;
  final double protein;
  final double carbohydrates;
  Map<int, bool> dayAvailability;
  final List<String> mealsConfig;
  final List<String> mealsConfigArabic;

  SubscriptionPlan(
      {required this.id,
      required this.price,
      required this.name,
      required this.arabicName,
      required this.durationTypeArabic,
      required this.offerText,
      required this.strikePrice,
      required this.days,
      required this.durationType,
      required this.carbohydrates,
      required this.protein,
      required this.dayAvailability,
      required this.mealsConfig,
      required this.mealsConfigArabic});
}

SubscriptionPlan mapSubscriptionItem(dynamic payload) {
  List<String> mealConfig = [];
  List<String> mealsConfigArabic = [];

  if (payload["meal_configuration"] != null &&
      payload["meal_configuration"] is! String) {
    payload["meal_configuration"].forEach((element) {
      if (element != null) {
        mealConfig.add(element);
      }
    });
  }

  if (payload["meal_configuration_arabic"] != null &&
      payload["meal_configuration_arabic"] is! String) {
    payload["meal_configuration_arabic"].forEach((element) {
      if (element != null) {
        mealsConfigArabic.add(element);
      }
    });
  }
  Map<int, bool> dayAvailability = {};
  if (payload["available_days"] != null) {
    if (payload["available_days"]["sunday"] != null) {
      dayAvailability[7] = payload["available_days"]["sunday"];
    } else {
      dayAvailability[7] = false;
    }
    if (payload["available_days"]["monday"] != null) {
      dayAvailability[1] = payload["available_days"]["monday"];
    } else {
      dayAvailability[1] = false;
    }
    if (payload["available_days"]["tuesday"] != null) {
      dayAvailability[2] = payload["available_days"]["tuesday"];
    } else {
      dayAvailability[2] = false;
    }
    if (payload["available_days"]["wednesday"] != null) {
      dayAvailability[3] = payload["available_days"]["wednesday"];
    } else {
      dayAvailability[3] = false;
    }
    if (payload["available_days"]["thursday"] != null) {
      dayAvailability[4] = payload["available_days"]["thursday"];
    } else {
      dayAvailability[4] = false;
    }
    if (payload["available_days"]["friday"] != null) {
      dayAvailability[5] = payload["available_days"]["friday"];
    } else {
      dayAvailability[5] = false;
    }
    if (payload["available_days"]["saturday"] != null) {
      dayAvailability[6] = payload["available_days"]["saturday"];
    } else {
      dayAvailability[6] = false;
    }
  }
  return SubscriptionPlan(
      dayAvailability: dayAvailability,
      id: payload["id"] ?? -1,
      price: payload["price"] ?? 0.0,
      protein: payload["protein"] ?? 0.0,
      carbohydrates: payload["carbohydrates"] ?? 0.0,
      strikePrice:
          (payload["strike_price"] != "" && payload["strike_price"] != null)
              ? payload["strike_price"]
              : 0.0,
      name: payload["name"] != null && payload["name"] != false
          ? payload["name"]
          : "",
      arabicName:
          payload["arabic_name"] != null && payload["arabic_name"] != false
              ? payload["arabic_name"]
              : "",
      durationType: payload["duration_type"] ?? "Week",
      durationTypeArabic: payload["duration_type_arabic"] ?? "Week",
      days: payload["days_count"] != null
          ? payload["days_count"].toString()
          : "0",
      offerText:
          payload["days_count"] != null ? payload["days_count"].toString() : "",
      mealsConfig: mealConfig,
      mealsConfigArabic: mealsConfigArabic);
}
//
// SubscriptionPlan mapMySubscriptionItem(dynamic payload){
//
//   return SubscriptionPlan(
//     id :payload["plan_id"]??-1,
//     subscriptionId :payload["subscription_id"]??-1,
//     snacksCount :payload["snacks_count"]??0,
//     mealsCount :payload["meals_count"]??0,
//     price :payload["price"]??0.0,
//     name :payload["plan_name"]??"",
//     arabicName :payload["plan_arabic_name"] !=null?payload["plan_arabic_name"].toString():"",
//     duration_type :payload["plan_category_name"]??"",
//     categoryId :payload["plan_category_id"]??-1,
//     categoryArabicName :payload["plan_category_arabic_name"] !=null?payload["arabic_name"].toString():"",
//     days :payload["plan_duration"]??0,
//   );
//
// }
