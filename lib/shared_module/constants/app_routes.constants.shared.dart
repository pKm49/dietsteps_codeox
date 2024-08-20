import 'package:dietsteps/feature_modules/address/ui/pages/audit_address.page.address.dart';
import 'package:dietsteps/feature_modules/address/ui/pages/my_address_list.page.address.dart';
import 'package:dietsteps/feature_modules/auth/ui/login.page.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/register/register_aboutme_page.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/register/register_name_english.page.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/register/register_origin_page.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/register/register_other_data.page.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/reset-password/reset_password.page.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/reset-password/reset_password_aboutme_page.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/welcome.page.auth.dart';
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
import 'package:dietsteps/shared_module/ui/pages/otp_verification_mobile_input.page.shared.dart';
import 'package:dietsteps/shared_module/ui/pages/otp_verification_otp_input.page.shared.dart';
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
    page: () => const WelcomePage_Auth(),
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
];


