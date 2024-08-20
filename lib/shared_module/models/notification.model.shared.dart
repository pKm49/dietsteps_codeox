import 'package:intl/intl.dart'; 
class AppNotification {

  final String message;
  final DateTime dateTime;

  AppNotification(
      {
        required this.message,
        required this.dateTime,
      });
  Map toJson(){
    return {
      "firstname": message,
      "dateTime": convertBirthDay(dateTime)
    };
  }
}

String convertBirthDay(DateTime birthDay) {
  final f = new DateFormat('yyyy-MM-dd');
  return f.format(birthDay);
}

AppNotification mapAppNotification(dynamic payload) {
  print("payload");
  print(payload);
  DateTime dateTime = DateTime.now();
  try {
    dateTime = payload["datetime"] != null
        ?getParsableDate(payload["datetime"])
        : DateTime(1900,1,1);
  } catch (e) {
    print("mapNotification error");
    print(e);
    dateTime = DateTime(1900,1,1);
  }

  return AppNotification(
    dateTime: dateTime,
    message: payload["message"] != null ? payload["message"].toString() : "",

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
  return DateTime.parse(dateItemsInt.join("-"));
}
