import 'dart:ui';

import 'package:dietsteps/feature_modules/plan_purchase/controllers/plan_purchase.controller.dart';
import 'package:dietsteps/feature_modules/plan_purchase/ui/components/subscriptionplan_card.component.plan_purchase.dart';
import 'package:dietsteps/feature_modules/plan_purchase/ui/components/subscriptionplan_card_loaded.component.plan_purchase.dart';
 import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
 import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
 import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
  import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SelectPlanPage_PlanPurchase extends StatefulWidget {
  const SelectPlanPage_PlanPurchase({super.key});

  @override
  State<SelectPlanPage_PlanPurchase> createState() =>
      _SelectPlanPage_PlanPurchaseState();
}

class _SelectPlanPage_PlanPurchaseState
    extends State<SelectPlanPage_PlanPurchase> {

  final planPurchaseController = Get.find<PlanPurchaseController>();
  final sharedController = Get.find<SharedController>();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    planPurchaseController.getSubscriptionsByCategory();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: APPSTYLE_BackgroundWhite,
          scrolledUnderElevation: 0.0,
          elevation: 0.0,
          title: Row(
            children: [
              CustomBackButton(isPrimaryMode: false),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'select_your_choice'.tr,
                    style: getHeadlineLargeStyle(context).copyWith(
                        fontWeight: APPSTYLE_FontWeightBold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            LanguagePreviewButtonComponentShared(textColor:APPSTYLE_PrimaryColor),
            addHorizontalSpace(APPSTYLE_SpaceLarge)
          ],
        ),
        body: SafeArea(
          child: Obx(
            ()=> Container(
               height: screenheight,
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                          if (!sharedController
                              .isAppointmentBooking.value) {
                            showBookingConfirmDialogue(context);
                          }
                        },
                        child: Container(
                          width: screenwidth*.5,
                          decoration: APPSTYLE_ShadowedContainerLargeDecoration.
                          copyWith(
                            gradient: const LinearGradient(
                                colors: [Color(0xFFF46A6A), APPSTYLE_PrimaryColor],
                                tileMode: TileMode.clamp),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: APPSTYLE_SpaceSmall,horizontal: APPSTYLE_SpaceMedium
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: !sharedController
                                    .isAppointmentBooking.value,
                                child: Icon(Ionicons.calendar_number_outline,color: APPSTYLE_BackgroundWhite,
                                    size: APPSTYLE_FontSize16),
                              ),
                              Visibility(
                                  visible: !sharedController
                                      .isAppointmentBooking.value,
                                  child: addHorizontalSpace(APPSTYLE_SpaceSmall)),
                              sharedController
                                  .isAppointmentBooking.value
                                  ? LoadingAnimationWidget
                                  .staggeredDotsWave(
                                color: APPSTYLE_BackgroundWhite,
                                size: 24,
                              )
                                  :
                              Expanded(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "book_an_appointment".tr,
                                    style: getBodyMediumStyle(context)
                                        .copyWith(
                                        color:
                                        APPSTYLE_BackgroundWhite),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      addHorizontalSpace(APPSTYLE_SpaceLarge)
                    ],
                  ),
                  addVerticalSpace(APPSTYLE_SpaceMedium),
                  Visibility(
                    visible:  planPurchaseController.isSubscriptionsFetching.value,
                    child: Expanded(
                      child: ListView(
                        children: [
                          SubscriptionPlanCardLoaderComponent_PlanPurchase(
                            isSelected: false,
                          ),
                          SubscriptionPlanCardLoaderComponent_PlanPurchase(
                            isSelected: false,
                          ),
                          SubscriptionPlanCardLoaderComponent_PlanPurchase(
                            isSelected: false,
                          ),
                          SubscriptionPlanCardLoaderComponent_PlanPurchase(
                            isSelected: false,
                          ),
                          SubscriptionPlanCardLoaderComponent_PlanPurchase(
                            isSelected: false,
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible:  planPurchaseController.subscriptionCategories.isEmpty &&
                        !planPurchaseController.isCategoriesFetching.value ,
                    child: Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1000),
                                    color: APPSTYLE_Grey20,
                                  ),
                                  width: screenwidth * .3,
                                  height: screenwidth * .3,
                                  child: Center(
                                    child: Icon(Ionicons.cash_outline,
                                        size: screenwidth * .15,
                                        color: APPSTYLE_PrimaryColorBg),
                                  ),
                                )
                              ],
                            ),
                            addVerticalSpace(APPSTYLE_SpaceLarge),
                            Text("no_plans_found".tr,
                                style: getHeadlineMediumStyle(context)),
                          ],
                        )),
                  ),
                  Visibility(
                    visible: !planPurchaseController.isSubscriptionsFetching.value &&
                     planPurchaseController.subscriptions.isNotEmpty,
                    child: Expanded(
                      child:  ListView(
                        children: [
                          for(var index=0;index<planPurchaseController.subscriptions.length;index++)
                            InkWell(
                            onTap: (){
                              planPurchaseController.changeSubscription(planPurchaseController.subscriptions[index]);
                            },
                            child: SubscriptionPlanCardComponent_PlanPurchase(
                              isSelected: planPurchaseController.currentSubscription.value.id==
                                  planPurchaseController.subscriptions[index].id,
                              subscriptionPlan: planPurchaseController.subscriptions[index],
                            ),
                          )
                        ],
                      )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: APPSTYLE_SpaceLarge,vertical: APPSTYLE_SpaceSmall),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if(!planPurchaseController.isSubscriptionsFetching.value){
                            if(planPurchaseController.subscriptions.isNotEmpty){
                              if(planPurchaseController.currentSubscription.value.id == -1){
                                showSnackbar(Get.context!, "choose_package_message".tr, "info");
                              }else{
                                Get.toNamed(AppRouteNames.planPurchaseSetInitialDateRoute);

                              }
                            }else{
                              planPurchaseController.getSubscriptionsByCategory();
                            }
                          }

                        },
                        style: getElevatedButtonStyle(context),
                        child: Text("continue".tr,
                            style: getHeadlineMediumStyle(context).copyWith(
                                color: APPSTYLE_BackgroundWhite,
                                fontWeight: APPSTYLE_FontWeightBold),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ));
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
}
