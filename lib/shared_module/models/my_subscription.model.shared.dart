
class MySubscription {
  final int id;
  final String planName;
  final String planArabicName;
  final String status;
  final DateTime fromDate;
  final DateTime toDate;
  final List<MySubscriptionMealConfig> mealsConfig;

  MySubscription(
      {required this.id,
        required this.status,
        required this.planName,
        required this.planArabicName,
        required this.fromDate,
        required this.toDate,
        required this.mealsConfig, });
}

MySubscription mapMySubscription(dynamic payload) {

  List<MySubscriptionMealConfig> mealsConfig = [];

  if(payload["meals_config"] != null && payload["meals_config"] is! String ){
    payload["meals_config"].forEach((element) {
      if(element != null){
        mealsConfig.add(mapMySubscriptionMealConfig(element));
      }
    });
  }


  return MySubscription(
    id: payload["id"] ?? -1,
    status: payload["state"]!=null && payload["state"] != false?payload["state"] : "",
    planName: payload["plan"]!=null && payload["plan"] != false?payload["plan"] : "",
    planArabicName: payload["plan_arabic"]!=null && payload["plan_arabic"] != false?payload["plan_arabic"] : "",
    fromDate: payload["start_date"] != null
        ? DateTime.parse(payload["start_date"].toString())
        : DateTime.now(),
    toDate: payload["end_date"] != null
        ? DateTime.parse(payload["end_date"].toString())
        : DateTime.now(),
    mealsConfig: mealsConfig,

  );
}

class MySubscriptionMealConfig {
  final String name;
  final String arabicName;
  final int itemCount;

  MySubscriptionMealConfig(
      {required this.name,
        required this.arabicName,
        required this.itemCount});
}

MySubscriptionMealConfig mapMySubscriptionMealConfig(dynamic payload) {

  return MySubscriptionMealConfig(
    itemCount: payload["item_count"] ?? 0,
    arabicName: payload["arabic_name"] ?? "",
    name: payload["name"] ?? "",
  );
}
