import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/calendar_utilities.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../controller/my_subscription.controller.dart';

String getCalendarDayText(int index) {
  if (index < 7) {
    return getDayNameByIndex(index);
  }
  if (index == 7) {
    return "31";
  }
  if (index < 39) {
    if ((index - 7) < 10) {
      return '0${(index - 7).toString()}';
    }
    return (index - 7).toString();
  }
  if ((index - 38) < 10) {
    return '0${(index - 38).toString()}';
  }
  return (index - 38).toString();
}

getCalendarDayTextColor(int index) {
  if (index < 7) {
    return APPSTYLE_Black;
  }
  if (index == 7) {
    return APPSTYLE_Grey40;
  }
  if (index > 38) {
    return APPSTYLE_Grey40;
  }
  return APPSTYLE_PrimaryColorBg;
}

getProductImage(image) {
  return (image == ASSETS_SAMPLEFOOD)
      ? AssetImage(ASSETS_SAMPLEFOOD)
      : NetworkImage(image);
}


int getPercentage(
    double recommendedCalories, double currentSelectedCalories2) {
  if (recommendedCalories == 0.0) {
    return 0;
  }
  double percentage = (currentSelectedCalories2 * 100) / recommendedCalories;
  if (percentage > 100) {
    return 100;
  }
  if (percentage < 0) {
    return percentage.round() * -1;
  }
  return percentage.round();
}

bool isTodayTomorrow(DateTime dateTime) {
  // Get access to the MySubscriptionController to use buffer time values
  final mySubscriptionController = Get.find<MySubscriptionController>();

  // Initialize Kuwait timezone
  tz.initializeTimeZones();
  final kuwaitTimeZone = tz.getLocation('Asia/Kuwait');
  final nowInKuwait = tz.TZDateTime.now(kuwaitTimeZone);

  // Convert all times to Kuwait timezone
  DateTime checkDateTime = tz.TZDateTime(
      kuwaitTimeZone,
      dateTime.year,
      dateTime.month,
      dateTime.day,
      4,
      30,
      00
  );

  DateTime todayDateStartTimeDate = tz.TZDateTime(
      kuwaitTimeZone,
      nowInKuwait.year,
      nowInKuwait.month,
      nowInKuwait.day,
      4,
      30,
      00
  );

  // Check if today is Wednesday (where 3 is Wednesday in DateTime.weekday)
  bool isWednesday = nowInKuwait.weekday == 2;

  // Get buffer hours from controller instead of hardcoded values
  int beforeFourThirtyHours = isWednesday
      ? (mySubscriptionController.bufferBeforeFourThirtyWednesday ?? 72)
      : (mySubscriptionController.bufferBeforeFourThirty ?? 48);

  int afterFourThirtyHours = isWednesday
      ? (mySubscriptionController.bufferAfterFourThirtyWednesday ?? 96)
      : (mySubscriptionController.bufferAfterFourThirty ?? 72);

  // Set durations based on buffer hours from controller
  Duration twoDaysDuration = Duration(hours: beforeFourThirtyHours);
  Duration threeDaysDuration = Duration(hours: afterFourThirtyHours);

  DateTime futureDate1 = todayDateStartTimeDate.add(twoDaysDuration);
  DateTime futureDate2 = todayDateStartTimeDate.add(threeDaysDuration);

  if (nowInKuwait.isBefore(todayDateStartTimeDate)) {
    return checkDateTime.isBefore(futureDate1);
  } else {
    return checkDateTime.isBefore(futureDate2);
  }
}
