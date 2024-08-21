import 'package:dietsteps/feature_modules/profile/constants/http_request_endpoints.constants.profile.dart';
import 'package:dietsteps/feature_modules/profile/models/referral_data.profile.model.dart';
import 'package:dietsteps/shared_module/models/general_item.model.shared.dart';
import 'package:dietsteps/shared_module/models/http_response.model.shared.dart';
import 'package:dietsteps/shared_module/models/user_data.model.shared.dart';
import 'package:dietsteps/shared_module/services/http-services/http_request_handler.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:get/get.dart'; 
class ProfileHttpService {
  Future<UserData> getProfileData(String mobile) async {
    try{
      Map<String, dynamic> params = {};
      params["mobile"]=mobile;
      AppHttpResponse response =
      await getRequest(ProfileHttpRequestEndpoint_Profile,params);
      if(response.statusCode== 200 && response.data != null){
        return mapUserData(response.data[0]);
      }
      return mapUserData({});
    }catch  (e,st){
      print(e);
      print(st);
      return mapUserData({});
    }
  }

  Future<ReferralData> getRefferalData(String mobile) async {
    try{
      Map<String, dynamic> params = {};
      params["mobile"]=mobile;
      AppHttpResponse response =
      await getRequest(ProfileHttpRequestEndpoint_GetRefferalData,params);
      if(response.statusCode== 200 && response.data != null){
        return mapReferralData(response.data[0]);
      }
      return mapReferralData({});
    }catch  (e,st){
      print(e);
      print(st);
      return mapReferralData({});
    }
  }

  Future<String> updateProfileData(UserData userData, String mobile ) async {

    try{
      AppHttpResponse response = await patchRequest(ProfileHttpRequestEndpoint_Profile,
          userData.toJson() );
      return response.statusCode == 200?"":response.message;

    }catch  (e,st){
      print(e);
      print(st);
      showSnackbar(Get.context!, "something_wrong".tr, "error");
      return "something_wrong".tr;
    }
  }

  Future<bool> updateAllergies(List<GeneralItem> allergies, String mobile ) async {

    try{


      AppHttpResponse response = await patchRequest(ProfileHttpRequestEndpoint_Allergy,
          {
            "mobile": mobile,
            "allergies": allergies.map((e) => e.id).toList(),
          });

      if(response.statusCode != 200){
        showSnackbar(Get.context!, "something_wrong".tr, "error");
      }
      return response.statusCode == 200;

    }catch (e,st){
      print(e);
      print(st);
      showSnackbar(Get.context!, "something_wrong".tr, "error");
      return false;
    }
  }

  Future<List<GeneralItem>> getAllergies(String mobile) async {

    try{
      Map<String, dynamic> params = {};
      params["mobile"]=mobile;
      AppHttpResponse response =
      await getRequest(ProfileHttpRequestEndpoint_Allergy,params);

      final List<GeneralItem> tempItems = [];

      if (response.statusCode == 200 && response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          tempItems.add(mapGeneralItem(response.data[i]));
        }
      }
      return tempItems;

    }catch  (e,st){
      print(e);
      print(st);
      showSnackbar(Get.context!, "something_wrong".tr, "error");
      return [];
    }
  }

  Future<List<GeneralItem>> getDislikes(String mobile) async {

    try{
      Map<String, dynamic> params = {};
      params["mobile"]=mobile;
      AppHttpResponse response =
      await getRequest(ProfileHttpRequestEndpoint_Dislike,params);

      final List<GeneralItem> tempItems = [];

      if (response.statusCode == 200 && response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          tempItems.add(mapGeneralItem(response.data[i]));
        }
      }
      return tempItems;

    }catch  (e,st){
      print(e);
      print(st);
      showSnackbar(Get.context!, "something_wrong".tr, "error");
      return [];
    }
  }

  Future<bool> updateDislikes(List<GeneralItem> allergies, String mobile ) async {

    try{


      AppHttpResponse response = await patchRequest(ProfileHttpRequestEndpoint_Dislike,
          {
            "mobile": mobile,
            "dislikes": allergies.map((e) => e.id).toList(),
          });
      if(response.statusCode != 200){
        showSnackbar(Get.context!, "something_wrong".tr, "error");
      }
      return response.statusCode == 200;

    }catch (e,st){
      print(e);
      print(st);
      showSnackbar(Get.context!, "something_wrong".tr, "error");
      return false;
    }
  }

  Future<List<GeneralItem>> getIngredients( ) async {

    try{
      AppHttpResponse response =
      await getRequest(ProfileHttpRequestEndpoint_Ingredient,null);

      final List<GeneralItem> tempItems = [];

      if (response.statusCode == 200 && response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          tempItems.add(mapGeneralItem(response.data[i]));
        }
      }
      return tempItems;

    }catch (e,st){
      print(e);
      print(st);
      showSnackbar(Get.context!, "something_wrong".tr, "error");
      return [];
    }
  }

  Future<bool> deleteAccount(String mobile) async {

    try{
      Map<String, dynamic> params = {};
      params["mobile"]=mobile;
      AppHttpResponse response =
          await deleteRequest(ProfileHttpRequestEndpoint_Profile,params);

      return response.statusCode == 200;

    }catch (e,st){
      print(e);
      print(st);
      showSnackbar(Get.context!, "something_wrong".tr, "error");
      return false;
    }
  }

}
