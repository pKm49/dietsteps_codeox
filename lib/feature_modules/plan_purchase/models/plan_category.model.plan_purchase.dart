enum DurationType {
  day,
  week,
  month,
}

DurationType parseDurationType(String value) {
  switch (value.toLowerCase()) {
    case 'day':
      return DurationType.day;
    case 'week':
      return DurationType.week;
    case 'month':
      return DurationType.month;
    default:
      return DurationType.day;
  }
}

class SubscriptionPlanCategory {
  int id;
  String name;
  String arabicName;
  String description;
  String arabicDescription;
  int protein;
  int carbs;
  int calories;
  String imageUrl;
  List<String> mealsConfig;
  List<String> mealsConfigArabic;
  bool isCustomisable;
  List<CustomisableConfig> customisableConfig;
  List<ChoiceConfig> choiceConfig;

  SubscriptionPlanCategory({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.description,
    required this.arabicDescription,
    required this.protein,
    required this.carbs,
    required this.calories,
    required this.imageUrl,
    required this.mealsConfig,
    required this.mealsConfigArabic,
    required this.isCustomisable,
    required this.customisableConfig,
    required this.choiceConfig,
  });

  factory SubscriptionPlanCategory.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlanCategory(
      id: json["id"] ?? -1,
      name: json["name"] ?? '',
      arabicName: json["arabic_name"] ?? '',
      description: json["description"] ?? '',
      arabicDescription: json["arabic_description"] ?? '',
      protein: (json["protein"] ?? 0).toInt(),
      carbs: (json["carbs"] ?? 0).toInt(),
      calories: (json["calories"] ?? 0).toInt(),
      imageUrl: json["image"] ?? '',
      mealsConfig: (json["meal_configuration"] as List?)
              ?.map((x) => x.toString())
              .toList() ??
          [],
      mealsConfigArabic: (json["meal_configuration_arabic"] as List?)
              ?.map((x) => x.toString())
              .toList() ??
          [],
      isCustomisable: json["is_customisable"] ?? false,
      customisableConfig: (json["customisable_config"] as List?)
              ?.map((x) => CustomisableConfig.fromJson(x))
              .toList() ??
          [],
      choiceConfig: (json["choice_config"] as List?)
              ?.map((x) => ChoiceConfig.fromJson(x))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "arabic_name": arabicName,
        "description": description,
        "arabic_description": arabicDescription,
        "protein": protein,
        "carbs": carbs,
        "calories": calories,
        "image": imageUrl,
        "meal_configuration": mealsConfig,
        "meal_configuration_arabic": mealsConfigArabic,
        "is_customisable": isCustomisable,
        "customisable_config":
            customisableConfig.map((x) => x.toJson()).toList(),
        "choice_config": choiceConfig.map((x) => x.toJson()).toList(),
      };
}

class CustomisableConfig {
  final int categoryId;
  final String categoryName;
  final String categoryArabicName;
  final bool isCustomisable;
  final double additionalPrice;
  final int count;
  final int carbLowLimit;
  final int carbHighLimit;
  final int carbStepValue;
  final int proteinLowLimit;
  final int proteinHighLimit;
  final int proteinStepValue;

  CustomisableConfig({
    required this.categoryId,
    required this.categoryName,
    required this.categoryArabicName,
    required this.isCustomisable,
    required this.additionalPrice,
    required this.count,
    required this.carbLowLimit,
    required this.carbHighLimit,
    required this.carbStepValue,
    required this.proteinLowLimit,
    required this.proteinHighLimit,
    required this.proteinStepValue,
  });

