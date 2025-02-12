

import 'package:dietsteps/feature_modules/my_subscription/models/subscription_dailymeal_item.model.my_subscription.dart';

class SubscriptoinDailyMeal {
  final int id;
  final String name;
  final String arabicName;
  final int itemCount;
  final bool isAlreadySelected;
  final List<SubscriptoinDailyMealItem> items;

  SubscriptoinDailyMeal(
      {required this.name,
        required this.id,
        required this.arabicName,
        required this.items,
        required this.isAlreadySelected,
        required this.itemCount});
}

SubscriptoinDailyMeal mapSubscriptoinDailyMeal(dynamic payload) {
  print("mapSubscriptoinDailyMeal");
  print(payload);
  List<SubscriptoinDailyMealItem> items = [];
  int selectedCount = 0;

  if(payload["items"] != null && payload["items"] is! String ){
    payload["items"].forEach((element) {
      if(element != null){
        SubscriptoinDailyMealItem subscriptoinDailyMealItem =  mapSubscriptoinDailyMealItem(element);
        selectedCount +=subscriptoinDailyMealItem.selectedCount;
        items.add(subscriptoinDailyMealItem);
      }
    });
  }
  int itemCount =  payload["item_count"] ?? 0;


  return SubscriptoinDailyMeal(
      id: payload["id"] ?? -1,
      itemCount:itemCount,
      arabicName: payload["arabic_name"]!=null && payload["arabic_name"] != false?payload["arabic_name"] : "",
      name: payload["name"]!=null && payload["name"] != false?payload["name"] : "",
      items:items,
      isAlreadySelected: itemCount==selectedCount
  );
}
