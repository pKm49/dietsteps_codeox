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

class OrderListPage_Eshop extends StatefulWidget {
  const OrderListPage_Eshop({super.key});

  @override
  State<OrderListPage_Eshop> createState() =>
      _OrderListPage_EshopState();
}

class _OrderListPage_EshopState
    extends State<OrderListPage_Eshop> {
  final sharedController = Get.find<SharedController>();
  final eshopController = Get.find<EshopController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eshopController.getOrders();
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
                      'orders'.tr,
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
                      visible: eshopController.isOrdersFetching.value,
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
                visible: !eshopController.isOrdersFetching.value && eshopController.orders.isEmpty,
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
                            Text("no_orders_found".tr,
                                style: getHeadlineMediumStyle(context)),
                          ],
                        )),
                  ),
                )),
                    Visibility(
                      visible: !eshopController.isOrdersFetching.value && eshopController.orders.isNotEmpty,
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

                                addVerticalSpace(APPSTYLE_SpaceMedium),
                                for(var i=0;i<eshopController.orders.length;i++)
                                  Container(
                                      decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                                      padding: APPSTYLE_MediumPaddingAll,
                                      margin: APPSTYLE_LargePaddingHorizontal.copyWith(bottom: APPSTYLE_SpaceSmall),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('# ${eshopController.orders[i].orderReference}',
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                style: getHeadlineMediumStyle(
                                                    context)
                                                    .copyWith(
                                                    fontWeight: APPSTYLE_FontWeightBold,
                                                    color:
                                                    APPSTYLE_Grey80),
                                              ),

                                              Container(
                                                decoration: APPSTYLE_BorderedContainerExtraSmallDecoration.
                                                copyWith(color: APPSTYLE_PrimaryColor),
                                                padding: APPSTYLE_ExtraSmallPaddingVertical.copyWith(left: APPSTYLE_SpaceSmall,right: APPSTYLE_SpaceSmall),
                                                child: Text('${eshopController.orders[i].state}',style: getLabelLargeStyle(context).copyWith(color: APPSTYLE_BackgroundWhite)),
                                              ),

                                            ],
                                          ),
                                          addVerticalSpace(APPSTYLE_SpaceSmall),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [

                                              Container(
                                                decoration: APPSTYLE_BorderedContainerExtraSmallDecoration.
                                                copyWith(color: APPSTYLE_PrimaryColorBgLight),
                                                padding: APPSTYLE_ExtraSmallPaddingVertical.copyWith(left: APPSTYLE_SpaceSmall,right: APPSTYLE_SpaceSmall),
                                                child: Text('Total : ${eshopController.orders[i].total} KD',style: getLabelLargeStyle(context).copyWith(color: APPSTYLE_BackgroundWhite)),
                                              ),

                                              Text('${eshopController.orders[i].invoiceReference}',
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                style: getHeadlineMediumStyle(
                                                    context)
                                                    .copyWith(
                                                    color:
                                                    APPSTYLE_Grey80),
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
                                            addVerticalSpace(APPSTYLE_SpaceSmall),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.calendar_month,size: APPSTYLE_FontSize20,),
                                              addHorizontalSpace(APPSTYLE_SpaceExtraSmall),
                                              Expanded(
                                                child: FittedBox(
                                                  alignment: Alignment.centerLeft,
                                                  fit:BoxFit.scaleDown,
                                                  child: Text( eshopController.orders[i].orderDate ,
                                                    style: getBodyMediumStyle(context),textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ),
                                addVerticalSpace(APPSTYLE_SpaceLarge*2),


                                addVerticalSpace(APPSTYLE_SpaceLarge*3),
                              ],
                            ),
                          )),
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