  factory CustomisableConfig.fromJson(Map<String, dynamic> json) {
    return CustomisableConfig(
      categoryId: json['category_id'] ?? -1,
      categoryName: json['category_name'] ?? '',
      categoryArabicName: json['arabic_category_name'] ?? '',
      isCustomisable: json['is_customisable'] ?? false,
      additionalPrice: (json['one_day_price'] ?? 0).toDouble(),
      count: (json['count'] ?? 0).toInt(),
      carbLowLimit: (json['carb_low_limit'] ?? 0).toInt(),
      carbHighLimit: (json['carb_high_limit'] ?? 0).toInt(),
      carbStepValue: (json['carb_step_value'] ?? 0).toInt(),
      proteinLowLimit: (json['protein_low_limit'] ?? 0).toInt(),
      proteinHighLimit: (json['protein_high_limit'] ?? 0).toInt(),
      proteinStepValue: (json['protein_step_value'] ?? 0).toInt(),
    );
  }

  Map<String, dynamic> toJson() => {
        'category_id': categoryId,
        'category_name': categoryName,
        'arabic_category_name': categoryArabicName,
        'is_customisable': isCustomisable,
        'additional_price': additionalPrice,
        'count': count,
        'carb_low_limit': carbLowLimit,
        'carb_high_limit': carbHighLimit,
        'carb_step_value': carbStepValue,
        'protein_low_limit': proteinLowLimit,
        'protein_high_limit': proteinHighLimit,
        'protein_step_value': proteinStepValue,
      };
}

class ChoiceConfig {
  bool isCustomisable;
  int id;
  String name;
  String arabicName;
  int daysCount;
  DurationType durationType;
  double price;

  ChoiceConfig({
    required this.isCustomisable,
    required this.id,
    required this.name,
    required this.arabicName,
    required this.daysCount,
    required this.durationType,
    required this.price,
  });

  factory ChoiceConfig.fromJson(Map<String, dynamic> json) => ChoiceConfig(
        isCustomisable: json["is_customisable"] ?? false,
        id: json["id"] ?? -1,
        name: json["name"] ?? '',
        arabicName: json["arabic_name"] ?? '',
        daysCount: json["days_count"] ?? 0,
        durationType: parseDurationType(json["duration_type"] ?? "day"),
        price: (json["price"] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "is_customisable": isCustomisable,
        "id": id,
        "name": name,
        "arabic_name": arabicName,
        "days_count": daysCount,
        "duration_type": durationType.name,
        "price": price,
      };
}

/// Custom mapping function
SubscriptionPlanCategory mapSubscriptionCategory(dynamic payload) {
  List<String> mealConfig = [];
  List<String> mealsConfigArabic = [];

  if (payload["meal_configuration"] is List) {
    mealConfig = List<String>.from(
        payload["meal_configuration"].map((e) => e.toString()));
  }

  if (payload["meal_configuration_arabic"] is List) {
    mealsConfigArabic = List<String>.from(
        payload["meal_configuration_arabic"].map((e) => e.toString()));
  }

  List<CustomisableConfig> customisableConfig = [];
  if (payload["customisable_config"] is List) {
    customisableConfig = (payload["customisable_config"] as List)
        .map((e) => CustomisableConfig.fromJson(e))
        .toList();
  }

  List<ChoiceConfig> choiceConfig = [];
  if (payload["choice_config"] is List) {
    choiceConfig = (payload["choice_config"] as List)
        .map((e) => ChoiceConfig.fromJson(e))
        .toList();
  }

  return SubscriptionPlanCategory(
    id: payload["id"] ?? -1,
    name: payload["name"]?.toString() ?? '',
    arabicName: payload["name_arabic"]?.toString() ?? '',
    description: payload["description"]?.toString() ?? '',
    arabicDescription: payload["arabic_description"]?.toString() ?? '',
    protein: (payload["protein"] ?? 0).toInt(),
    carbs: (payload["carbs"] ?? 0).toInt(),
    calories: (payload["calories"] ?? 0).toInt(),
    imageUrl: payload["image"]?.toString() ?? '',
    mealsConfig: mealConfig,
    mealsConfigArabic: mealsConfigArabic,
    isCustomisable: payload["is_customisable"] ?? false,
    customisableConfig: customisableConfig,
    choiceConfig: choiceConfig,
  );
}
