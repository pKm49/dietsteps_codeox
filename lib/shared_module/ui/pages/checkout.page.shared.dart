import 'dart:ffi';
import 'dart:ui';

import 'package:dietsteps/feature_modules/plan_purchase/controllers/plan_purchase.controller.dart';
 import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/date_conversion.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class CheckoutPage_Shared extends StatefulWidget {
  const CheckoutPage_Shared({super.key});

  @override
  State<CheckoutPage_Shared> createState() =>
      _CheckoutPage_SharedState();
}

class _CheckoutPage_SharedState
    extends State<CheckoutPage_Shared> {

  final sharedController = Get.find<SharedController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return  Obx(
          ()=> Scaffold(
          resizeToAvoidBottomInset: true,
          appBar:!sharedController.isPaymentGatewayLoading.value? AppBar(
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
                      'checkout'.tr,
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
          ):AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: APPSTYLE_BackgroundWhite,
            scrolledUnderElevation: 0.0,
            elevation: 0.0
          ),
          body: SafeArea(
            child:Container(
                height: screenheight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                        visible: sharedController.isPaymentGatewayLoading.value,
                        child: Expanded(
                          child: Container(
                            decoration:  const BoxDecoration(
                                gradient:  LinearGradient(
                                  colors: [Colors.transparent, Color(0xff000000)],
                                  stops: [0, 0.99],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )
                            ),
                            child: Center(
                                                child: CircularProgressIndicator(color: APPSTYLE_PrimaryColor),
                                              ),
                          ),
                        )),
                    Visibility(
                      visible: !sharedController.isPaymentGatewayLoading.value,
                      child: Expanded(
                          child: Container(
                            child: ListView(
                              children: [
                                addVerticalSpace(APPSTYLE_SpaceLarge),

                                Padding(
                                  padding: APPSTYLE_MediumPaddingHorizontal,
                                  child: Text( 'payment_summary'.tr,
                                    textAlign: TextAlign.start,
                                    style: getHeadlineMediumStyle(context)
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                addVerticalSpace(APPSTYLE_SpaceMedium),
                                Container(
                                  width: screenwidth,
                                  decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                                  padding: APPSTYLE_MediumPaddingAll,
                                  margin: APPSTYLE_LargePaddingHorizontal,
                                  alignment: Alignment.center,
                                  child: Wrap(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text( 'sub_total'.tr,
                                            style: getBodyMediumStyle(context).copyWith(
                                              color: APPSTYLE_Grey80, ),
                                          ),
                                          Text(
                                            "${sharedController.paymentCompletionData.value.total} KWD",
                                            style: getBodyMediumStyle(context).copyWith(
                                                color: APPSTYLE_Grey80,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text( 'discount'.tr,
                                            style: getBodyMediumStyle(context).copyWith(
                                              color: APPSTYLE_Grey80,
                                            ),
                                          ),
                                          Text(
                                            "-${sharedController.paymentCompletionData.value.couponDiscount} KWD",
                                            style: getBodyMediumStyle(context).copyWith(
                                                color: APPSTYLE_GuideGreen,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      addVerticalSpace(APPSTYLE_SpaceMedium),
                                      Row(
                                        children: List.generate(
                                            600 ~/ 10,
                                                (index) => Expanded(
                                              child: Container(
                                                color: index % 2 == 0
                                                    ? Colors.transparent
                                                    : Colors.grey,
                                                height: 2,
                                              ),
                                            )),
                                      ),
                                      addVerticalSpace(APPSTYLE_SpaceMedium),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text( 'total'.tr,
                                            style: getBodyMediumStyle(context).copyWith(
                                              color: APPSTYLE_Grey80, ),
                                          ),
                                          Text(
                                            "${sharedController.paymentCompletionData.value.grandTotal} KWD",
                                            style: getBodyMediumStyle(context).copyWith(
                                                color: APPSTYLE_Grey80,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                addVerticalSpace(APPSTYLE_SpaceLarge ),
                                Padding(
                                  padding: APPSTYLE_LargePaddingHorizontal,
                                  child: Text( 'order_summary'.tr,
                                    textAlign: TextAlign.start,
                                    style: getHeadlineMediumStyle(context)
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                addVerticalSpace(APPSTYLE_SpaceMedium),
                                Container(
                                  width: screenwidth,
                                  decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                                  padding: APPSTYLE_MediumPaddingAll,
                                  margin: APPSTYLE_LargePaddingHorizontal,
                                  alignment: Alignment.center,
                                  child: Wrap(
                                     children: [
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text( 'order_reference'.tr,
                                             style: getBodyMediumStyle(context).copyWith(
                                               color: APPSTYLE_Grey80, ),
                                           ),
                                           Text(
                                             "${sharedController.paymentCompletionData.value.orderReference}",
                                             style: getBodyMediumStyle(context).copyWith(
                                                 color: APPSTYLE_Grey80,
                                                 fontWeight: FontWeight.bold),
                                           )
                                         ],
                                       ),
                                       addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text( 'payment_reference'.tr,
                                             style: getBodyMediumStyle(context).copyWith(
                                               color: APPSTYLE_Grey80,
                                             ),
                                           ),
                                           Text(
                                             "${sharedController.paymentCompletionData.value.paymentReference}",
                                             style: getBodyMediumStyle(context).copyWith(
                                                 color: APPSTYLE_Grey80,
                                                 fontWeight: FontWeight.bold),
                                           ),
                                         ],
                                       ),
                                       addVerticalSpace(APPSTYLE_SpaceMedium),
                                       Row(
                                         children: List.generate(
                                             600 ~/ 10,
                                                 (index) => Expanded(
                                               child: Container(
                                                 color: index % 2 == 0
                                                     ? Colors.transparent
                                                     : Colors.grey,
                                                 height: 2,
                                               ),
                                             )),
                                       ),
                                       addVerticalSpace(APPSTYLE_SpaceMedium),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              Localizations.localeOf(context)
                                      .languageCode
                                      .toString() ==
                                      'ar'?
                                              sharedController.paymentCompletionData.value.planNameArabic
                                              :sharedController.paymentCompletionData.value.planName,
                                              textAlign: TextAlign.start,
                                              style: getBodyMediumStyle(context).copyWith(
                                                  color: APPSTYLE_Grey80,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      addVerticalSpace(APPSTYLE_SpaceSmall),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.calendar_month,size: APPSTYLE_FontSize20,),
                                          addHorizontalSpace(APPSTYLE_SpaceExtraSmall),
                                          Expanded(
                                            child: FittedBox(
                                              alignment: Alignment.centerLeft,
                                              fit:BoxFit.scaleDown,
                                              child: Text(Localizations.localeOf(context)
                                                  .languageCode
                                                  .toString() ==
                                                  'ar'?
                                                  ' ${sharedController.paymentCompletionData.value.endDate} إلى ${sharedController.paymentCompletionData.value.startDate}'

                                                      :' ${sharedController.paymentCompletionData.value.startDate} to ${sharedController.paymentCompletionData.value.endDate}',
                                                style: getBodyMediumStyle(context),textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                                addVerticalSpace(APPSTYLE_SpaceMedium),
                                Padding(
                                  padding: APPSTYLE_LargePaddingHorizontal,
                                  child: Text( 'customer_support'.tr,
                                    textAlign: TextAlign.start,
                                    style: getHeadlineMediumStyle(context)
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                addVerticalSpace(APPSTYLE_SpaceMedium),
                                Padding(
                                  padding: APPSTYLE_LargePaddingHorizontal,
                                  child:Row(
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          handleRequestSupportClick(context,false);
                                        },
                                        child: Container(
                                          decoration: APPSTYLE_BorderedContainerLargeDecoration.copyWith(
                                              color: APPSTYLE_Black
                                          ),
                                          padding: APPSTYLE_SmallPaddingAll,
                                          child: Icon(Ionicons.call,color: APPSTYLE_BackgroundWhite,),
                                        ),
                                      ),
                                      // addHorizontalSpace(APPSTYLE_SpaceSmall),
                                      // InkWell(
                                      //   onTap: (){
                                      //     handleRequestSupportClick(context,false);
                                      //   },
                                      //   child: Container(
                                      //     decoration: APPSTYLE_BorderedContainerLargeDecoration.copyWith(
                                      //         color: APPSTYLE_PrimaryColor
                                      //     ),
                                      //     padding: APPSTYLE_SmallPaddingAll,
                                      //     child: Icon(Ionicons.mail,color: APPSTYLE_BackgroundWhite,),
                                      //   ),
                                      // ),
                                      addHorizontalSpace(APPSTYLE_SpaceSmall),
                                      InkWell(
                                        onTap: (){
                                          handleRequestSupportClick(context,true);

                                        },
                                        child: Container(
                                          decoration: APPSTYLE_BorderedContainerLargeDecoration.copyWith(
                                              color: APPSTYLE_WhatsappGreen
                                          ),
                                          padding: APPSTYLE_SmallPaddingAll,
                                          child: Icon(Ionicons.logo_whatsapp,color: APPSTYLE_BackgroundWhite,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                addVerticalSpace(APPSTYLE_SpaceLarge*3),


                              ],
                            ),
                          )),
                    ),
                    Visibility(
                      visible:! sharedController.isPaymentGatewayLoading.value,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: APPSTYLE_SpaceLarge,vertical: APPSTYLE_SpaceSmall),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              sharedController.redirectToPaymentPage();

                            },
                            style: getElevatedButtonStyle(context),
                            child: sharedController.isPlanActivating.value
                                ? LoadingAnimationWidget.staggeredDotsWave(
                              color: APPSTYLE_BackgroundWhite,
                              size: 24,
                            ):Text(
                              "checkout".tr,
                              style: getHeadlineMediumStyle(context).copyWith(
                                  color: APPSTYLE_BackgroundWhite,
                                  fontWeight: APPSTYLE_FontWeightBold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

          )),
    );
  }


  Future<void> handleRequestSupportClick(
      BuildContext buildContext, bool isWhatsapp) async {
    final sharedController = Get.find<SharedController>();

    final Uri callUrl =
    Uri(scheme: 'tel', path: sharedController.supportNumber.value);
    final whatsappUrl =
    Uri.parse("https://wa.me/${sharedController.supportNumber.value}");
    var canLaunch = false;
    if (isWhatsapp) {
      canLaunch = await UrlLauncher.canLaunchUrl(whatsappUrl);
    } else {
      canLaunch = await UrlLauncher.canLaunchUrl(callUrl);
    }
    if (canLaunch) {
      if (isWhatsapp) {
        UrlLauncher.launchUrl(whatsappUrl);
      } else {
        UrlLauncher.launchUrl(callUrl);
      }
    } else {
      showSnackbar(buildContext, "not_able_to_connect".tr, "error");
    }
  }
}
