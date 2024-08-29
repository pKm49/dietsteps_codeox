import 'package:dietsteps/feature_modules/plan_purchase/models/discount_data.model.plan_purchase.dart';
import 'package:dietsteps/feature_modules/plan_purchase/models/payment_data.model.plan_purchase.dart';
import 'package:dietsteps/feature_modules/plan_purchase/models/plan.model.plan_purchase.dart';
import 'package:dietsteps/feature_modules/plan_purchase/models/plan_category.model.plan_purchase.dart';
import 'package:dietsteps/feature_modules/plan_purchase/models/purchase_data.model.plan_purchase.dart';
import 'package:dietsteps/feature_modules/plan_purchase/services/http.services.plan_purchase.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/default_values.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PlanPurchaseController extends GetxController {
  Rx<TextEditingController> couponCodeController = TextEditingController().obs;
  final sharedController = Get.find<SharedController>();

  var subscriptionCategories = <SubscriptionPlanCategory>[].obs;
  var subscriptionDurations = <int>[].obs;
  var subscriptions = <SubscriptionPlan>[].obs;
  var isSubscriptionsFetching = false.obs;
  var isCategoriesFetching = false.obs;
  Rx<SubscriptionPlanCategory> currentCategory = mapSubscriptionCategory({}).obs;
  Rx<SubscriptionPlan> currentSubscription = mapSubscriptionItem({}).obs;

  var paymentData = mapPaymentData({}).obs;
  var subTotal = (0.0).obs;
  var discount = (0.0).obs;
  var total = (0.0).obs;
  var subscriptionId = (-1).obs;
  var isCouponChecking = false.obs;
  var isCouponCodeValid = false.obs;
  var isOrderCreating = false.obs;
  var isDateChecking = false.obs;
  var isPaymentGatewayLoading = false.obs;
  var paymentGatewayIsLoading = false.obs;


  // calendar
  var firstWeekDays = <DateTime>[].obs;
  var secondWeekDays = <DateTime>[].obs;
  var thirdWeekDays = <DateTime>[].obs;
  var fourthWeekDays = <DateTime>[].obs;
  var fifthWeekDays = <DateTime>[].obs;
  var sixthWeekDays = <DateTime>[].obs;
  var minimumPossibleDate = DateTime.now().obs;
  var selectedDate = DefaultInvalidDate.obs;
  var currentMonth = DateTime (DateTime.now().year,DateTime.now().month,1).obs;

  @override
  void onInit() {
    super.onInit();
    minimumPossibleDate.value = DateTime.now().add(Duration(days: 2));
     setCurrentMonthWeekDays();
    couponCodeController.value.addListener(() {
      resetCouponCode();
    });
  }

  Future<void> getSubscriptionCategories() async {
    isCategoriesFetching.value = true;
    subscriptionCategories.value = [];
    isPaymentGatewayLoading.value = false;
    var planPurchaseHttpService = new PlanPurchaseHttpService();
    subscriptionCategories.value =
    await planPurchaseHttpService.getSubscriptionCategories();
    isCategoriesFetching.value = false;
    update();
    if (subscriptionCategories.isEmpty) {
      currentSubscription.value = mapSubscriptionItem({});
      subscriptionDurations.value = [];
      subscriptions.value = [];
      subTotal.value = 0.0;
      total.value = 0.0;
      discount.value = 0.0;
    }else{
      changeCategory(subscriptionCategories[0]);

    }
  }

  changeCategory(SubscriptionPlanCategory subscriptionPlanCategory) {
    currentCategory.value = subscriptionPlanCategory;
  }

  void changeSubscription(SubscriptionPlan subscription) {

    currentSubscription.value = subscription;
    subTotal.value = currentSubscription.value.price;
    discount.value = 0.0;
    total.value = subTotal.value- discount.value;
  }
  Future<void> getSubscriptionsByCategory(  ) async {
    isPaymentGatewayLoading.value = false;
    isSubscriptionsFetching.value = true;
    subscriptions.value = [];
    var planPurchaseHttpService = PlanPurchaseHttpService();
    subscriptions.value = await planPurchaseHttpService
        .getSubscriptionsByCategory(currentCategory.value);
    update();

    subTotal.value = 0.0;
    total.value = 0.0;
    discount.value = 0.0;

    currentSubscription.value = mapSubscriptionItem({});
    isSubscriptionsFetching.value = false;
  }

  resetCouponCode(){
    isCouponCodeValid.value = false;
    subTotal.value = currentSubscription.value.price;
    discount.value = 0.0;
    total.value = subTotal.value;
  }

  Future<void> checkCouponValidity() async {
    isCouponChecking.value = true;
    isCouponCodeValid.value = false;

    var planPurchaseHttpService = PlanPurchaseHttpService();
    DiscountData discountData = await planPurchaseHttpService.verifyCoupon(
        currentSubscription.value.id,
        couponCodeController.value.text);

    if (!discountData.isValid ) {
      isCouponCodeValid.value = false;

      showSnackbar(Get.context!, "coupon_code_not_valid".tr, "error");
      subTotal.value = currentSubscription.value.price;
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
      var planPurchaseHttpService = PlanPurchaseHttpService();

      PaymentData tPaymentData = await planPurchaseHttpService.createOrder( PurchaseData(
          planCategoryId: currentCategory.value.id,
          planId: currentSubscription.value.id,
          startDate: selectedDate.value, promoCode: couponCodeController.value.text,
          mobile: mobile
      ) );
      paymentData.value = tPaymentData;

      if (paymentData.value.paymentUrl == "" ||
          paymentData.value.redirectUrl == "") {
        if ((total.value == 0 || total.value == 0.0) && (paymentData.value.refId!='' && paymentData.value.orderId!='')) {
          showSnackbar(Get.context!, "payment_capture_success".tr, "info");
          activatePlan(paymentData.value.subscriptionId );
          Get.toNamed(AppRouteNames.otpVerificationSuccessRoute,arguments: [
            ASSETS_SUCCESSMARK,"subscription_success","subscription_success_info",
            'home',false,AppRouteNames.homeRoute,""
          ])?.then((value) => Get.toNamed(AppRouteNames.homeRoute,arguments: [0]));
        }else{
          showSnackbar(Get.context!, "customer_support_message".tr, "error");
        }

        isOrderCreating.value = false;
      } else {
        isPaymentGatewayLoading.value = true;
        Get.toNamed(AppRouteNames.paymentPageRoute, arguments: [
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

  void checkDateStatus( ) async {

    var sharedPreferences = await SharedPreferences.getInstance();
    final String? mobile = sharedPreferences.getString('mobile');

    if (mobile != null && mobile != "" && !isDateChecking.value) {
      isDateChecking.value = true;
      var planPurchaseHttpService = PlanPurchaseHttpService();
      String dateString = DateFormat("yyyy-MM-dd").format(selectedDate.value);
      bool isSuccess = await planPurchaseHttpService
          .checkDateAvailability(dateString,mobile,currentSubscription.value.id);
      isDateChecking.value = false;

      if (isSuccess) {
        isDateChecking.value = false;
        Get.toNamed(AppRouteNames.planPurchaseCheckoutRoute);
      }
    }


  }

  void checkOrderStatus(String mobile) async {
    isOrderCreating.value = true;
    isPaymentGatewayLoading.value = true;
    var planPurchaseHttpService = PlanPurchaseHttpService();
    bool isSuccess = await planPurchaseHttpService
        .checkOrderStatus(paymentData.value.refId);
    isOrderCreating.value = false;

    if (!isSuccess) {
      isPaymentGatewayLoading.value = false;
      showSnackbar(Get.context!, "payment_capture_error".tr, "error");
    } else {
      showSnackbar(Get.context!, "payment_capture_success".tr, "info");
      activatePlan(paymentData.value.subscriptionId );
      Get.toNamed(AppRouteNames.otpVerificationSuccessRoute,arguments: [
        ASSETS_SUCCESSMARK,"subscription_success","subscription_success_info",
        'home',false,AppRouteNames.homeRoute,""
      ]) ;
    }
  }

  void activatePlan(int subscriptionId ) async {
    if(subscriptionId != -1){
      var planPurchaseHttpService = PlanPurchaseHttpService();
      bool isSuccess = await planPurchaseHttpService
          .activateSubscription(subscriptionId);

      resetData();
    }

  }

  paymentGatewayGoback(bool status) {
    Get.back(result: status);
  }

  void changePaymentGatewayLoading(bool status) {
    paymentGatewayIsLoading.value = status;
  }

  void resetData() {
    couponCodeController.value.text = "";
    currentSubscription.value = mapSubscriptionItem({});
    isPaymentGatewayLoading.value = false;
    isSubscriptionsFetching.value = false;
    isCategoriesFetching.value = false;
    currentCategory.value = mapSubscriptionCategory({});
    paymentData.value = mapPaymentData({});
    subTotal.value = (0.0);
    discount.value = (0.0);
    total.value = (0.0);
    isCouponChecking.value = false;
    isOrderCreating.value = false;
    paymentGatewayIsLoading.value = false;
    isCouponCodeValid.value = false;
    couponCodeController.value.text = "";
  }

  void setSelectedDate(DateTime date) {

    selectedDate.value = date ;

  }



  void previousMonth() {
    var newDate = DateTime(currentMonth.value.year, currentMonth.value.month - 1, currentMonth.value.day);
    currentMonth.value = newDate;
    setCurrentMonthWeekDays();

  }

  void nextMonth() {
    var newDate = DateTime(currentMonth.value.year, currentMonth.value.month + 1, currentMonth.value.day);
    currentMonth.value = newDate;
    setCurrentMonthWeekDays();

  }

  setCurrentMonthWeekDays() {

    List<DateTime> weekDays = [];
    DateTime weekStartDate = getDate(currentMonth.value.subtract(Duration(days: currentMonth.value.weekday))) ;
    DateTime weekEndDate = getDate(currentMonth.value.add(Duration(days: DateTime.daysPerWeek - (currentMonth.value.weekday+1))));

    if(weekStartDate.month < currentMonth.value.month && weekEndDate.month < currentMonth.value.month){
      weekStartDate = currentMonth.value;
      weekEndDate = currentMonth.value.add(Duration(days: 6));
    }

    firstWeekDays.clear();
    secondWeekDays.clear();
    thirdWeekDays.clear();
    fourthWeekDays.clear();
    fifthWeekDays.clear();
    sixthWeekDays.clear();
    for (int index = 1; index <= 6; index++) {
      weekDays=[];
      if (index != 1) {
        weekStartDate = weekStartDate.add(Duration(days:   7));
        weekEndDate = weekEndDate.add(Duration(days:   7));
      }

      for (int i = 0; i <= weekEndDate
          .difference(weekStartDate)
          .inDays; i++) {
        weekDays.add(weekStartDate.add(Duration(days: i)));
      }

      switch (index){
        case 1:{
          firstWeekDays.addAll(weekDays);
          break;
        }
        case 2:
          {
            secondWeekDays.addAll(weekDays);
            break;
          }
        case 3:
          {
            thirdWeekDays.addAll(weekDays);
            break;
          }
        case 4:
          {
            fourthWeekDays.addAll(weekDays);
            break;
          }
        case 5:
          {
            fifthWeekDays.addAll(weekDays);
            break;
          }
        case 6:
          {
            sixthWeekDays.addAll(weekDays);
            break;
          }
      }

    }

  }

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  Future<void> planChoiceSelected() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    final String? mobile = sharedPreferences.getString('mobile');

    if (mobile != null && mobile != "") {
      Get.toNamed(AppRouteNames.planPurchaseSetInitialDateRoute);
    }else{
      showSnackbar(Get.context!, "login_message".tr, "info");
      Get.toNamed(AppRouteNames.loginRoute);
    }

  }

}
