import 'package:intl/intl.dart';

class AppNotification {
  final String message;
  final String title;
  final DateTime dateTime;
  final String image;

  AppNotification({
    required this.message,
    required this.image,
    required this.title,
    required this.dateTime,
  });
  Map toJson() {
    return {
      "firstname": message,
      "title": title,
      "image": image,
      "dateTime": convertBirthDay(dateTime)
    };
  }
}

String convertBirthDay(DateTime birthDay) {
  final f = new DateFormat('yyyy-MM-dd');
  return f.format(birthDay);
}

AppNotification mapAppNotification(dynamic payload) {
  DateTime dateTime = DateTime.now();
  try {
    dateTime = payload["datetime"] != null
        ? getParsableDate(payload["datetime"])
        : DateTime(1900, 1, 1);
  } catch (e) {
    dateTime = DateTime(1900, 1, 1);
  }

  return AppNotification(
    dateTime: dateTime,
    message: payload["message"] != null ? payload["message"].toString() : "",
    title: payload["title"] != null ? payload["title"].toString() : "",
    image: payload["image"] != null ? payload["image"].toString() : "",
  );
}

DateTime getParsableDate(String payload) {
  try {
    // Ensure proper format with two-digit seconds
    List<String> parts = payload.split(" ");
    if (parts.length < 2) return DateTime(1900, 1, 1);

    String datePart = parts[0]; // "2025-01-29"
    String timePart = parts[1]; // "04:35:2"

    // Ensure HH:mm:ss format
    List<String> timeParts = timePart.split(":");
    while (timeParts.length < 3) {
      timeParts.add("00"); // Fill missing seconds
    }
    if (timeParts[2].length == 1) {
      timeParts[2] = "0${timeParts[2]}"; // Ensure two-digit seconds
    }

    String formattedDateTime = "$datePart ${timeParts.join(":")}";
    return DateTime.parse(formattedDateTime);
  } catch (e) {
    return DateTime(1900, 1, 1); // Fallback if parsing fails
  }
}
