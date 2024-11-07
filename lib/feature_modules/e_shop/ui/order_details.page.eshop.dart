import 'dart:ffi';
import 'dart:ui';

import 'package:dietsteps/feature_modules/e_shop/controllers/controller.eshop.dart';
import 'package:dietsteps/feature_modules/my_subscription/services/meal_selection.helper.services.dart';
import 'package:dietsteps/feature_modules/plan_purchase/controllers/plan_purchase.controller.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
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

class OrderDetailsPage_Eshop extends StatefulWidget {
  const OrderDetailsPage_Eshop({super.key});

  @override
  State<OrderDetailsPage_Eshop> createState() =>
      _OrderDetailsPage_EshopState();
}

class _OrderDetailsPage_EshopState
    extends State<OrderDetailsPage_Eshop> {
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
                      'shopping_cart'.tr,
                      style: getHeadlineLargeStyle(context).copyWith(
                          fontWeight: APPSTYLE_FontWeightBold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ) ,
          body: SafeArea(
            child:Container(
                height: screenheight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: eshopController.isCartDetailsFetching.value,
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

                                addVerticalSpace(APPSTYLE_SpaceLarge*2),


                              ],
                            ),
                          )),
                    ),
              Visibility(
                visible: !eshopController.isCartDetailsFetching.value && eshopController.cart.value.orderLine.isEmpty,
                child: Expanded(
                  child: Container(
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
                                    color: APPSTYLE_Grey40,
                                  ),
                                  width: screenwidth * .4,
                                  height: screenwidth * .4,
                                  child: Center(
                                    child:  Image.asset(ASSETS_MEALS,width: screenwidth*.3),
                                  ),
                                )
                              ],
                            ),
                            addVerticalSpace(APPSTYLE_SpaceLarge),
                            Text("no_meals_found".tr,
                                style: getHeadlineMediumStyle(context)),
                          ],
                        )),
                  ),
                )),
                    Visibility(
                      visible: !eshopController.isCartDetailsFetching.value && eshopController.cart.value.orderLine.isNotEmpty,
                      child: Expanded(
                          child: Container(
                            child: ListView(
                              children: [
                                addVerticalSpace(APPSTYLE_SpaceLarge),
                                Visibility(
                                    visible: eshopController.isEmptyingCart.value,
                                    child:Padding(
                                      padding: EdgeInsets.only(bottom: APPSTYLE_SpaceSmall),
                                      child: LinearProgressIndicator(),

                                    )),

                                Padding(
                                  padding: APPSTYLE_LargePaddingHorizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text( 'cart_items'.tr,
                                        textAlign: TextAlign.start,
                                        style: getHeadlineMediumStyle(context)
                                            .copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          eshopController.emptyCart();
                                        },
                                        child: Text( 'empty_cart'.tr,
                                          textAlign: TextAlign.start,
                                          style: getHeadlineMediumStyle(context)
                                              .copyWith(fontWeight: FontWeight.bold,color: APPSTYLE_PrimaryColor),
                                        ),
                                      ),
                                    ],
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
                                        Container(
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
                                                textAlign: TextAlign.center,
                                                style: getBodyMediumStyle(
                                                    context)
                                                    .copyWith(
                                                    fontWeight: APPSTYLE_FontWeightBold,
                                                    color:
                                                    APPSTYLE_Grey80),
                                              ),
                                              addVerticalSpace(APPSTYLE_SpaceSmall),

                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                addVerticalSpace(APPSTYLE_SpaceLarge*2),


                                addVerticalSpace(APPSTYLE_SpaceLarge*3),
                              ],
                            ),
                          )),
                    ),
                    Visibility(
                      visible:!eshopController.isCartDetailsFetching.value && eshopController.cart.value.orderLine.isNotEmpty,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: APPSTYLE_SpaceLarge,vertical: APPSTYLE_SpaceSmall),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(AppRouteNames.eshopAddressRoute);
                            },
                            style: getElevatedButtonStyle(context),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Text(
                                  '${eshopController.cart.value.total} KD',
                                  style: getHeadlineMediumStyle(context).copyWith(
                                      color: APPSTYLE_BackgroundWhite,
                                      fontWeight: APPSTYLE_FontWeightBold),
                                ),),
                                Text(
                                  "checkout".tr,
                                  style: getHeadlineMediumStyle(context).copyWith(
                                      color: APPSTYLE_BackgroundWhite,
                                      fontWeight: APPSTYLE_FontWeightBold),
                                ),
                                addHorizontalSpace(APPSTYLE_SpaceSmall),
                                const Icon(Ionicons.chevron_forward,color: APPSTYLE_BackgroundWhite )
                              ],
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
