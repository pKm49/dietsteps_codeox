

import 'package:dietsteps/shared_module/constants/default_values.constants.shared.dart';

class SubscriptoinDate {
  final DateTime date;
  final String status;
  final int subscriptionId;

  SubscriptoinDate(
      {
        required this.date,
        required this.status,
        required this.subscriptionId
      });
}

SubscriptoinDate mapSubscriptoinDate(dynamic payload) {

  DateTime dateTime = payload["date"]!=null && payload["date"] != false?getParsableDate(payload["date"] ):  DefaultInvalidDate;

  return SubscriptoinDate(
    subscriptionId: payload["subscription_id"] ?? -1,
    status: payload["status"]!=null && payload["status"] != false?payload["status"] : "",
    date: dateTime
  );
}
getParsableDate(payload) {
  List<String> dateItem = [];
  List<String> dateItems = [];
  List<String> dateItemsInt = [];
  dateItem = payload.toString().split(" ").toList() ;
  dateItems = dateItem[0].split("-").toList();
  dateItems.forEach((element) {
    if(int.parse(element)<10 && !element.startsWith("0")){
      dateItemsInt.add('0$element');
    }else{
      dateItemsInt.add(element);
    }
  });
  DateTime dateTime = DateTime.parse(dateItemsInt.join("-"));
  return DateTime(dateTime.year,dateTime.month,dateTime.day,4,30,00);
}