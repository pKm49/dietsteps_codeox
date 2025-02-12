 import 'package:shared_preferences/shared_preferences.dart';

saveAuthTokenAndMobileToSharedPreference(String authToken, String mobile) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("accessToken", authToken);
  prefs.setString("mobile", mobile);
}

