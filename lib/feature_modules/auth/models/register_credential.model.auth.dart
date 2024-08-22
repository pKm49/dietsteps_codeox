 import 'package:dietsteps/feature_modules/auth/services/default_profilepic_base64.dart';
import 'package:intl/intl.dart';

class RegisterCredential {
  final String mobile;
  final String password;
  final String firstName;
  final String lastName;
  final String firstNameArabic;
  final String lastNameArabic;
  final String email;
  final DateTime dateOfBirth;
  final String gender;
  final double height;
  final double weight;
  final String source;
  final String nickname;
  final int area;
  final int block;
  final String street;
  final String jedha;
  final int houseNumber;
  final int floorNumber;
  final int apartmentNumber;
  final String comments;
  final String profile_picture;
  final String other_source;

  RegisterCredential(
      {required this.mobile,
        required this.password,
        required this.firstName,
        required this.lastName,
        required this.firstNameArabic,
        required this.lastNameArabic,
        required this.email,
        required this.dateOfBirth,
        required this.gender,
        required this.height,
        required this.apartmentNumber,
        required this.weight,
        required this.source,
        required this.nickname,
        required this.area,
        required this.block,
        required this.street,
        required this.jedha,
        required this.houseNumber,
        required this.floorNumber,
        required this.comments,
        required this.profile_picture,
        required this.other_source});


  Map<String, dynamic> toJson() => {
    "mobile": mobile,
    "password": password,
    "first_name": firstName,
    "last_name": lastName,
    "first_name_arabic": firstNameArabic,
    "last_name_arabic": lastNameArabic,
    "email": email,
    "date_of_birth": convertBirthDay(dateOfBirth),

    "gender": gender,
    "height": height,
    "weight": weight,
    "source": source,
    'name': nickname.trim()==""?"Home":nickname,
    'nickname': nickname.trim()==""?"Home":nickname,
    "area_id": area,
    "block_id": block,
    "street": street,
    "jedha": jedha,
    "house_number": houseNumber,
    "floor_number": floorNumber,
    "comments": comments,
    "apartment_no":apartmentNumber,
    "profile_picture": profile_picture ==""?getDefaultProfilePictureBase64():profile_picture,
    "other_source": other_source
  };
}
String convertBirthDay(DateTime birthDay) {
  final f = new DateFormat('yyyy-MM-dd');
  return f.format(birthDay);
}
