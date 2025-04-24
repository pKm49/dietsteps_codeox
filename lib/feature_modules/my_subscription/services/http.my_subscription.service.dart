import 'package:dietsteps/feature_modules/my_subscription/constants/http_request_endpoints.constants.my_subscription.dart';
import 'package:dietsteps/feature_modules/my_subscription/models/subscription_date.model.my_subscription.dart';
import 'package:dietsteps/feature_modules/my_subscription/models/subscription_mealconfig.model.my_subscription.dart';
import 'package:dietsteps/shared_module/constants/default_values.constants.shared.dart';
import 'package:dietsteps/shared_module/models/http_response.model.shared.dart';
import 'package:dietsteps/shared_module/services/http-services/http_request_handler.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/date_conversion.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:get/get.dart';

import '../models/buffer_response.dart';
class MySubsHttpService {

  Future<List<SubscriptoinDate>> getSubscriptionDates(String mobile) async {

    try{
      Map<String, dynamic> params = {};
      params["mobile"]=mobile;
      AppHttpResponse response =
      await getRequest(MySubscriptionHttpRequestEndpoint_GetSubscriptionDates,params);

      print("getSubscriptionDates");
      print(response.statusCode);
      print(response.data);
      final List<SubscriptoinDate> subscriptoinDates = [];

      if (response.statusCode == 200 && response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          SubscriptoinDate subscriptoinDate = mapSubscriptoinDate(response.data[i]);
          List<SubscriptoinDate> subSameDate = subscriptoinDates.where((element) => isSameDay(element.date,subscriptoinDate.date)).toList();
          if(!isSameDay(subscriptoinDate.date, DefaultInvalidDate) && subSameDate.isEmpty){
            subscriptoinDates.add(mapSubscriptoinDate(response.data[i]));
          }
        }
      }

      return subscriptoinDates;

    }catch  (e,st){
      print(e);
      print(st);
      return [];
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

  Future<bool> rateMeals(String mobile, int mealId, int rating) async {

    try{
      AppHttpResponse response =
      await postRequest(MySubscriptionHttpRequestEndpoint_RateMeal,
          {"mobile": mobile,"meal_id":mealId,"rating":rating});
      if(response.statusCode != 200){
        showSnackbar(Get.context!, response.message, "error");
      }
      return response.statusCode == 200;

    }catch (e){
      return false;
    }
  }
  Future<BufferDetailsResponse> getBufferTime() async {
    try {
      // Empty parameters since no params needed
      Map<String, dynamic> params = {};

      // Make the GET request to the buffer time endpoint
      AppHttpResponse response = await getRequest(
          MySubscriptionHttpRequestEndpoint_BufferTime, params);



      if (response.statusCode == 200 && response.data != null) {
        // Check if the response is already the payload (not wrapped)
        if (response.data is Map && response.data.containsKey("buffer_before_4_30")) {

          // Create a wrapped response structure
          Map<String, dynamic> wrappedResponse = {
            "statusOk": true,
            "statusCode": 200,
            "message": [],
            "payload": response.data,
            "error": []
          };

          return BufferDetailsResponse.fromJson(wrappedResponse);
        } else {
          return BufferDetailsResponse.fromJson(response.data);
        }
      }

      return BufferDetailsResponse();
    } catch (e, st) {
      print("❌ Error getting buffer time: $e");
      print(st);
      return BufferDetailsResponse(); // Return default/empty response on error
    }
  }
}
