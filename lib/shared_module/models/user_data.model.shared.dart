
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:intl/intl.dart';

class UserData {
  final int id;
  final String customerCode;
  final String firstName;
  final String lastName;
  final String firstNameArabic;
  final String lastNameArabic;
  final String gender;
  final double height;
  final double weight;
  final String birthday;
  final String mobile;
  final String email;
  final String  profilePictureUrl;
  final String subscriptionRemainingDays;
  final String subscriptionEndDate;
  final String subscriptionName;
  final String subscriptionNameArabic;
  final String shift;


  UserData(
      {required this.id,
        required this.firstName,
        required this.shift,
        required this.lastName,
        required this.firstNameArabic,
        required this.lastNameArabic,
        required this.profilePictureUrl,
        required this.mobile,
        required this.customerCode,
        required this.email,
        required this.gender,
        required this.birthday,
        required this.height,
        required this.weight,
        required this.subscriptionEndDate,
        required this.subscriptionName,
        required this.subscriptionNameArabic,
        required this.subscriptionRemainingDays });

  Map toJson(){
    return profilePictureUrl==""? {
      "first_name": firstName,
      "last_name": lastName,
      "first_name_arabic": firstNameArabic,
      "last_name_arabic": lastNameArabic,
      "mobile": mobile,
      "email": email,
      "date_of_birth": birthday,
      "gender": gender,
    }:{
      "first_name": firstName,
      "date_of_birth": birthday,
      "gender": gender,
      "last_name": lastName,
      "first_name_arabic": firstNameArabic,
      "last_name_arabic": lastNameArabic,
      "profile_picture":
      profilePictureUrl == 'false' ? '' : profilePictureUrl,
      "mobile": mobile,
      "email": email,
    };
  }
}

String convertBirthDay(DateTime birthDay) {
  final f = new DateFormat('yyyy-MM-dd');
  return f.format(birthDay);
}

UserData mapUserData(dynamic payload) {
  print("mapUserData");
  print(payload["subscription_end_date"]);
  print(payload["subscription_end_in"]);


  return UserData(
    subscriptionRemainingDays: payload["subscription_end_in"] != null?
    payload["subscription_end_in"].toString():  "No active subscription.",
    shift: payload["shift"] != null?
    payload["shift"].toString():  "",
    subscriptionEndDate: payload["subscription_end_date"] != null?
    payload["subscription_end_date"].toString():  "No active subscription.",
    subscriptionName: payload["subscription_name"] != null?
    payload["subscription_name"].toString():  "No active subscription.",
    subscriptionNameArabic: payload["subscription_arabic_name"] != null?
    payload["subscription_arabic_name"].toString():  "No active subscription.",
    id: payload["id"] ?? -1,
    profilePictureUrl: payload["profile_picture"] != null
        ? payload["profile_picture"].toString() !=""?
    payload["profile_picture"].toString()
        : ASSETS_DEFAULTPROFILEPIC
        : ASSETS_DEFAULTPROFILEPIC,
    mobile: payload["mobile"] ?? "",
    customerCode: payload["customer_code"] != null ?
    payload["customer_code"].toString()
        : "",
    email: payload["email"] != null
        ? payload["email"].toString() == 'false'
        ? ''
        : payload["email"].toString()
        : "",

    firstName: payload["first_name"]!=null && payload["first_name"] != false?payload["first_name"] : "",
    firstNameArabic: payload["first_name_arabic"]!=null && payload["first_name_arabic"] != false?payload["first_name_arabic"] : "",
    lastName: payload["last_name"]!=null && payload["last_name"] != false?payload["last_name"] : "",
    lastNameArabic: payload["last_name_arabic"]!=null && payload["last_name_arabic"] != false?payload["last_name_arabic"] : "",

    gender: payload["gender"] != null ? payload["gender"].toString() : "",
    birthday: payload["date_of_birth"] != null ? payload["date_of_birth"].toString() : "",
    height: payload["height"] !=null ? double.parse(payload["height"].toString()):0.0,
    weight: payload["weight"] !=null ? double.parse(payload["weight"].toString()):0.0,

  );
}

