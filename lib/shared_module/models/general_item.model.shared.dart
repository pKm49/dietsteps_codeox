import 'package:flutter/material.dart';

class GeneralItem {

  final int id;
  final String name;
  final String arabicName;

  GeneralItem.GeneralItem({
    required this.id,
    required this.name,
    required this.arabicName,
  });

  Map toJson() => {
    'id': id,
    'name': name,
    'arabicName': arabicName,
  };

}

GeneralItem mapGeneralItem(dynamic payload){

  return GeneralItem.GeneralItem(
    id :payload["id"]??payload["meal_category_id"]??-1,
    name :payload["name"]??payload["meal_category_name"]??"",
    arabicName :payload["arabic_name"] != null?payload["arabic_name"].toString():
    payload["meal_category_arabic_name"] != null?payload["meal_category_arabic_name"].toString():"",
  );
}
