import 'package:flutter/material.dart';

class GeneralItem {

  final int id;
  final String name;
  final String arabicName;
  final String deliveryTime;

  GeneralItem.GeneralItem({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.deliveryTime,
  });

  Map toJson() => {
    'id': id,
    'name': name,
    'arabicName': arabicName,
    'deliveryTime': deliveryTime,
  };

}

GeneralItem mapGeneralItem(dynamic payload){

  return GeneralItem.GeneralItem(
    id :payload["id"]??payload["meal_category_id"]??-1,
    deliveryTime :payload["delivery_time"]!=null && payload["delivery_time"] != false ?payload["delivery_time"]:"",
    name: payload["name"]!=null && payload["name"] != false?payload["name"]
        : payload["meal_category_name"]!=null && payload["meal_category_name"] != false?payload["meal_category_name"]:"",
    arabicName: payload["arabic_name"]!=null && payload["arabic_name"] != false?payload["arabic_name"] :
    payload["meal_category_arabic_name"] != null && payload["meal_category_arabic_name"] != false ?
    payload["meal_category_arabic_name"].toString():"",
  );
}
