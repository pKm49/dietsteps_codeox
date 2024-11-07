import 'package:dietsteps/feature_modules/address/ui/pages/audit_address.page.address.dart';
import 'package:dietsteps/feature_modules/address/ui/pages/my_address_list.page.address.dart';
import 'package:dietsteps/feature_modules/auth/ui/login.page.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/meals_subs/meals_details.page.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/meals_subs/meals_list.page.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/register/register_aboutme_page.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/register/register_name_english.page.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/register/register_origin_page.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/register/register_other_data.page.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/reset-password/reset_password.page.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/reset-password/reset_password_aboutme_page.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/welcome.page.auth.dart';
import 'package:dietsteps/feature_modules/e_shop/ui/address_select.page.eshop.dart';
import 'package:dietsteps/feature_modules/e_shop/ui/cart.page.eshop.dart';
import 'package:dietsteps/feature_modules/e_shop/ui/checkout.page.eshop.dart';
import 'package:dietsteps/feature_modules/e_shop/ui/meals_details.page.eshop.dart';
import 'package:dietsteps/feature_modules/e_shop/ui/meals_list.page.eshop.dart';
import 'package:dietsteps/feature_modules/e_shop/ui/order_list.page.eshop.dart';
import 'package:dietsteps/feature_modules/e_shop/ui/payment_gateway_webview.page.eshop.dart';
import 'package:dietsteps/feature_modules/my_subscription/ui/pages/freeze_subscription.page.my_subscription.dart';
import 'package:dietsteps/feature_modules/my_subscription/ui/pages/meal_selection.page.my_subscription.dart';
import 'package:dietsteps/feature_modules/plan_purchase/ui/pages/payment_gateway_webview.page.plan_purchase.dart';
import 'package:dietsteps/feature_modules/plan_purchase/ui/pages/select_date.page.plan_purchase.dart';
import 'package:dietsteps/feature_modules/profile/ui/pages/my_dislikes_list.page.profile.dart';
import 'package:dietsteps/feature_modules/profile/ui/pages/my_subscriptions_list.page.profile.dart';
import 'package:dietsteps/feature_modules/plan_purchase/ui/pages/checkout.page.plan_purchase.dart';
import 'package:dietsteps/feature_modules/plan_purchase/ui/pages/select_plan.page.plan_purchase.dart';
import 'package:dietsteps/feature_modules/plan_purchase/ui/pages/select_plan_category.page.plan_purchase.dart';
import 'package:dietsteps/feature_modules/profile/ui/pages/about.page.profile.dart';
import 'package:dietsteps/feature_modules/profile/ui/pages/edit_profile.page.profile.dart';
import 'package:dietsteps/feature_modules/profile/ui/pages/my_allergies_list.page.profile.dart';
import 'package:dietsteps/feature_modules/profile/ui/pages/referral_points.page.profile.dart';
import 'package:dietsteps/feature_modules/profile/ui/pages/settings.page.profile.dart';
import 'package:dietsteps/gif_splash.page.core.dart';
import 'package:dietsteps/landing.page.core.dart';
import 'package:dietsteps/notifications.page.core.dart';
import 'package:dietsteps/privacy.page.core.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/ui/pages/checkout.page.shared.dart';
import 'package:dietsteps/shared_module/ui/pages/otp_verification_mobile_input.page.shared.dart';
import 'package:dietsteps/shared_module/ui/pages/otp_verification_otp_input.page.shared.dart';
import 'package:dietsteps/shared_module/ui/pages/payment_gateway_webview.page.shared.dart';
import 'package:dietsteps/shared_module/ui/pages/success_confirmation.page.shared.dart';
import 'package:dietsteps/terms.page.core.dart';
import 'package:get/get.dart';

