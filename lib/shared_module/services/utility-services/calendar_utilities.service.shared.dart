import 'package:get/get.dart';

String getDayNameByIndex(int i) {
  switch (i) {

    case 1:
      return "mon".tr;
    case 2:
      return "tue".tr;
    case 3:
      return "wed".tr;
    case 4:
      return "thu".tr;
    case 5:
      return "fri".tr;
    case 6:
      return "sat".tr;
    case 7:
      return "sun".tr;
    default:
      return "";
  }
}

String getDayNameByDate(DateTime dateTime) {
  int i = dateTime.weekday;

  switch (i) {

    case 1:
      return "mon".tr;
    case 2:
      return "tue".tr;
    case 3:
      return "wed".tr;
    case 4:
      return "thu".tr;
    case 5:
      return "fri".tr;
    case 6:
      return "sat".tr;
    case 7:
      return "sun".tr;
    default:
      return "";
  }


}

String getDayByIndex(int i) {
  switch (i) {

    case 1:
      return "monday";
    case 2:
      return "tuesday";
    case 3:
      return "wednesday";
    case 4:
      return "thursday";
    case 5:
      return "friday";
    case 6:
      return "saturday";
    case 7:
      return "sunday";
    default:
      return "";
  }
}