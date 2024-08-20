import 'package:get/get.dart';

String? checkIfMobileNumberValid(String? mobile) {
  String validMobilePattern = r'^([0-9])+$';
  RegExp validMobileRegex = new RegExp(validMobilePattern);

  if (mobile!.isEmpty || !validMobileRegex.hasMatch(mobile)) {
    return "mobile_validation_message".tr;
  }

  return null;
}

String? checkIfPasswordFieldValid(String? password) {
  String validPasswordPattern =
      r'^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)\S{5,}$';
  RegExp validPasswordRegex = new RegExp(validPasswordPattern);

  if (password!.isEmpty || password.length<4) {
    return "password_validation_message".tr;
  }

  return null;
}

String? checkIfConfirmPasswordFieldValid(
    String? confirmPassword, String? password) {
  String validPasswordPattern =
      r'^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)\S{5,}$';
  RegExp validPasswordRegex = new RegExp(validPasswordPattern);

  if (password!.isEmpty || password.length<4) {

    return "password_validation_message".tr;
  }

  if (confirmPassword != password) {
    return "confirm_password_validation_message".tr;
  }

  return null;
}

String? checkIfArabicNameValid(String? value, String fieldName, bool isErrorMessageShort) {
  String validOtpPattern = r'[^\p{Arabic}\w\s]';
  RegExp validOtpRegex = new RegExp(validOtpPattern);

  if (value!.isEmpty || !validOtpRegex.hasMatch(value)) {
    switch(fieldName){
      case "first_name_ar":return isErrorMessageShort?  "firstname_ar_validation_message_short".tr: "firstname_ar_validation_message".tr;
      case "last_name_ar":return isErrorMessageShort?  "lastname_ar_validation_message_short".tr: "lastname_ar_validation_message".tr;
       default:return "input_validation_message".tr;
    }
  }

  return null;
}


String? checkIfNameFormValid(String? name, String fieldName) {

  if ( name!.isEmpty) {
    switch(fieldName){
      case "first_name_ar":return "firstname_ar_validation_message".tr;
      case "last_name_ar":return "lastname_ar_validation_message".tr;
      case "first_name_en":return "firstname_en_validation_message".tr;
      case "last_name_en":return "lastname_en_validation_message".tr;
      case "house_number":return "housenumber_validation_message".tr;
      case "street":return "street_validation_message".tr;
      case "height":return "height_validation_message".tr;
      case "weight":return "weight_validation_message".tr;
      default:return "input_validation_message".tr;
    }

  }

  return null;
}

String? checkIfEmailFormValid(String? email) {

  String validOtpPattern = r'(^$)|(^.*@.*\..*$)';
  RegExp validOtpRegex = new RegExp(validOtpPattern);

  if(email =="" || email!.isEmpty ){
    return null;
  }

  if (email.isNotEmpty && !validOtpRegex.hasMatch(email)) {
    return "email_validation_message".tr;
  }

  return null;

}