AppPages() => [

  GetPage(
    name: AppRouteNames.splashScreenRoute,
    page: () => const GifSplashPage_Core(),
  ),
  GetPage(
    name: AppRouteNames.welcomeScreenRoute,
    page: () =>   WelcomePage_Auth(),
  ),
  GetPage(
    name: AppRouteNames.loginRoute,
    page: () => const LoginPage_Auth(),
  ),
  GetPage(
    name: AppRouteNames.registerEnglishNameRoute,
    page: () =>   RegisterNameEnglishPage_Auth(),
  ),
  GetPage(
    name: AppRouteNames.registerOtherDataRoute,
    page: () =>   RegisterOtherDataPage_Auth(),
  ),
  GetPage(
    name: AppRouteNames.otpVerificationMobileInputRoute,
    page: () =>   OtpVerificationMobileInputPage_Shared(),
  ),
  GetPage(
    name: AppRouteNames.otpVerificationOtpInputRoute,
    page: () =>   OtpVerificationOtpInputPage_Shared(),
  ),
  GetPage(
    name: AppRouteNames.otpVerificationSuccessRoute,
    page: () =>   SuccessConfirmationPage_Shared(),
  ),
  GetPage(
    name: AppRouteNames.addressAuditRoute,
    page: () =>   AuditAddressPage_Address(),
  ),
  GetPage(
    name: AppRouteNames.registerAboutMeRoute,
    page: () =>   RegisterAboutmePage_Auth(),
  ),

  GetPage(
    name: AppRouteNames.registerOriginRoute,
    page: () =>   RegisterOriginPage_Auth(),
  ),

  GetPage(
    name: AppRouteNames.resetPasswordNewpasswordRoute,
    page: () =>   ResetPasswordPage_auth(),
  ),

  GetPage(
    name: AppRouteNames.resetPasswordAboutMeRoute,
    page: () =>   ResetPasswordAboutMePage_Auth(),
  ),
  GetPage(
    name: AppRouteNames.menuItemDetailsRoute,
    page: () =>   MealsDetailsPage_Auth(),
  ),

  GetPage(
    name: AppRouteNames.menuListRoute,
    page: () =>   MealsListPage_Auth(),
  ),


  GetPage(
    name: AppRouteNames.planPurchaseSubscriptionPlansCategoryListRoute,
    page: () =>   SelectPlanCategoryPage_PlanPurchase(),
  ),
  GetPage(
    name: AppRouteNames.planPurchaseSubscriptionPlansCategoryListRoute,
    page: () =>   SelectPlanCategoryPage_PlanPurchase(),
  ),

  GetPage(
    name: AppRouteNames.planPurchaseSubscriptionPlansListRoute,
    page: () =>   SelectPlanPage_PlanPurchase(),
  ),

  GetPage(
    name: AppRouteNames.planPurchaseCheckoutRoute,
    page: () =>   CheckoutPage_PlanPurchase(),
  ),

  GetPage(
    name: AppRouteNames.homeRoute,
    page: () =>   LandingPage_Core(),
  ),
  GetPage(
    name: AppRouteNames.notificationsRoute,
    page: () =>   NotificationsPage_Core(),
  ),
  GetPage(
    name: AppRouteNames.mealSelectionRoute,
    page: () =>   MealSelectionPage_MySubscription(),
  ),
  // GetPage(
  //   name: AppRouteNames.freezeSubscriptionRoute,
  //   page: () =>   FreezeSubscriptionPage_MySubscription(),
  // ),
  GetPage(
    name: AppRouteNames.updateProfileRoute,
    page: () =>   EditProfilePage_Profile(),
  ),
  GetPage(
    name: AppRouteNames.mySubscriptionsRoute,
    page: () =>   MySubscriptionListPage_Profile(),
  ),
  GetPage(
    name: AppRouteNames.addressListRoute,
    page: () =>   MyAddressListPage_Address(),
  ),
  GetPage(
    name: AppRouteNames.allergyAuditRoute,
    page: () =>   MyAllergiesListPage_Profile(),
  ),
  GetPage(
    name: AppRouteNames.dislikeAuditRoute,
    page: () =>   MyDislikesListPage_Profile(),
  ),
  GetPage(
    name: AppRouteNames.refferalProgramRoute,
    page: () =>   ReferralPointsPage_Profile(),
  ),
  GetPage(
    name: AppRouteNames.aboutPageRoute,
    page: () =>   AboutPage_Profile(),
  ),
  GetPage(
    name: AppRouteNames.settingsPageRoute,
    page: () =>   SettingsPage_Profile(),
  ),
  GetPage(
    name: AppRouteNames.termsRoute,
    page: () =>   TermsPage_Core(),
  ),
  GetPage(
    name: AppRouteNames.privacyRoute,
    page: () =>   PrivacyPage_Core(),
  ),
  GetPage(
    name: AppRouteNames.planPurchaseSetInitialDateRoute,
    page: () =>   SelectInitialDatePage_PlanPurchase(),
  ),
  GetPage(
    name: AppRouteNames.paymentPageRoute,
    page: () =>   PaymentGatewayWebView_PlanPurchase(),
  ),

  GetPage(
    name: AppRouteNames.paymentCompletePageRoute,
    page: () =>   PaymentGatewayWebView_Shared(),
  ),

  GetPage(
    name: AppRouteNames.paymentCompleteCheckoutRoute,
    page: () =>   CheckoutPage_Shared(),
  ),


  GetPage(
    name: AppRouteNames.eshopMenuListRoute,
    page: () =>   MealsListPage_Eshop(),
  ),
  GetPage(
    name: AppRouteNames.eshopMenuItemDetailsRoute,
    page: () =>   MealsDetailsPage_Eshop(),
  ),
  GetPage(
    name: AppRouteNames.eshopCartRoute,
    page: () =>   CartPage_Eshop(),
  ),

  GetPage(
    name: AppRouteNames.eshopCheckoutRoute,
    page: () =>   CheckoutPage_Eshop(),
  ),

  GetPage(
    name: AppRouteNames.eshopAddressRoute,
    page: () =>   AddressSelect_Eshop(),
  ),

  GetPage(
    name: AppRouteNames.eshopPaymentPageRoute,
    page: () =>   PaymentGatewayWebView_Eshop(),
  ),

  GetPage(
    name: AppRouteNames.eshopOrdersPageRoute,
    page: () =>   OrderListPage_Eshop() ,
  ),


];

