 
import 'package:dietsteps/feature_modules/plan_purchase/constants/http_request_endpoints.constant.plan_purchase.dart';
import 'package:dietsteps/feature_modules/plan_purchase/models/discount_data.model.plan_purchase.dart';
import 'package:dietsteps/feature_modules/plan_purchase/models/payment_data.model.plan_purchase.dart';
import 'package:dietsteps/feature_modules/plan_purchase/models/plan.model.plan_purchase.dart';
import 'package:dietsteps/feature_modules/plan_purchase/models/plan_category.model.plan_purchase.dart';
import 'package:dietsteps/feature_modules/plan_purchase/models/purchase_data.model.plan_purchase.dart';
import 'package:dietsteps/shared_module/models/http_response.model.shared.dart';
import 'package:dietsteps/shared_module/services/http-services/http_request_handler.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:get/get.dart';

class PlanPurchaseHttpService {

  Future<List<SubscriptionPlanCategory>> getSubscriptionCategories() async {

    try{
      Map<String, dynamic> params = {};
      AppHttpResponse response =
      await getRequest(SubscriptionsHttpRequestEndpoint_GetPlanCategories, params);

      List<SubscriptionPlanCategory> tempSubscriptionPlanCategories = [];
      print("getSubscriptionCategories");
      print(response.data);
      if (response.statusCode == 200 && response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          tempSubscriptionPlanCategories.add(mapSubscriptionCategory(response.data[i]));
        }
      }

      return tempSubscriptionPlanCategories;

    }catch  (e,st){
      print(e);
      print(st);
      return [];
    }
  }


  Future<List<SubscriptionPlan>> getSubscriptionsByCategory(SubscriptionPlanCategory category  ) async {

    try{
      AppHttpResponse response = await getRequest(
          '$SubscriptionsHttpRequestEndpoint_GetPlans${category.id}', null);

      List<SubscriptionPlan> tempSubscriptionPlans = [];
      print("getSubscriptionsByCategory");
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200 && response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          tempSubscriptionPlans.add(mapSubscriptionItem(response.data[i]));
        }
      }

      return tempSubscriptionPlans;

    }catch  (e,st){
      print(e);
      print(st);
      return [];
    }
  }

  Future<DiscountData> verifyCoupon(int planId, String couponCode) async {

    try{
      Map<String, dynamic> params = {};
      params['plan_choice_id']=planId;
      params['coupon_code']=couponCode;
      AppHttpResponse response =
      await getRequest(SubscriptionsHttpRequestEndpoint_VerifyCoupon, params
      );

      if (response.statusCode == 200 && response.data != null) {
         return mapDiscountData(response.data[0],true);
      }

      return mapDiscountData({},false);

    }catch  (e,st){
      print(e);
      print(st);
      return mapDiscountData({},false);
    }
  }

  Future<PaymentData> createOrder(PurchaseData purchaseData) async {


    try{
      AppHttpResponse response =
      await postRequest(SubscriptionsHttpRequestEndpoint_CreateOrder, purchaseData.toJson());

      print("createOrder");
      print(response.statusCode.toString());
      print(response.data.toString());
      print(response.message.toString());
      if (response.statusCode == 200 && response.data != null) {
        print("createOrder inside iff");
        print(response.data[0].toString());
        return mapPaymentData(response.data[0]);

      }else{
        print("createOrder inside else");
        showSnackbar(Get.context!, response.message , "error");
      }
      print("createOrder outside else");

      return mapPaymentData({});

    }catch (e,strc){
      print("something_wrong error");
      print(e);
      print(strc);
      showSnackbar(Get.context!, "something_wrong".tr , "error");
      return mapPaymentData({});
    }
  }

  Future<bool> checkDateAvailability(String date, String mobile) async {

    try{
      Map<String, dynamic> params = {};
      params["date"]=date;
      params["mobile"]=mobile;
      AppHttpResponse response =
      await getRequest(SubscriptionsHttpRequestEndpoint_CheckDateAvailability, params);

      if(response.statusCode != 200){
        showSnackbar(Get.context!, response.message, "error");
      }

      return response.statusCode ==200;


    }catch  (e,st){
      print(e);
      print(st);
      return false;
    }
  }


  Future<bool> checkOrderStatus(String referenceId) async {

    try{
      Map<String, dynamic> params = {};
      params["reference"]=referenceId;
      AppHttpResponse response =
      await getRequest(SubscriptionsHttpRequestEndpoint_CheckOrderStatus, params);

      if (response.statusCode == 200 && response.data != null) {
        if(response.data[0]['payment_status'] !=null){
          return response.data[0]['payment_status'] == "paid";
        }
       }

      return false;

    }catch  (e,st){
      print(e);
      print(st);
      return false;
    }
  }

  Future<bool> activateSubscription(int subscriptionId) async {

    try{
      Map<String, dynamic> params = {};
      params["subscription_id"]=subscriptionId;
      AppHttpResponse response =
      await postRequest(SubscriptionsHttpRequestEndpoint_ActivateSubscription, params);

      print("activateSubscription");
      print(response.statusCode.toString());
      print(response.data.toString());
      print(response.message.toString());
      return response.statusCode == 200;

    }catch  (e,st){
      print(e);
      print(st);
      return false;
    }
  }

}
