class MealSelectionData {

  final int subscriptionId;
  final int mealCategoryId;
  final bool isSaved;
  final String day;
  final List<int> mealIds;

  MealSelectionData({
    required this.subscriptionId,
    required this.mealCategoryId,
    required this.isSaved,
    required this.day,
    required this.mealIds,
  });

  Map toJson() => {
    'subscription_id': subscriptionId,
    'meal_category_id': mealCategoryId,
    'day': day,
    'meal_ids': mealIds,
  };

  Map toDateJson() => {
    'subscription_id': subscriptionId,
    'meal_category_id': mealCategoryId,
    'date': day,
    'meal_id': mealIds[0],
  };

}
