
import 'package:dietsteps/feature_modules/address/models/shipping_address.model.address.dart';
import 'package:dietsteps/feature_modules/e_shop/constants/http_request_endpoints.constant.eshop.dart';
import 'package:dietsteps/feature_modules/e_shop/models/cart.model.eshop.dart';
import 'package:dietsteps/feature_modules/e_shop/models/meal_item.model.eshop.dart';
import 'package:dietsteps/feature_modules/plan_purchase/models/discount_data.model.plan_purchase.dart';
import 'package:dietsteps/feature_modules/plan_purchase/models/payment_data.model.plan_purchase.dart';
import 'package:dietsteps/shared_module/models/general_item.model.shared.dart';
import 'package:dietsteps/shared_module/models/http_response.model.shared.dart';
import 'package:dietsteps/shared_module/services/http-services/http_request_handler.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:get/get.dart';
class EshopHttpService {

  Future<List<MealCategory>> getEshopMeals() async {

    try{
      AppHttpResponse response = await getRequest(
          '$EshopHttpRequestEndpoint_GetEshopMeals', null);

      List<MealCategory> tempSubscriptionPlans = [];
      print("getEshopMeals");

      if (response.statusCode == 200 && response.data != null) {
        for (var i = 0; i < response.data[0]['meals'].length; i++) {
          if(mapMealCategory(response.data[0]['meals'][i]).meals.isNotEmpty){
            tempSubscriptionPlans.add(mapMealCategory(response.data[0]['meals'][i]));
          }
        }
      }

      return tempSubscriptionPlans;

    }catch  (e,st){
      print(e);
      print(st);
      return [];
    }
  }

