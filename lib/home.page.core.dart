import 'dart:ui';

import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/update_profile_pic.profile.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class HomePage_Core extends StatefulWidget {
  HomePage_Core({super.key});

  @override
  State<HomePage_Core> createState() => _HomePage_CoreState();
}

class _HomePage_CoreState extends State<HomePage_Core> {
  final sharedController = Get.find<SharedController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedController.fetchUserData("", sharedController.userData.value.mobile);
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openWhatsapp();
        },
        child: Icon(Ionicons.logo_whatsapp, color: APPSTYLE_BackgroundWhite),
        backgroundColor: APPSTYLE_WhatsappGreen,
        shape: const CircleBorder(),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(-.2, 0),
            image: AssetImage(ASSETS_HOME_BG),
            fit: BoxFit.cover,
          ),
        ),
        width: screenwidth,
        height: screenheight,
        child: SafeArea(
          child: Obx(
            () => Column(
              children: [
                Container(
                  width: screenwidth,
                  height: (screenwidth * .13) + (APPSTYLE_SpaceMedium * 2),
                  padding: EdgeInsets.all(APPSTYLE_SpaceMedium),
                  margin: EdgeInsets.only(bottom: APPSTYLE_SpaceMedium),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Container(
                      //     decoration: APPSTYLE_BorderedContainerDarkMediumDecoration.copyWith(
                      //         borderRadius: BorderRadius.circular(1000),
                      //         color: APPSTYLE_BackgroundWhite
                      //     ),
                      //     padding: APPSTYLE_ExtraSmallPaddingAll,
                      //     width: screenwidth*.13,
                      //     child: Image.asset(ASSETS_DEFAULTPROFILEPIC,)),
                      // addHorizontalSpace(APPSTYLE_SpaceSmall),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              (Localizations.localeOf(context)
                                          .languageCode
                                          .toString() ==
                                      'ar')
                                  ? 'hey_username'.tr.replaceAll(
                                      'username',
                                      "${sharedController
                                              .userData.value.firstNameArabic} ${sharedController
                                              .userData.value.lastNameArabic}")
                                  : 'hey_username'.tr.replaceAll(
                                      'username',
                                      "${sharedController
                                              .userData.value.firstName} ${sharedController
                                              .userData.value.lastName}"),
                              textAlign: TextAlign.start,
                              style: getBodyMediumStyle(context).copyWith(
                                  color: APPSTYLE_BackgroundWhite,
                                  fontWeight: APPSTYLE_FontWeightBold),
                            ),
                          ),
                          // FittedBox(
                          //   fit: BoxFit.scaleDown,
                          //   child: Text(
                          //     getGreetingText().tr,
                          //     textAlign: TextAlign.start,
                          //     style: getLabelLargeStyle(context).copyWith(
                          //       color: APPSTYLE_BackgroundWhite,
                          //     ),
                          //   ),
                          // ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text("#${sharedController.userData.value.customerCode.toString()}",
                              textAlign: TextAlign.start,
                              style: getLabelLargeStyle(context).copyWith(
                                color: APPSTYLE_BackgroundWhite,
                              ),
                            ),
                          ),
                        ],
                      )),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRouteNames.notificationsRoute);
                        },
                        child: Badge(
                          backgroundColor:
                              sharedController.notifications.isNotEmpty
                                  ? APPSTYLE_BackgroundWhite
                                  : Colors.transparent,
                          child: Icon(Ionicons.notifications_outline,
                              color: APPSTYLE_BackgroundWhite,
                              size: APPSTYLE_FontSize24),
                        ),
                      ),
                      addHorizontalSpace(APPSTYLE_SpaceMedium),
                      InkWell(
                        onTap: () {
                         openDialer();
                        },
                        child: Icon(Ionicons.call_outline,
                            color: APPSTYLE_BackgroundWhite,
                            size: APPSTYLE_FontSize24),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: ListView(
                  children: [
                    addVerticalSpace(APPSTYLE_SpaceLarge),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: screenwidth * .7,
                            height: screenheight * .45,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  height: screenheight * .45,
                                  width: screenwidth * .7,
                                  margin: const EdgeInsets.only(top: 70),
                                  decoration:
                                      APPSTYLE_ShadowedContainerSmallDecoration
                                          .copyWith(
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                                Container(
                                  height: screenheight * .45,
                                  width: screenwidth * .7,
                                  margin: const EdgeInsets.only(top: 70),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        APPSTYLE_BorderRadiusSmall),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10, sigmaY: 10),
                                      child: Container(
                                        decoration:
                                            APPSTYLE_ShadowedContainerSmallDecoration
                                                .copyWith(
                                                    color: Colors.transparent),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: screenheight * .45,
                                  width: screenwidth * .7,
                                  padding: APPSTYLE_MediumPaddingAll,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Visibility(
                                        visible: !sharedController
                                            .isUserDataFetching.value,
                                        child: UpdateProfilePic(
                                          onClick: () {
                                            Get.toNamed(AppRouteNames
                                                .updateProfileRoute);
                                          },
                                          borderColor: APPSTYLE_BackgroundWhite,
                                          profilePictureUrl: sharedController
                                              .userData.value.profilePictureUrl,
                                        ),
                                      ),
                                      Visibility(
                                        visible: sharedController
                                            .isUserDataFetching.value,
                                        child: Shimmer.fromColors(
                                          baseColor: APPSTYLE_Grey20,
                                          highlightColor: APPSTYLE_Grey40,
                                          child: Container(
                                            height: screenwidth * .3,
                                            width: screenwidth * .3,
                                            decoration:
                                                APPSTYLE_BorderedContainerExtraSmallDecoration
                                                    .copyWith(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(1000),
                                                        border: Border.all(
                                                            color:
                                                                APPSTYLE_BackgroundWhite,
                                                            width: 1),
                                                        color: APPSTYLE_Grey20),
                                          ),
                                        ),
                                      ),

                                      // SUbscription name widget
                                      addVerticalSpace(APPSTYLE_SpaceLarge),
                                      Visibility(
                                        visible: !sharedController.userData
                                                .value.subscriptionRemainingDays
                                                .toLowerCase()
                                                .replaceAll(' ', '')
                                                .contains(
                                                    "noactivesubscription") &&
                                            !sharedController
                                                .isUserDataFetching.value,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            (Localizations.localeOf(
                                                            context)
                                                        .languageCode
                                                        .toString() ==
                                                    'ar')
                                                ? sharedController
                                                    .userData
                                                    .value
                                                    .subscriptionNameArabic
                                                : sharedController.userData
                                                    .value.subscriptionName,
                                            textAlign: TextAlign.start,
                                            style: getHeadlineLargeStyle(
                                                    context)
                                                .copyWith(
                                                    color:
                                                        APPSTYLE_BackgroundWhite,
                                                    fontWeight:
                                                        APPSTYLE_FontWeightBold),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: sharedController.userData.value
                                                .subscriptionRemainingDays
                                                .toLowerCase()
                                                .replaceAll(' ', '')
                                                .contains(
                                                    "noactivesubscription") &&
                                            !sharedController
                                                .isUserDataFetching.value,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            "no_active_subscription".tr,
                                            textAlign: TextAlign.start,
                                            style: getHeadlineLargeStyle(
                                                    context)
                                                .copyWith(
                                                    color:
                                                        APPSTYLE_BackgroundWhite,
                                                    fontWeight:
                                                        APPSTYLE_FontWeightBold),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: sharedController
                                            .isUserDataFetching.value,
                                        child: Shimmer.fromColors(
                                          baseColor: APPSTYLE_Grey20,
                                          highlightColor: APPSTYLE_Grey40,
                                          child: Container(
                                            height: 30,
                                            width: screenwidth * .5,
                                            decoration:
                                                APPSTYLE_BorderedContainerExtraSmallDecoration
                                                    .copyWith(
                                              border: null,
                                              color: APPSTYLE_Grey20,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      APPSTYLE_BlurRadiusSmall),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Ends On Widget
                                      addVerticalSpace(APPSTYLE_SpaceSmall),

                                      Visibility(
                                        visible: !sharedController.userData
                                                .value.subscriptionRemainingDays
                                                .toLowerCase()
                                                .replaceAll(' ', '')
                                                .contains(
                                                    "noactivesubscription") &&
                                            !sharedController
                                                .isUserDataFetching.value,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            "ends_on_date".tr.replaceAll(
                                                "datestring",
                                                sharedController.userData.value
                                                    .subscriptionEndDate),
                                            textAlign: TextAlign.start,
                                            style: getBodyMediumStyle(context)
                                                .copyWith(
                                              color: APPSTYLE_BackgroundWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: sharedController.userData.value
                                                .subscriptionRemainingDays
                                                .toLowerCase()
                                                .replaceAll(' ', '')
                                                .contains(
                                                    "noactivesubscription") &&
                                            !sharedController
                                                .isUserDataFetching.value,
                                        child: Text(
                                          sharedController.mySubscriptions
                                                  .where((p0) =>
                                                      p0.status == "paid")
                                                  .isNotEmpty
                                              ? "subscription_inactive_message"
                                                  .tr
                                              : sharedController
                                                      .mySubscriptions
                                                      .where((p0) =>
                                                          p0.status ==
                                                          "not paid")
                                                      .isNotEmpty
                                                  ? "subscription_payment_complete_message"
                                                      .tr
                                                  : "subscription_purchase_message"
                                                      .tr,
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                          style: getBodyMediumStyle(context)
                                              .copyWith(
                                            color: APPSTYLE_BackgroundWhite,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: sharedController
                                            .isUserDataFetching.value,
                                        child: Shimmer.fromColors(
                                          baseColor: APPSTYLE_Grey20,
                                          highlightColor: APPSTYLE_Grey40,
                                          child: Container(
                                            height: 20,
                                            width: screenwidth * .4,
                                            decoration:
                                                APPSTYLE_BorderedContainerExtraSmallDecoration
                                                    .copyWith(
                                              border: null,
                                              color: APPSTYLE_Grey20,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      APPSTYLE_BlurRadiusSmall),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Remaining Days Widget
                                      addVerticalSpace(APPSTYLE_SpaceSmall),
                                      Visibility(
                                        visible: !sharedController.userData
                                                .value.subscriptionRemainingDays
                                                .toLowerCase()
                                                .replaceAll(' ', '')
                                                .contains(
                                                    "noactivesubscription") &&
                                            !sharedController
                                                .isUserDataFetching.value,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              Localizations.localeOf(context)
                                                          .languageCode
                                                          .toString() ==
                                                      'en'
                                                  ? "Remain"
                                                  : "يوما",
                                              style: getBodyMediumStyle(context)
                                                  .copyWith(
                                                      color:
                                                          APPSTYLE_BackgroundWhite),
                                            ),
                                            addHorizontalSpace(
                                                APPSTYLE_SpaceSmall),
                                            Visibility(
                                              visible: !sharedController
                                                  .userData
                                                  .value
                                                  .subscriptionRemainingDays
                                                  .toLowerCase()
                                                  .replaceAll(' ', '')
                                                  .contains(
                                                      "noactivesubscription"),
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          APPSTYLE_PrimaryColor,
                                                      width: 2),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  sharedController
                                                      .userData
                                                      .value
                                                      .subscriptionRemainingDays,
                                                  style: getHeadlineLargeStyle(
                                                          context)
                                                      .copyWith(
                                                          color:
                                                          APPSTYLE_PrimaryColor),
                                                )),
                                              ),
                                            ),
                                            addHorizontalSpace(
                                                APPSTYLE_SpaceSmall),
                                            Text(
                                              Localizations.localeOf(context)
                                                          .languageCode
                                                          .toString() ==
                                                      'en'
                                                  ? "Days"
                                                  : "بقي",
                                              style: getBodyMediumStyle(context)
                                                  .copyWith(
                                                      color:
                                                          APPSTYLE_BackgroundWhite),
                                            )
                                          ],
                                        ),
                                      ),
                                      addVerticalSpace(APPSTYLE_SpaceSmall),
                                      Visibility(
                                        visible: !sharedController.userData
                                            .value.subscriptionRemainingDays
                                            .toLowerCase()
                                            .replaceAll(' ', '')
                                            .contains(
                                            "noactivesubscription") &&
                                            !sharedController
                                                .isUserDataFetching.value,
                                        child:   Text( sharedController.userData.value.shift.toLowerCase()
                                            .replaceAll(' ', '')
                                            .contains(
                                            "samedaydelivery")?"morning_shift_string".tr:"evening_shift_string".tr,
                                          style: getBodyMediumStyle(context)
                                              .copyWith(
                                              color:
                                              APPSTYLE_BackgroundWhite),
                                        ),
                                      ),
                                      Visibility(
                                        visible: sharedController
                                            .isUserDataFetching.value,
                                        child: Shimmer.fromColors(
                                          baseColor: APPSTYLE_Grey20,
                                          highlightColor: APPSTYLE_Grey40,
                                          child: Container(
                                            height: 20,
                                            width: screenwidth * .5,
                                            decoration:
                                                APPSTYLE_BorderedContainerExtraSmallDecoration
                                                    .copyWith(
                                              border: null,
                                              color: APPSTYLE_Grey20,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      APPSTYLE_BlurRadiusSmall),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                    Visibility(
                        visible: !sharedController.isUserDataFetching.value,
                        child: addVerticalSpace(APPSTYLE_SpaceLarge)),
                    Visibility(
                      visible: !sharedController.isUserDataFetching.value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: screenwidth * .6,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              APPSTYLE_BackgroundWhite),
                                      padding: MaterialStateProperty.all<
                                              EdgeInsetsGeometry>(
                                          const EdgeInsets.symmetric(
                                              horizontal: APPSTYLE_SpaceMedium,
                                              vertical:
                                                  APPSTYLE_SpaceExtraSmall)),
                                      shape: MaterialStateProperty.all<OutlinedBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(1000)))),
                                  child:sharedController.isPlanActivating.value
                                      || sharedController.isOrderDetailsFetching.value
                                      ? LoadingAnimationWidget.staggeredDotsWave(
                                    color: APPSTYLE_PrimaryColor,
                                    size: 24,
                                  ):  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                        !sharedController.userData.value
                                                .subscriptionRemainingDays
                                                .toLowerCase()
                                                .replaceAll(' ', '')
                                                .contains(
                                                    "noactivesubscription")
                                            ? 'renew_subscription'.tr
                                            : sharedController.mySubscriptions
                                                    .where((p0) =>
                                                        p0.status == "paid")
                                                    .isNotEmpty
                                                ? "activate_subscription".tr
                                                : sharedController
                                                        .mySubscriptions
                                                        .where((p0) =>
                                                            p0.status ==
                                                            "not paid")
                                                        .isNotEmpty
                                                    ? "complete_payment".tr
                                                    : "purchase_subscription"
                                                        .tr,
                                        style: getLabelLargeStyle(context)
                                            .copyWith(
                                                color: APPSTYLE_PrimaryColor,
                                                fontWeight:
                                                    APPSTYLE_FontWeightBold),
                                        textAlign: TextAlign.center),
                                  ),
                                  onPressed: () {
                                    if(sharedController.mySubscriptions
                                        .where((p0) =>
                                    p0.status == "in_progress").toList()
                                        .isNotEmpty){
                                      Get.toNamed(AppRouteNames
                                          .planPurchaseSubscriptionPlansCategoryListRoute);
                                    }else{
                                      if(sharedController.mySubscriptions
                                          .where((p0) =>
                                      p0.status == "paid").toList()
                                          .isNotEmpty){
                                        if (!sharedController
                                            .isPlanActivating.value) {
                                          sharedController.activatePlan(sharedController.mySubscriptions
                                              .where((p0) =>
                                          p0.status == "paid").toList()[0].id);
                                        }
                                      }
                                      else if(sharedController.mySubscriptions
                                          .where((p0) =>
                                      p0.status == "not paid").toList()
                                          .isNotEmpty){
                                        if (!sharedController
                                            .isOrderDetailsFetching.value) {
                                          sharedController.getPaymentLink(sharedController.mySubscriptions
                                              .where((p0) =>
                                          p0.status == "not paid").toList()[0].id);
                                        }
                                      }else{
                                        Get.toNamed(AppRouteNames
                                            .planPurchaseSubscriptionPlansCategoryListRoute);
                                      }

                                    }

                                  })),
                        ],
                      ),
                    ),
                    Visibility(
                        visible: !sharedController.isUserDataFetching.value,
                        child: addVerticalSpace(APPSTYLE_SpaceExtraSmall)),
                    Visibility(
                      visible: !sharedController.isUserDataFetching.value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: screenwidth * .6,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all<
                                              EdgeInsetsGeometry>(
                                          const EdgeInsets.symmetric(
                                              horizontal: APPSTYLE_SpaceMedium,
                                              vertical:
                                                  APPSTYLE_SpaceExtraSmall)),
                                      shape: MaterialStateProperty.all<
                                              OutlinedBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      1000)))),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: sharedController
                                            .isAppointmentBooking.value
                                        ? LoadingAnimationWidget
                                            .staggeredDotsWave(
                                            color: APPSTYLE_BackgroundWhite,
                                            size: 24,
                                          )
                                        : Text('book_an_appointment'.tr,
                                            style: getLabelLargeStyle(context)
                                                .copyWith(
                                                    color:
                                                        APPSTYLE_BackgroundWhite,
                                                    fontWeight:
                                                        APPSTYLE_FontWeightBold),
                                            textAlign: TextAlign.center),
                                  ),
                                  onPressed: () {
                                    if (!sharedController
                                        .isAppointmentBooking.value) {
                                      showBookingConfirmDialogue(context);
                                    }
                                  })),
                        ],
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getGreetingText() {
    DateTime currentDate = DateTime.now();
    print("currentDate.hour");
    print(currentDate.hour);
    if (currentDate.hour < 12) {
      return "good_morning";
    } else if (currentDate.hour < 16) {
      return "good_afternoon";
    } else {
      return "good_evening";
    }
  }

  void showBookingConfirmDialogue(BuildContext context) async {
    final dialogTitleWidget = Text('confirm_appointment'.tr,
        style: getHeadlineMediumStyle(context).copyWith(
            color: APPSTYLE_Grey80, fontWeight: APPSTYLE_FontWeightBold));
    final dialogTextWidget = Text('confirm_appointment_message'.tr,
        style: getBodyMediumStyle(context));

    final updateButtonTextWidget = Text(
      'yes'.tr,
      style: TextStyle(color: APPSTYLE_PrimaryColor),
    );
    final updateButtonCancelTextWidget = Text(
      'no'.tr,
      style: TextStyle(color: APPSTYLE_Black),
    );

    updateLogoutAction() {
      if (!sharedController.isAppointmentBooking.value) {
        sharedController.bookDietitionAppointment();
      }
      Navigator.pop(context);
    }

    updateAction() {
      Navigator.pop(context);
    }

    List<Widget> actions = [
      TextButton(
          onPressed: updateAction,
          style: APPSTYLE_TextButtonStylePrimary.copyWith(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(
                      horizontal: APPSTYLE_SpaceLarge,
                      vertical: APPSTYLE_SpaceSmall))),
          child: updateButtonCancelTextWidget),
      TextButton(
          onPressed: updateLogoutAction,
          style: APPSTYLE_TextButtonStylePrimary.copyWith(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(
                      horizontal: APPSTYLE_SpaceLarge,
                      vertical: APPSTYLE_SpaceSmall))),
          child: updateButtonTextWidget),
    ];

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            child: AlertDialog(
              title: dialogTitleWidget,
              content: dialogTextWidget,
              actions: actions,
            ),
            onWillPop: () => Future.value(false));
      },
    );
  }

  openWhatsapp() async {
    String contact = sharedController.supportNumber.value;

    final Uri whatsappUrl = Uri(
      scheme: 'whatsapp',
      path: contact,
    );

    String webUrl = 'https://api.whatsapp.com/send/?phone=$contact&text=hi';

    try {
      await UrlLauncher.launchUrl(whatsappUrl);
    } catch (e) {
      print('object');
      await UrlLauncher.launchUrl(
          Uri.parse(webUrl), mode: UrlLauncher.LaunchMode.externalApplication);
    }
  }

  openDialer() async {
    String contact = sharedController.supportNumber.value;

    final Uri dialerUrl = Uri(
      scheme: 'tel',
      path: contact,
    );
    String webUrl = 'tel:$contact';


    try {
      await UrlLauncher.launchUrl(dialerUrl);
    } catch (e) {
      print('object');
      await UrlLauncher.launchUrl(Uri.parse(webUrl),
          mode: UrlLauncher.LaunchMode.externalApplication);
    }
  }
}
