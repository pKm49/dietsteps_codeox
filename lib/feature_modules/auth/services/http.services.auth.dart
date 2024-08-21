import 'package:dietsteps/feature_modules/auth/constants/http_request_endpoints.constant.auth.dart';
import 'package:dietsteps/feature_modules/auth/models/login_credential.model.auth.dart';
import 'package:dietsteps/feature_modules/auth/models/meal_item.model.auth.dart';
import 'package:dietsteps/feature_modules/auth/models/register_credential.model.auth.dart';
import 'package:dietsteps/shared_module/models/general_item.model.shared.dart';
import 'package:dietsteps/shared_module/models/http_response.model.shared.dart';
import 'package:dietsteps/shared_module/services/http-services/http_request_handler.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:get/get.dart';
class AuthHttpService {


  Future<bool> login(LoginCredential loginCredentials) async {
    try{
      Map<String, dynamic> params = {};
      params["mobile"]=loginCredentials.mobile;
      params["password"]=loginCredentials.password;
      AppHttpResponse response = await getRequest(
          AuthHttpRequestEndpoint_Login,params);
      if(response.statusCode != 200){
        showSnackbar(Get.context!, response.message, "error");
      }
      return response.statusCode == 200;
    }catch  (e,st){
      print(e);
      print(st);
      showSnackbar(Get.context!, "something_wrong".tr, "error");
      return false;
    }
  }

  Future<bool> register(RegisterCredential registerCredentials) async {

    try{
      AppHttpResponse response = await postRequest(AuthHttpRequestEndpoint_Register,registerCredentials.toJson());
      if(response.statusCode != 200){
        showSnackbar(Get.context!, response.message, "error");
      }
      return response.statusCode == 200;
    }catch  (e,st){
      print(e);
      print(st);
      showSnackbar(Get.context!, "something_wrong".tr, "error");
      return false;
    }
  }

  Future<bool> resetPassword(String mobile, String newPassword, String gender, String birthday, String email) async {

    try{

      AppHttpResponse response = await patchRequest(AuthHttpRequestEndpoint_ResetPassword, {
        "mobile": mobile,
        "new_password": newPassword,
        "gender": gender,
        "date_of_birth": birthday,
        "email": email,
      });
      showSnackbar(Get.context!, response.message,response.statusCode != 200? "error":"info");

      return response.statusCode == 200;
    }catch  (e,st){
      print(e);
      print(st);
      showSnackbar(Get.context!, "something_wrong".tr, "error");
      return false;
    }
  }

  Future<List<GeneralItem>> getMealCategories() async {

    try{
      Map<String, dynamic> params = {};
      AppHttpResponse response =
      await getRequest(AuthHttpRequestEndpoint_GetMealCategories, params);

      List<GeneralItem> tempMealCategories = [];

      if (response.statusCode == 200 && response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          tempMealCategories.add(mapGeneralItem(response.data[i]));
        }
      }
      return tempMealCategories;

    }catch  (e,st){
      print(e);
      print(st);
      return [];
    }
  }

  Future<List<MealItem>> getMealsByCategory(int categoryId ) async {

    try{
      AppHttpResponse response = await getRequest(
          '$AuthHttpRequestEndpoint_GetMealsByCatory${categoryId}', null);

      List<MealItem> tempSubscriptionPlans = [];

      if (response.statusCode == 200 && response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          tempSubscriptionPlans.add(mapMealItem(response.data[i]));
        }
      }

      return tempSubscriptionPlans;

    }catch  (e,st){
      print(e);
      print(st);
      return [];
    }
  }

}

