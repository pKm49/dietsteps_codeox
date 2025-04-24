import 'package:dietsteps/feature_modules/plan_purchase/models/payment_data.model.plan_purchase.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/default_values.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/valid_phoneverification_modes.constants.shared.dart';
import 'package:dietsteps/shared_module/models/my_subscription.model.shared.dart';
import 'package:dietsteps/shared_module/models/notification.model.shared.dart';
import 'package:dietsteps/shared_module/models/payment_gateway_data.model.shared.dart';
import 'package:dietsteps/shared_module/models/sendotp_credential.model.auth.dart';
import 'package:dietsteps/shared_module/models/user_data.model.shared.dart';
import 'package:dietsteps/shared_module/services/http-services/http.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/app_update_checker.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/local_storage.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
 import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedController extends GetxController {
  var selectedLanguage = "".obs;
  var mobile = "".obs;
  var isUserDataFetching = false.obs;
  var isNotificationsFetching = false.obs;
  var isSubscriptionsFetching = false.obs;
  var isDeviceTokenUpdating = false.obs;
  var userData = mapUserData({}).obs;
  var notifications = <AppNotification>[].obs;
  var mySubscriptions = <MySubscription>[].obs;
  var supportNumber = "+96522283543".obs;

  //  Mobile Verification
  var isOtpVerifying = false.obs;
  var isPlanActivating = false.obs;
  var isOtpSending = false.obs;
  var isAppointmentBooking = false.obs;

  var isPaymentGatewayLoading = false.obs;
  var isOrderDetailsFetching = false.obs;
  var paymentGatewayIsLoading = false.obs;
  var paymentCompletionData =  mapPaymentCompletionData({}).obs;
  Rx<TextEditingController> mobileTextEditingController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> getAccessToken()async{
    print(    "getAccessToken called called");
    var sharedHttpService = SharedHttpService();
    await sharedHttpService.getAccessToken();
    return true;
  }

  Future<void> setInitialScreen() async {
    var sharedHttpService = SharedHttpService();
    await sharedHttpService.getAccessToken();
    getSupportNumber();
    selectedLanguage.value = "";
    mobile.value = "";
    AppUpdateChecker appUpdateChecker = AppUpdateChecker();

    bool isUpdateAvailable = await appUpdateChecker.checkStatus();

    print("isUpdateAvailable");
    print(isUpdateAvailable);
    if (!isUpdateAvailable) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? tSelectedLanguage = prefs.getString('selectedLanguage');
      final String? tMobile = prefs.getString('mobile');

      if (tSelectedLanguage != null && tSelectedLanguage != '') {
        changeLanguage(tSelectedLanguage, false);
        selectedLanguage.value = tSelectedLanguage;
      }

      if (tMobile != null && tMobile != '') {
        mobile.value = tMobile;
      }

      if (mobile.value.isNotEmpty) {
        isUserDataFetching.value = true;
        userData.value = await sharedHttpService.getProfileData(mobile.value);
        mySubscriptions.value =
            await sharedHttpService.getMySubscriptions(mobile.value);
        print("user data fetched");
        print("mySubscriptions data fetched");
        isUserDataFetching.value = false;
        print(userData.value.id);
        print(userData.value.subscriptionRemainingDays);
        print(userData.value.subscriptionRemainingDays.toLowerCase());
        print(userData.value.subscriptionRemainingDays.toLowerCase().trim());
        print( userData
            .value.subscriptionRemainingDays
            .toLowerCase()
            .replaceAll(' ', '')
            .contains(
            "noactivesubscription").toString());
        // Decide route based on user data id and subscription status.
        if (userData.value.id != -1) {
          saveDeviceToken();
          Get.offAllNamed(AppRouteNames.homeRoute);
        } else {
          var sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("mobile", "");
          Get.toNamed(AppRouteNames.welcomeScreenRoute);
        }
      } else {
        debugPrint("no mobile set but language is set");
        Get.toNamed(AppRouteNames.welcomeScreenRoute);
      }
    }
  }

  changeMobile(String mobile){
    mobileTextEditingController.value.text = mobile;
  }

  Future<void> refetchUserData() async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tMobile = prefs.getString('mobile');

    if (tMobile != null && tMobile != '') {
      mobile.value = tMobile;

    try{
      var sharedHttpService = SharedHttpService();
      isUserDataFetching.value = true;
      mobile.value = tMobile;
      print("ref fetchUserData");
      print(tMobile);
      userData.value = await sharedHttpService.getProfileData(tMobile);
      mySubscriptions.value =
          await sharedHttpService.getMySubscriptions(mobile.value);
      isUserDataFetching.value = false;


    }catch(e,st){
      print("ref fetchUserData error");
      print(e);
      print(st);
      isUserDataFetching.value = false ;
    }

    }
  }

  updateUserData(UserData tUserData) {
    userData.value = tUserData;
  }

  saveDeviceToken() async {
    var sharedHttpService = SharedHttpService();
    String deviceToken = await getFirebaseMessagingToken();
    bool isSuccess = await sharedHttpService.saveDeviceToken(
        userData.value.mobile, deviceToken);
  }

  fetchUserData(String targetRoute, String tMobile) async {
    try{
      var sharedHttpService = SharedHttpService();
      isUserDataFetching.value = true;
      mobile.value = tMobile;
      print("fetchUserData");
      print(tMobile);
      userData.value = await sharedHttpService.getProfileData(tMobile);
      mySubscriptions.value =
      await sharedHttpService.getMySubscriptions(mobile.value);
      isUserDataFetching.value = false;
      print("userData");
      print(userData.value.id);
      print("userData.value.shift");
      print(userData.value.shift);
      print(userData.value.profilePictureUrl);
      if (userData.value.id != -1) {
        saveDeviceToken();
        if (targetRoute != "") {
          if(targetRoute==AppRouteNames.dislikeAuditRoute){
            Get.offAllNamed(targetRoute,arguments: [true]);
          }else{
            showSnackbar(Get.context!, "successfully_loggedin".tr, "info");
            Get.offAllNamed(targetRoute);
          }
        }
      } else {
        if (targetRoute != "") {
          showSnackbar(Get.context!, "something_wrong".tr, "error");
        }
      }
    }catch(e,st){
      print("fetchUserData error");
      print(e);
      print(st);
      Future.delayed(const Duration(milliseconds: 10));
      refetchUserData();
    }

  }

  Future<void> handleLogout() async {

    userData.value = mapUserData({});
    notifications.value = [];
    saveAuthTokenAndMobileToSharedPreference("","");
     removeToken();
    Get.offAllNamed(AppRouteNames.loginRoute);



  }

  Future<void> removeToken() async {
    var sharedHttpService = SharedHttpService();
    String deviceToken = await getFirebaseMessagingToken();
    await sharedHttpService.removeDeviceToken(deviceToken);

  }


  Future<void> setDeviceToken() async {
    isDeviceTokenUpdating.value = true;
    await Future<void>.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    String firebaseToken = await getFirebaseMessagingToken();
  }

  Future<String> getFirebaseMessagingToken() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      String firebaseMessagingToken =
          await FirebaseMessaging.instance.getToken() ?? "";

      return firebaseMessagingToken;
    } catch (e) {
      return e.toString();
    }
  }

  changeLanguage(String language, bool isNavigation) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('selectedLanguage', language);

    selectedLanguage.value = language;
    Get.updateLocale(Locale(selectedLanguage.value));
    if (isNavigation) {
      Get.toNamed(AppRouteNames.loginRoute);
    }
  }


  Future<void> getCustomerSubscriptions() async {
    isSubscriptionsFetching.value = true;
    var sharedHttpService = SharedHttpService();
    mySubscriptions.value =
    await sharedHttpService.getMySubscriptions(userData.value.mobile);
    isSubscriptionsFetching.value = false;
  }

  Future<void> getNotifications() async {
    isNotificationsFetching.value = true;
    var sharedHttpService = SharedHttpService();
    notifications.value =
        await sharedHttpService.getNotifications(userData.value.mobile);
    isNotificationsFetching.value = false;
  }

  sendOtp(bool isResetPassword, bool isNavigationRequired) async {

    if(mobileTextEditingController.value.text.toString().length<7){
      showSnackbar(Get.context!, "enter_valid_mobile".tr, "error");
    }else{
      // showSnackbar(Get.context!, "otp_sent".tr, "info");
      // Get.toNamed(AppRouteNames.otpVerificationOtpInputRoute,
      //     arguments: [
      //       isResetPassword? VALIDPHONEVERIFICATION_MODES.reset_password:
      //       VALIDPHONEVERIFICATION_MODES.register]);
      isOtpSending.value = true;
      var sharedHttpService = new SharedHttpService();
      bool isSuccess = await sharedHttpService.sendOtp(
          SendOTPCredential(mobile: "+965${mobileTextEditingController.value.text}", isResetPassword: isResetPassword));
      isOtpSending.value = false;

      if(isSuccess){
        showSnackbar(Get.context!, "otp_sent".tr, "info");
        Get.toNamed(AppRouteNames.otpVerificationOtpInputRoute,
            arguments: [
              isResetPassword? VALIDPHONEVERIFICATION_MODES.reset_password:
              VALIDPHONEVERIFICATION_MODES.register]);
      }
    }
  }

  verifyOtp (String otp, bool isResetPassword) async {
    if(otp.length!=6){
      showSnackbar(Get.context!, "enter_valid_otp".tr, "error");
    }else{
      // showSnackbar(Get.context!, "otp_verified_success".tr, "info");
      // if(isResetPassword){
      //   Get.offNamed(AppRouteNames.resetPasswordNewpasswordRoute,
      //       arguments: [mobileTextEditingController.value.text]);
      // }else{
      //   Get.offNamed(AppRouteNames.otpVerificationSuccessRoute,arguments: [
      //     ASSETS_SUCCESSMARK,
      //     "otp_verified".tr,
      //     "otp_verified_message".tr,
      //     'continue'.tr,
      //     true,
      //     AppRouteNames.addressAuditRoute,
      //     mobileTextEditingController.value.text
      //   ]) ;
      // }

      isOtpVerifying.value = true;
      var sharedHttpService = new SharedHttpService();
      bool isVerificationSuccess = await sharedHttpService.verifyOtp( "+965${mobileTextEditingController.value.text}",otp);
      isOtpVerifying.value = false;

      if(isVerificationSuccess){
        showSnackbar(Get.context!, "otp_verified".tr, "info");

        if(isResetPassword){
          Get.offNamed(AppRouteNames.resetPasswordNewpasswordRoute,arguments: [mobileTextEditingController.value.text]);
        }else{

          Get.toNamed(AppRouteNames.otpVerificationSuccessRoute,arguments: [
            ASSETS_SUCCESSMARK,
            "otp_verified",
            "otp_verified_message",
            'continue',
            true,
            AppRouteNames.addressAuditRoute,
            mobileTextEditingController.value.text
          ]) ;
        }
      }

    }

  }

  getSupportNumber() async {
    var sharedHttpService = SharedHttpService();
    String tSupoortNumber = await sharedHttpService.getSupportNumber( );

    if(tSupoortNumber !=""){
      supportNumber.value = tSupoortNumber;
    }else{
      supportNumber.value = DefaultSupportNumber;
    }
  }

  bookDietitionAppointment() async {
    isAppointmentBooking.value = true;
    var sharedHttpService = SharedHttpService();
    bool isSuccess = await sharedHttpService.bookDietitionAppointment(userData.value.mobile);
    isAppointmentBooking.value = false;

    if(isSuccess){
      showSnackbar(Get.context!, "appointment_booking_request_recieved_successfully".tr, "info");
      showSnackbar(Get.context!, "our_rep_will_contact".tr, "info");}
  }

  void activatePlan(int subscriptionId) async {
    if(!isPlanActivating.value){
      if(subscriptionId != -1){
        isPlanActivating.value = true;
        var sharedHttpService = SharedHttpService();
        bool isSuccess = await sharedHttpService
            .activateSubscription(subscriptionId);
        isPlanActivating.value = false;
        if(isSuccess){
          showSnackbar(Get.context!, "plan_activated_successfully".tr, "info");
          fetchUserData("", userData.value.mobile);
        }else{
          showSnackbar(Get.context!, "something_wrong".tr, "error");
        }
        print("activatePlan");
        print(isSuccess);
      }
    }

  }

  void getPaymentLink(int subscriptionId) async {
    // showSnackbar(Get.context!, "customer_support_message".tr, "error");

    if(!isOrderDetailsFetching.value){
      if(subscriptionId != -1){
        isOrderDetailsFetching.value = true;
        var sharedHttpService = SharedHttpService();
         paymentCompletionData.value =  await sharedHttpService.getPaymentLink( subscriptionId);
        isOrderDetailsFetching.value = false;

        if (paymentCompletionData.value.transactionUrl == "" ||
            paymentCompletionData.value.orderReference == "") {
          showSnackbar(Get.context!, "customer_support_message".tr, "error");
        } else{
          Get.toNamed(AppRouteNames.paymentCompleteCheckoutRoute);
        }
      }
    }


  }


  void checkOrderStatus() async {
    isPaymentGatewayLoading.value = true;
    var sharedHttpService = SharedHttpService();
    bool isSuccess =  await sharedHttpService.checkOrderStatus( paymentCompletionData.value.paymentReference);

    if (!isSuccess) {
      isPaymentGatewayLoading.value = false;
      showSnackbar(Get.context!, "payment_capture_error".tr, "error");
    } else {
      showSnackbar(Get.context!, "payment_capture_success".tr, "info");
      List<MySubscription> myUnPaidSubs = mySubscriptions.where((p0) => p0.status=='not paid').toList();
      if(myUnPaidSubs.isNotEmpty){
        activatePlan( paymentCompletionData.value.subscriptionId);
      }
      Get.toNamed(AppRouteNames.otpVerificationSuccessRoute,arguments: [
        ASSETS_SUCCESSMARK,"subscription_success","subscription_success_info",
        'home',false,AppRouteNames.homeRoute,""
      ]) ;
    }
  }

  void changePaymentGatewayLoading(bool status) {
    paymentGatewayIsLoading.value = status;
  }
  paymentGatewayGoback(bool status) {
    Get.back(result: status);
  }

  void redirectToPaymentPage() {
    Get.toNamed(AppRouteNames.paymentCompletePageRoute, arguments: [
      paymentCompletionData.value.transactionUrl,
      "",
      paymentCompletionData.value.paymentStatusUrl,
    ])?.then((value) => checkOrderStatus());
  }

}
