import 'package:dietsteps/feature_modules/address/models/shipping_address.model.address.dart';
import 'package:dietsteps/feature_modules/e_shop/models/cart.model.eshop.dart';
import 'package:dietsteps/feature_modules/e_shop/models/meal_item.model.eshop.dart';
import 'package:dietsteps/feature_modules/e_shop/services/http.services.eshop.dart';
import 'package:dietsteps/feature_modules/plan_purchase/models/discount_data.model.plan_purchase.dart';
import 'package:dietsteps/feature_modules/plan_purchase/models/payment_data.model.plan_purchase.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/models/general_item.model.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EshopController extends GetxController {
  Rx<TextEditingController> mobileTextEditingController = TextEditingController().obs;

  var itemScrollController = ItemScrollController();

  Rx<TextEditingController> couponCodeController = TextEditingController().obs;
  var isCouponChecking = false.obs;
  var isCouponCodeValid = false.obs;
  var paymentData = mapPaymentData({}).obs;
  var isCategoriesFetching = false.obs;
  var isAddingToOrRemoveFromCart = false.obs;
  var isUserExistanceChecking = false.obs;
  var isEmptyingCart = false.obs;
  var subTotal = (0.0).obs;
  var discount = (0.0).obs;
  var total = (0.0).obs;
  var isPurchaseHistoryFetching = false.obs;
  var isOrderCreating = false.obs;
  var isCartDetailsFetching = false.obs;
  var cart = mapCart({}).obs;
  var orders = <Cart>[].obs;
  var isOrdersFetching = false.obs;
   var customerAddressList = <Address>[].obs;
  var isCustomerAddressListFetching = false.obs;
  var isMealsLoading = false.obs;
  var mealCategorySingleItems = <GeneralItem>[].obs;
  var mealCategories = <MealCategory>[].obs;
  var currentMealCategoryId = (-1).obs;
  var currentMeal = mapMealItem({}).obs;
  var isPaymentGatewayLoading = false.obs;
  var paymentGatewayIsLoading = false.obs;
  var addressId = (-1).obs;
  var mobile = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> getOrders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tMobile = prefs.getString('mobile');
    if (tMobile != null && tMobile != '') {
      if (!isOrdersFetching.value) {
        isOrdersFetching.value = true;
        var eshopHttpService = new EshopHttpService();
        orders.value = await eshopHttpService.getOrderHistory(tMobile);

        isOrdersFetching.value = false;
      }
    }
  }

  createCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tMobile = prefs.getString('mobile');
    if (tMobile != null && tMobile != '') {
      if(!isAddingToOrRemoveFromCart.value ){
        isAddingToOrRemoveFromCart.value = true;

        var eshopHttpService = new EshopHttpService();
        bool isSuccess =
        await eshopHttpService.addToCart(tMobile,cart.value.orderLine);
        isAddingToOrRemoveFromCart.value = false;
        if(isSuccess){
          Get.toNamed(AppRouteNames.eshopCheckoutRoute);
        }
      }
    }
  }

  Future<void> updateCartItem(
      OrderLine mealItem, int quantity, bool isAdd) async {
    List<OrderLine> orderLine = [];
    var tTotal = 0.0;
    if (isAdd) {
      if (cart.value.orderLine
          .where((element) => element.mealId == mealItem.mealId)
          .toList()
          .isNotEmpty) {
        for (var element in cart.value.orderLine) {
          if (element.mealId == mealItem.mealId) {
            var tQuantity = isAdd
                ? element.quantity + quantity
                : element.quantity - quantity;
            tTotal += tQuantity * element.price;
            orderLine.add(OrderLine(
                mealId: mealItem.mealId,
                imageUrl: element.imageUrl,
                mealName: element.mealName,
                mealNameArabic: element.mealNameArabic,
                quantity: tQuantity,
                price: element.price));
          } else {
            tTotal += element.price * element.quantity;
            orderLine.add(element);
          }
        }
      } else {
        for (var element in cart.value.orderLine) {
          tTotal += element.price * element.quantity;
          orderLine.add(element);
        }
        tTotal += quantity * mealItem.price;
        orderLine.add(OrderLine(
            mealId: mealItem.mealId,
            imageUrl: mealItem.imageUrl,
            mealName: mealItem.mealName,
            mealNameArabic: mealItem.mealNameArabic,
            quantity: quantity,
            price: mealItem.price));
      }
    } else {
      print("not isAdd");
      if (cart.value.orderLine
          .where((element) => element.mealId == mealItem.mealId)
          .toList()
          .isNotEmpty) {
        for (var element in cart.value.orderLine) {
          if (element.mealId == mealItem.mealId) {
            var tQuantity =  element.quantity + quantity;
            if(tQuantity<=0){
            }else{
              tTotal += tQuantity * element.price;

              orderLine.add(OrderLine(
                  mealId: mealItem.mealId,
                  imageUrl: element.imageUrl,
                  mealName: element.mealName,
                  mealNameArabic: element.mealNameArabic,
                  quantity: tQuantity,
                  price: element.price));
            }



          } else {
            tTotal += element.price * element.quantity;
            orderLine.add(element);
          }
        }
      }
    }

    print("total");
    print(total);
    cart.value = Cart(
        orderReference: cart.value.orderReference,
        orderDate: cart.value.orderDate,
        state: cart.value.state,
        total: tTotal,
        invoiceReference: cart.value.invoiceReference,
        orderLine: orderLine);
    subTotal.value = cart.value.total;
    discount.value = 0.0;
    total.value = subTotal.value;
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String? tMobile = prefs.getString('mobile');
    // if (tMobile != null && tMobile != '') {
    //   if(!isAddingToOrRemoveFromCart.value ){
    //     isAddingToOrRemoveFromCart.value = true;
    //
    //     var eshopHttpService = new EshopHttpService();
    //     bool isSuccess = false;
    //     if(isAdd){
    //       isSuccess =
    //       await eshopHttpService.addToCart(tMobile,mealId,quantity);
    //     }else{
    //       isSuccess =
    //       await eshopHttpService.removeFromCart(tMobile,mealId,quantity*-1);
    //     }
    //     getCart();
    //
    //   }
    // }
  }

  Future<void> getMealCategories() async {
    if (!isCategoriesFetching.value && !isMealsLoading.value) {
      isCategoriesFetching.value = true;
      isMealsLoading.value = true;
      mealCategorySingleItems.value = [];
      var eshopHttpService = new EshopHttpService();
      mealCategorySingleItems.value = await eshopHttpService.getMealCategories();
      isCategoriesFetching.value = false;
      currentMealCategoryId.value = -1;

      update();
      if (mealCategorySingleItems.isEmpty) {
        currentMeal.value = mapMealItem({});
        mealCategorySingleItems.value = [];
        isMealsLoading.value = false;

      } else {
        currentMealCategoryId.value = mealCategorySingleItems[0].id;

        getEshopMeals( );
      }
    }
  }

  Future<void> getEshopMeals( ) async {

    print("getEshopMeals");
    if (!isCategoriesFetching.value  ) {
      isMealsLoading.value = true;
      currentMeal.value = mapMealItem({});
      mealCategories.value = [];
      var eshopHttpService = EshopHttpService();
      mealCategories.value = await eshopHttpService.getEshopMeals();
      mealCategorySingleItems.value = mealCategorySingleItems.where((p0) => mealCategories.indexWhere((element) => element.id==p0.id)>-1).toList();
      isMealsLoading.value = false;
    }
  }

  // Future<void> getMealsByCategory(int categoryId) async {
  //   if (!isCategoriesFetching.value &&
  //       !isMealsLoading.value &&
  //       categoryId != -1) {
  //     isMealsLoading.value = true;
  //     currentMealCategoryId.value = categoryId;
  //     currentMeal.value = mapMealItem({});
  //     meals.value = [];
  //     var eshopHttpService = EshopHttpService();
  //     meals.value = await eshopHttpService.getMealsByCategory(categoryId);
  //     isMealsLoading.value = false;
  //   }
  // }

  void viewMeal(MealItem mealItem) {
    if (mealItem.id != -1) {
      currentMeal.value = mealItem;
      Get.toNamed(AppRouteNames.eshopMenuItemDetailsRoute);
    }
  }

  Future<void> checkCouponValidity() async {
    isCouponChecking.value = true;
    isCouponCodeValid.value = false;

    var planPurchaseHttpService = EshopHttpService();
    DiscountData discountData = await planPurchaseHttpService.verifyCoupon(
        cart.value.total, couponCodeController.value.text);

    if (!discountData.isValid) {
      isCouponCodeValid.value = false;

      showSnackbar(Get.context!, "coupon_code_not_valid".tr, "error");
      subTotal.value = cart.value.total;
      discount.value = 0.0;
      total.value = subTotal.value;
      couponCodeController.value.text = "";
    } else {
      isCouponCodeValid.value = true;

      subTotal.value = discountData.total;
      discount.value = discountData.discount;
      total.value = discountData.grandTotal;
      showSnackbar(Get.context!, "coupon_code_valid".tr, "info");
    }
    isCouponChecking.value = false;
  }

  void createOrder() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    final String? mobile = sharedPreferences.getString('mobile');

    if (mobile != null && mobile != "") {
      isOrderCreating.value = true;
      var planPurchaseHttpService = EshopHttpService();

      PaymentData tPaymentData = await planPurchaseHttpService.checkout(mobile,
          addressId.value, couponCodeController.value.text);
      paymentData.value = tPaymentData;

      if (paymentData.value.paymentUrl == "" ||
          paymentData.value.redirectUrl == "") {
        if ((total.value == 0 || subTotal.value == 0.0) &&
            (paymentData.value.refId != '' &&
                paymentData.value.orderId != '')) {
          showSnackbar(Get.context!, "payment_capture_success".tr, "info");

          Get.toNamed(AppRouteNames.otpVerificationSuccessRoute, arguments: [
            ASSETS_SUCCESSMARK,
            "purchase_success",
            "purchase_success_info",
            'home',
            false,
            AppRouteNames.homeRoute,
            ""
          ])?.then(
              (value) => Get.toNamed(AppRouteNames.homeRoute, arguments: [0]));
        } else {
          showSnackbar(Get.context!, "customer_support_message".tr, "error");
        }

        isOrderCreating.value = false;
      } else {
        isPaymentGatewayLoading.value = true;
        Get.toNamed(AppRouteNames.eshopPaymentPageRoute, arguments: [
          paymentData.value.paymentUrl,
          paymentData.value.redirectUrl,
          paymentData.value.paymentCheckUrl
        ])?.then((value) => checkOrderStatus(mobile));
      }
    } else {
      showSnackbar(Get.context!, "login_message".tr, "error");
      Get.offAllNamed(AppRouteNames.loginRoute);
    }
  }

  void changePaymentGatewayLoading(bool status) {
    paymentGatewayIsLoading.value = status;
  }

  paymentGatewayGoback(bool status) {
    Get.back(result: status);
  }

  void checkOrderStatus(String mobile) async {
    isOrderCreating.value = true;
    isPaymentGatewayLoading.value = true;
    var planPurchaseHttpService = EshopHttpService();
    bool isSuccess =
        await planPurchaseHttpService.checkOrderStatus(paymentData.value.refId);
    isOrderCreating.value = false;

    if (!isSuccess) {
      isPaymentGatewayLoading.value = false;
      showSnackbar(Get.context!, "payment_capture_error".tr, "error");
    } else {
      showSnackbar(Get.context!, "purchase_success".tr, "info");
      Get.toNamed(AppRouteNames.otpVerificationSuccessRoute, arguments: [
        ASSETS_SUCCESSMARK,
        "purchase_success",
        "purchase_success_info",
        'home',
        false,
        AppRouteNames.homeRoute,
        ""
      ]);
    }
  }

  Future<void> emptyCart() async {

    subTotal.value = cart.value.total;
    discount.value = 0.0;
    total.value = subTotal.value;

    cart.value = mapCart({});
  }


  Future<void> getCustomerAddressList() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    final String? mobile = sharedPreferences.getString('mobile');

    if (mobile != null && mobile != "") {
      isCustomerAddressListFetching.value = true;
      customerAddressList.value = [];
      var addressHttpService = new EshopHttpService();
      customerAddressList.value =
          await addressHttpService.getUserAddressess(mobile);
      isCustomerAddressListFetching.value = false;
    }
  }

  changeAddressId(int id) {
    print("id");
    print(id);
    addressId.value = id;
    update();
  }



  checkIfUserExists() async{
    if(!isUserExistanceChecking.value && mobileTextEditingController.value.text!=""){
      isUserExistanceChecking.value = true;
      customerAddressList.value = [];
      var addressHttpService = new EshopHttpService();
      bool doesExists =
          await addressHttpService.isProfileExist(mobileTextEditingController.value.text);
      isUserExistanceChecking.value = false;
      if(doesExists){
        var sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("mobile", mobileTextEditingController.value.text);
         Get.toNamed(AppRouteNames.eshopAddressRoute);

      }else{
        Get.toNamed(AppRouteNames.registerEnglishNameRoute,arguments: [AppRouteNames.eshopCartRoute]);

      }
    }
  }

  void setCategory(int id) {
    print("setCategory");
    print(id);
    int indx = -1;
    for (var i=0;i<mealCategories.length;i++){
      if(mealCategories[i].id==id){
        indx=i;
      }
    }

    if(indx>-1){
      currentMealCategoryId.value =  id;

      itemScrollController.scrollTo(index: indx, duration: Duration(milliseconds: 500));

    }

  }

  changeCategoryByIndex(int index) {
    currentMealCategoryId.value = mealCategories[index].id;

  }

}
