import 'dart:ffi';
import 'dart:ui';

import 'package:dietsteps/feature_modules/e_shop/controllers/controller.eshop.dart';
import 'package:dietsteps/feature_modules/my_subscription/services/meal_selection.helper.services.dart';
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
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class CheckoutPage_Eshop extends StatefulWidget {
  const CheckoutPage_Eshop({super.key});

  @override
  State<CheckoutPage_Eshop> createState() =>
      _CheckoutPage_EshopState();
}

class _CheckoutPage_EshopState
    extends State<CheckoutPage_Eshop> {
  final sharedController = Get.find<SharedController>();
  final eshopController = Get.find<EshopController>();


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
          appBar:!eshopController.isPaymentGatewayLoading.value? AppBar(
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
                        visible: eshopController.isPaymentGatewayLoading.value,
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
                      visible: !eshopController.isPaymentGatewayLoading.value && eshopController.isCartDetailsFetching.value,
                      child: Expanded(
                          child: Container(
                            child: ListView(
                              children: [
                                addVerticalSpace(APPSTYLE_SpaceLarge),
                                Padding(
                                  padding:APPSTYLE_LargePaddingHorizontal,
                                  child: Row(
                                    children: [
                                      Shimmer.fromColors(
                                        baseColor: APPSTYLE_Grey20,
                                        highlightColor: APPSTYLE_Grey40,
                                        child: Container(
                                            decoration:
                                            APPSTYLE_BorderedContainerDarkMediumDecoration
                                                .copyWith(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    APPSTYLE_BorderRadiusSmall),
                                                color:
                                                APPSTYLE_BackgroundWhite,
                                                border: Border.all(
                                                    color:
                                                    APPSTYLE_PrimaryColorBg,
                                                    width: 3)),
                                            padding: APPSTYLE_SmallPaddingAll,
                                            width: screenwidth * .3,
                                            height: screenwidth * .3,
                                            clipBehavior: Clip.hardEdge),
                                      ),
                                      addHorizontalSpace(APPSTYLE_SpaceSmall),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        Shimmer.fromColors(
                                          baseColor: APPSTYLE_Grey20,
                                          highlightColor: APPSTYLE_Grey40,
                                          child: Container(
                                              decoration:
                                              APPSTYLE_BorderedContainerDarkMediumDecoration
                                                  .copyWith(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      APPSTYLE_BorderRadiusSmall),
                                                  color:
                                                  APPSTYLE_BackgroundWhite,
                                                  border: Border.all(
                                                      color:
                                                      APPSTYLE_PrimaryColorBg,
                                                      width: 3)),
                                              padding: APPSTYLE_SmallPaddingAll,
                                              width: screenwidth * .45,
                                              height: 50,
                                              clipBehavior: Clip.hardEdge),
                                        ),
                                        addVerticalSpace(APPSTYLE_SpaceSmall),
                                        Shimmer.fromColors(
                                          baseColor: APPSTYLE_Grey20,
                                          highlightColor: APPSTYLE_Grey40,
                                          child: Container(
                                              decoration:
                                              APPSTYLE_BorderedContainerDarkMediumDecoration
                                                  .copyWith(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      APPSTYLE_BorderRadiusSmall),
                                                  color:
                                                  APPSTYLE_BackgroundWhite,
                                                  border: Border.all(
                                                      color:
                                                      APPSTYLE_PrimaryColorBg,
                                                      width: 3)),
                                              padding: APPSTYLE_SmallPaddingAll,
                                              width: screenwidth * .3,
                                              height: 50,
                                              clipBehavior: Clip.hardEdge),
                                        ),
                                      ],)
                                    ],
                                  )
                                ),
                                addVerticalSpace(APPSTYLE_SpaceLarge ),

                                Padding(padding: APPSTYLE_LargePaddingHorizontal,
                                child:  Shimmer.fromColors(
                                  baseColor: APPSTYLE_Grey20,
                                  highlightColor: APPSTYLE_Grey40,
                                  child: Container(
                                      decoration:
                                      APPSTYLE_BorderedContainerDarkMediumDecoration
                                          .copyWith(
                                          borderRadius:
                                          BorderRadius.circular(
                                              APPSTYLE_BorderRadiusSmall),
                                          color:
                                          APPSTYLE_BackgroundWhite,
                                          border: Border.all(
                                              color:
                                              APPSTYLE_PrimaryColorBg,
                                              width: 3)),
                                      padding: APPSTYLE_SmallPaddingAll,
                                      width: screenwidth * .3,
                                      height: screenwidth * .3,
                                      clipBehavior: Clip.hardEdge),
                                ),),
                                addVerticalSpace(APPSTYLE_SpaceLarge ),
                                Padding(padding: APPSTYLE_LargePaddingHorizontal,
                                  child:  Shimmer.fromColors(
                                    baseColor: APPSTYLE_Grey20,
                                    highlightColor: APPSTYLE_Grey40,
                                    child: Container(
                                        decoration:
                                        APPSTYLE_BorderedContainerDarkMediumDecoration
                                            .copyWith(
                                            borderRadius:
                                            BorderRadius.circular(
                                                APPSTYLE_BorderRadiusSmall),
                                            color:
                                            APPSTYLE_BackgroundWhite,
                                            border: Border.all(
                                                color:
                                                APPSTYLE_PrimaryColorBg,
                                                width: 3)),
                                        padding: APPSTYLE_SmallPaddingAll,
                                        width: screenwidth * .3,
                                        height: screenwidth * .3,
                                        clipBehavior: Clip.hardEdge),
                                  ),),

                                addVerticalSpace(APPSTYLE_SpaceLarge*2),


                              ],
                            ),
                          )),
                    ),
                    Visibility(
                      visible: !eshopController.isPaymentGatewayLoading.value && !eshopController.isCartDetailsFetching.value,
                      child: Expanded(
                          child: Container(
                            child: ListView(
                              children: [
                                addVerticalSpace(APPSTYLE_SpaceLarge),
                                Padding(
                                  padding: APPSTYLE_LargePaddingHorizontal,
                                  child: Text( 'order_summary'.tr,
                                    textAlign: TextAlign.start,
                                    style: getHeadlineMediumStyle(context)
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                addVerticalSpace(APPSTYLE_SpaceMedium),
                                for(var i=0;i<eshopController.cart.value.orderLine.length;i++)
                                  Container(
                                      decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                                      padding: APPSTYLE_MediumPaddingAll,
                                      margin: APPSTYLE_LargePaddingHorizontal,
                                    child: Row(
                                      children: [
                                        Container(
                                            decoration: APPSTYLE_BorderedContainerDarkMediumDecoration
                                                .copyWith(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    APPSTYLE_BorderRadiusSmall),
                                                color:
                                                APPSTYLE_Grey20,
                                                image: DecorationImage(image: getProductImage(eshopController.cart.value.orderLine[i].imageUrl),fit: BoxFit.cover),
                                                border: Border.all(
                                                    color:
                                                    APPSTYLE_BackgroundWhite,
                                                    width: 0.0)),
                                            width: screenwidth * .2,
                                            height: screenwidth * .2,
                                            clipBehavior:
                                            Clip.hardEdge ),
                                        addHorizontalSpace(APPSTYLE_SpaceMedium),
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('${Localizations.localeOf(
                                                    context)
                                                    .languageCode
                                                    .toString() ==
                                                    'ar'
                                                    ? eshopController.cart.value.orderLine[i].mealNameArabic
                                                    : eshopController.cart.value.orderLine[i].mealName}',
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start,
                                                  style: getBodyMediumStyle(
                                                      context)
                                                      .copyWith(
                                                      fontWeight: APPSTYLE_FontWeightBold,
                                                      color:
                                                      APPSTYLE_Grey80),
                                                ),
                                                addVerticalSpace(APPSTYLE_SpaceSmall),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                        onTap: (){
                                                          eshopController.updateCartItem(eshopController.cart.value.orderLine[i], -1, false);
                                                        },
                                                        child: Icon(Ionicons.remove_circle,color: APPSTYLE_GuideRed,size: APPSTYLE_FontSize24*1.5,)),
                                                    addHorizontalSpace(APPSTYLE_SpaceSmall),
                                                    Text(eshopController.cart.value.orderLine[i].quantity.toString(),style: getHeadlineLargeStyle(context)),
                                                    addHorizontalSpace(APPSTYLE_SpaceSmall),
                                                    InkWell(
                                                        onTap: (){
                                                          eshopController.updateCartItem(eshopController.cart.value.orderLine[i], 1, true);
                                                        },child: Icon(Ionicons.add_circle,color: APPSTYLE_GuideGreen,size: APPSTYLE_FontSize24*1.5,)),
                                                    addHorizontalSpace(APPSTYLE_SpaceLarge),
                                                    Container(
                                                      decoration: APPSTYLE_BorderedContainerExtraSmallDecoration.
                                                      copyWith(color: APPSTYLE_PrimaryColor),
                                                      padding: APPSTYLE_ExtraSmallPaddingVertical.copyWith(left: APPSTYLE_SpaceSmall,right: APPSTYLE_SpaceSmall),
                                                      child: Text('${eshopController.cart.value.orderLine[i].price} KD',style: getLabelLargeStyle(context).copyWith(color: APPSTYLE_BackgroundWhite)),
                                                    ),
                                                      ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                addVerticalSpace(APPSTYLE_SpaceLarge*2),

                                Container(
                                  width: screenwidth,
                                  decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                                  padding: APPSTYLE_MediumPaddingAll,
                                  margin: APPSTYLE_LargePaddingHorizontal,
                                  alignment: Alignment.center,
                                  child:   Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text( 'coupon_code'.tr,
                                        style:
                                        getBodyMediumStyle(context).copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: APPSTYLE_Grey80,
                                        ),
                                      ),
                                      addHorizontalSpace(APPSTYLE_SpaceMedium),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 50,
                                          padding: EdgeInsets.only(
                                            left:  Localizations.localeOf(context)
                                                .languageCode
                                                .toString() ==
                                                'en'
                                                ? APPSTYLE_SpaceMedium
                                                :0.0 ,
                                            right:  Localizations.localeOf(context)
                                                .languageCode
                                                .toString() ==
                                                'en'
                                                ? 0.0
                                                :APPSTYLE_SpaceMedium,
                                          ),
                                          decoration:
                                          APPSTYLE_BorderedContainerDarkSmallDecoration.copyWith(color: APPSTYLE_Grey20),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child:  TextFormField(
                                                    controller:eshopController.couponCodeController.value,

                                                    decoration: noBorderInputDecoration.copyWith(
                                                      hintText:'enter_code'.tr,
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  FocusManager.instance.primaryFocus?.unfocus();

                                                  if(!eshopController.isCouponChecking.value &&
                                                      eshopController.couponCodeController.value.text.trim() !=""){
                                                    eshopController.checkCouponValidity();
                                                  }
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 50,
                                                  width: 50,
                                                  padding:
                                                  EdgeInsets.all(APPSTYLE_SpaceSmall),
                                                  decoration:
                                                  APPSTYLE_BorderedContainerDarkSmallDecoration
                                                      .copyWith(
                                                      color:eshopController.isCouponCodeValid.value?
                                                          APPSTYLE_WhatsappGreen:
                                                      APPSTYLE_PrimaryColor),
                                                  child: eshopController.isCouponChecking.value?
                                                  LoadingAnimationWidget.staggeredDotsWave(
                                                    color: APPSTYLE_BackgroundWhite,
                                                    size: 20,
                                                  ):
                                                  Icon(
                                                      eshopController.isCouponCodeValid.value?
                                                      Icons.check :
                                                      Localizations.localeOf(context)
                                                          .languageCode
                                                          .toString() ==
                                                          'ar'?Icons.chevron_left  :Icons.chevron_right
                                                      ,color: APPSTYLE_BackgroundWhite),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),),
                                addVerticalSpace(APPSTYLE_SpaceLarge*2),

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
                                            "${eshopController.subTotal.value} KWD",
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
                                            "-${eshopController.discount.value} KWD",
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
                                            "${eshopController.total.value} KWD",
                                            style: getBodyMediumStyle(context).copyWith(
                                                color: APPSTYLE_Grey80,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                addVerticalSpace(APPSTYLE_SpaceLarge*2),

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
                                          openDialer();
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
                                          openWhatsapp();

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
                      visible:!eshopController.isPaymentGatewayLoading.value && !eshopController.isCartDetailsFetching.value,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: APPSTYLE_SpaceLarge,vertical: APPSTYLE_SpaceSmall),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if(!eshopController.isOrderCreating.value &&
                                  !eshopController.isCouponChecking.value){
                                eshopController.createOrder();
                              }
                            },
                            style: getElevatedButtonStyle(context),
                            child: eshopController.isOrderCreating.value
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


  openWhatsapp() async {

    String contact = sharedController.supportNumber.value;

    // final Uri whatsappUrl = Uri(
    //   scheme: 'whatsapp',
    //   path: contact,
    // );
    final whatsappUrl = WhatsAppUnilink(
      phoneNumber: contact,
      text: "Hey",
    );

    String webUrl = 'https://api.whatsapp.com/send/?phone=$contact&text=hi';

    try {
      await UrlLauncher.launchUrl(whatsappUrl.asUri());
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
