
import 'package:intl/intl.dart';

String getFormattedDate(DateTime dateTime) {
  String formattedDate = DateFormat('EEEE, dd MMMM, yyyy').format(dateTime);
  return formattedDate;
}
String getFormattedDateTime(DateTime dateTime) {
  String formattedDate = DateFormat('EEEE, dd MMMM, yyyy - hh:mm a').format(dateTime);
  return formattedDate;
}

String getFormattedSubscriptionDuration(DateTime startDateTime,DateTime endDateTime) {
  String formattedStartDate = DateFormat('dd MMMM, yyyy').format(startDateTime);
  String formattedEndDate = DateFormat('dd MMMM, yyyy').format(endDateTime);
  return formattedStartDate+" - " +formattedEndDate;
}

String getFormattedCurrentMonth(DateTime currentMonth ) {
  String formattedDate = DateFormat('MMMM yyyy').format(currentMonth);
  return formattedDate;
}

bool isSameDay(DateTime date1, DateTime date2) {
  if (date1.year == date2.year && date1.month == date2.month &&
      date1.day == date2.day) {
    return true;
  } else {
    return false;
  }
}
