import 'package:dietsteps/feature_modules/my_subscription/constants/http_request_endpoints.constants.my_subscription.dart';
import 'package:dietsteps/feature_modules/my_subscription/models/subscription_mealconfig.model.my_subscription.dart';
import 'package:dietsteps/shared_module/models/http_response.model.shared.dart';
import 'package:dietsteps/shared_module/services/http-services/http_request_handler.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:get/get.dart';
class MySubsHttpService {

  Future<Map<DateTime, String>> getSubscriptionDates(String mobile) async {

    try{
      Map<String, dynamic> params = {};
      params["mobile"]=mobile;
      AppHttpResponse response =
      await getRequest(MySubscriptionHttpRequestEndpoint_GetSubscriptionDates,params);

      print("getSubscriptionDates");
      print(response.statusCode);
      print(response.data);
      print(response.data is Map);
      print(response.data != null);
      Map<DateTime, String> tDates = {};
      if(response.data != null && response.data is Map){
        response.data.forEach((key, value) {
          DateTime dateTime;
          try {
            dateTime = getParsableDate(key);
          } catch (e) {
            dateTime = DateTime(1900,1,1);
          }
          tDates[dateTime]=value;
        });
        return tDates;
      }



      return tDates;

    }catch  (e,st){
      print(e);
      print(st);
      return {};
    }
  }

  getParsableDate(payload) {
    List<String> dateItem = [];
    List<String> dateItems = [];
    List<String> dateItemsInt = [];
    dateItem = payload.toString().split(" ").toList() ;
    dateItems = dateItem[0].split("-").toList();
    dateItems.forEach((element) {
      if(int.parse(element)<10 && !element.startsWith("0")){
        dateItemsInt.add('0$element');
      }else{
        dateItemsInt.add(element);
      }
    });
    return DateTime.parse(dateItemsInt.join("-"));
  }

  Future<SubscriptoinMealConfig> getMealsByDay(  String mobile, String date) async {

    try{
      Map<String, dynamic> params = {};
      params["date"]=date;
      AppHttpResponse response =
      await getRequest(MySubscriptionHttpRequestEndpoint_GetSubscriptionMealsByDate+mobile,params);

      print("getMealsByDay");
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200 && response.data != null) {
         return mapSubscriptoinMealConfig(response.data[0], date);
      }
      print("reached hereeeeeee");
      return mapSubscriptoinMealConfig({}, date);

    }catch (e,st){
      print(e);
      print(st);
      print("reached error");
      return mapSubscriptoinMealConfig({}, date);
    }
  }

  Future<bool> saveMealsByDay(  int subscriptionId,SubscriptoinMealConfig selectedMealConfig ,String date) async {

    try{
      Map<String, dynamic> params = {};
      params["date"]=date;
      params["subscription_id"]=subscriptionId;
      params["meal_config"]=mapSubscriptoinMealConfigForSubmit(selectedMealConfig);
      AppHttpResponse response =
      await patchRequest(MySubscriptionHttpRequestEndpoint_SetSubscriptionMealsByDate,params);
      if(response.statusCode != 200){
        showSnackbar(Get.context!, response.message, "error");
      }
      return response.statusCode == 200;


    }catch (e,st){
      print(e);
      print(st);
      return false;
    }
  }

  Future<bool> freezeSubscriptionDays(  int subscriptionId,List<String> frozenDays , bool isFreeze) async {

    try{
      Map<String, dynamic> params = {};
      params["subscription_id"]=subscriptionId;
      params["freeze_dates"]=frozenDays;
      AppHttpResponse response =
      await patchRequest(isFreeze?MySubscriptionHttpRequestEndpoint_FreezeSubscriptionDays:MySubscriptionHttpRequestEndpoint_UnFreezeSubscriptionDays,params);
      if(response.statusCode != 200){
        showSnackbar(Get.context!, response.message, "error");
      }
      return response.statusCode == 200;


    }catch (e,st){
      print(e);
      print(st);
      return false;
    }
  }


}