  Future<List<GeneralItem>> getMealCategories() async {

    try{
      Map<String, dynamic> params = {};
      AppHttpResponse response =
      await getRequest(EshopHttpRequestEndpoint_GetMealCategories, params);

      List<GeneralItem> tempMealCategories = [];
      print("getMealCategories");
      print(response.data);
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
          '$EshopHttpRequestEndpoint_GetMealsByCatory${categoryId}', null);

      List<MealItem> tempSubscriptionPlans = [];
      print("getMealsByCategory");
      print(response.statusCode);
      print(response.data);
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

  Future<bool> isProfileExist(String mobile ) async {

    try{
      AppHttpResponse response = await getRequest(
          '$EshopHttpRequestEndpoint_CheckProfileExistance$mobile', null);

      print("getMealsByCategory");
      print(mobile);
      print(response.statusCode);
      print(response.data);
      return response.statusCode == 200;


    }catch  (e,st){
      print(e);
      print(st);
      return false;
    }
  }

  Future<List<Cart>> getOrderHistory(String mobile ) async {

    try{
      AppHttpResponse response = await getRequest(
          '$EshopHttpRequestEndpoint_GetOrderHistory${mobile}', null);

      List<Cart> tempSubscriptionPlans = [];
      print("getMealsByCategory");
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200 && response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          tempSubscriptionPlans.add(mapCart(response.data[i]));
        }
      }

      return tempSubscriptionPlans;

    }catch  (e,st){
      print(e);
      print(st);
      return [];
    }
  }

  Future<Cart> getCartDetails(String mobile ) async {

    try{
      AppHttpResponse response = await getRequest(
          '$EshopHttpRequestEndpoint_GetCartDetails${mobile}', null);

      print("getMealsByCategory");
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200 && response.data != null) {
         return mapCart(response.data);
      }

      return mapCart({});

    }catch  (e,st){
      print(e);
      print(st);
      return mapCart({});
    }
  }

  Future<bool> addToCart(String mobile, List<OrderLine> orderLine) async {

    try{

      Map<String, dynamic> params = {};
      params["mobile"]=mobile;
      List<dynamic> tOrderLine= [];

      for (var element in orderLine) {
        tOrderLine.add(element.toJson());
      }

      params["meal_list"]=tOrderLine;

      AppHttpResponse response = await postRequest(
          '$EshopHttpRequestEndpoint_AddToCart', params);

      List<MealItem> tempSubscriptionPlans = [];
      print("getMealsByCategory");
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200 && response.data != null) {
         return true ;
      }else{
        showSnackbar(Get.context!, response.message , "error");

        return false;
      }



    }catch  (e,st){
      print(e);
      print(st);
      return false;
    }
  }

  Future<bool> removeFromCart(String mobile, int mealId, int quantity ) async {

    try{
      Map<String, dynamic> params = {};
      params["mobile"]=mobile;
      params["meal_id"]=mealId;
      params["quantity"]=quantity;

      AppHttpResponse response = await postRequest(
          '$EshopHttpRequestEndpoint_RemoveFromCart', params);

      List<MealItem> tempSubscriptionPlans = [];
      print("getMealsByCategory");
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200 && response.data != null) {
        return true ;
      }else{
        showSnackbar(Get.context!, response.message , "error");

        return false;
      }



    }catch  (e,st){
      print(e);
      print(st);
      return false;
    }
  }

  Future<bool> emptyFromCart(String mobile ) async {

    try{
      Map<String, dynamic> params = {};
      params["mobile"]=mobile;

      AppHttpResponse response = await postRequest(
          '$EshopHttpRequestEndpoint_EmptyCart', params);

      List<MealItem> tempSubscriptionPlans = [];
      print("getMealsByCategory");
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200 && response.data != null) {
        return true ;
      }else{
        showSnackbar(Get.context!, response.message , "error");

        return false;
      }

    }catch  (e,st){
      print(e);
      print(st);
      return false;
    }
  }

  Future<PaymentData> checkout(String mobile, int addressId,String couponCode ) async {

    try{
      Map<String, dynamic> params = {};
      params["mobile"]=mobile;
      params["address_id"]=addressId;
      params["coupon_code"]=couponCode;

      AppHttpResponse response = await postRequest(
          '$EshopHttpRequestEndpoint_Checkout', params);

      print("checkout");
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200 && response.data != null) {
        print("reached success");

        return mapPaymentData(response.data);

      }else{
        print("reached failure");
        showSnackbar(Get.context!, response.message , "error");
      }

      return mapPaymentData({});

    }catch  (e,st){
      print("reached error");

      print(e);
      print(st);
      return mapPaymentData({});
    }
  }

  Future<DiscountData> verifyCoupon(double total, String couponCode) async {

    try{
      Map<String, dynamic> params = {};
      params['eshop_total']=total;
      params['coupon_code']=couponCode;
      AppHttpResponse response =
      await getRequest(EshopHttpRequestEndpoint_VerifyCoupon, params
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

  Future<bool> checkOrderStatus(String referenceId) async {

    try{
      Map<String, dynamic> params = {};
      params["reference"]=referenceId;
      AppHttpResponse response =
      await getRequest(EshopHttpRequestEndpoint_CheckOrderStatus, params);

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


  Future<List<Address>> getUserAddressess(String mobile) async {

    try{
      Map<String, dynamic> params = {};
      params["mobile"]=mobile;
      AppHttpResponse response =
      await getRequest(EshopHttpRequestEndpoint_Address,params);

      List<Address> tempAddressList = [];
      if (response.statusCode == 200 && response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          tempAddressList.add(mapAddress(response.data[i]));
        }
      }

      return tempAddressList;

    }catch  (e,st){
      print(e);
      print(st);
      return [];
    }

  }

  Future<List<GeneralItem>> getShiftList( ) async {

    try{
      AppHttpResponse response =
      await getRequest(EshopHttpRequestEndpoint_Shift,null);

      List<GeneralItem> tempAddressList = [];
      tempAddressList.add(mapGeneralItem({"id":-1,"name":"Select Time","arabic_name":"حدد الوقت"}));
      if (response.statusCode == 200 && response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          tempAddressList.add(mapGeneralItem(response.data[i]));
        }
      }

  tempAddressList.forEach((element) {
    print("tempAddressList");
    print(element.id);
    print(element.name);
  }) ;

      return tempAddressList;

    }catch  (e,st){
      print(e);
      print(st);
      return [];
    }

  }


}
