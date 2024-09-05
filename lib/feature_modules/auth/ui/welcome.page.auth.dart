import 'package:dietsteps/feature_modules/auth/controllers/meals.controller.auth.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class WelcomePage_Auth extends StatelessWidget {
  WelcomePage_Auth({super.key});



  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: screenwidth,
        height: screenheight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ASSETS_WELCOME_LOGIN_BG),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              color: APPSTYLE_Grey80Shadow40,
            ),
            Container(

              padding: APPSTYLE_LargePaddingAll,
              child: ListView(
                children: [
                  addVerticalSpace(APPSTYLE_SpaceLarge),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ASSETS_NAMELOGO, width: screenwidth*.35),
                    ],
                  ),
                  addVerticalSpace(APPSTYLE_SpaceLarge*2 ),
                  Text("welcome_message_title".tr,
                      textAlign: TextAlign.center,
                      style: getHeadlineLargeStyle(context).copyWith(
                          fontSize: APPSTYLE_FontSize24*1.5,
                          color: APPSTYLE_BackgroundWhite)),
                  addVerticalSpace(APPSTYLE_SpaceLarge*2),
                  Text("welcome_message_description".tr,
                      textAlign: TextAlign.center,
                      style: getHeadlineMediumStyle(context).copyWith(color: APPSTYLE_BackgroundWhite)),
                  addVerticalSpace(APPSTYLE_SpaceLarge*5),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(APPSTYLE_BackgroundWhite)
                          ),
                          child:   Text('login'.tr,
                              style: getHeadlineMediumStyle(context).copyWith(
                                  color: APPSTYLE_Black,fontWeight: APPSTYLE_FontWeightBold),
                              textAlign: TextAlign.center),
                          onPressed: () {
                            Get.toNamed(AppRouteNames.loginRoute);
                          })),

                  // addVerticalSpace(APPSTYLE_SpaceMedium),
                  // SizedBox(
                  //
                  //     width: double.infinity,
                  //     child:OutlinedButton(
                  //       style: OutlinedButton.styleFrom(
                  //         side: const BorderSide(width: 2.0, color: APPSTYLE_BackgroundWhite),
                  //       ),
                  //       onPressed: () {
                  //         Get.toNamed(AppRouteNames.planPurchaseSubscriptionPlansCategoryListRoute);
                  //       },
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Image.asset(ASSETS_SUBSCRIPTIONS,width: 30,),
                  //
                  //           addHorizontalSpace(APPSTYLE_SpaceMedium),
                  //           Text('view_subscriptions'.tr,
                  //               style: getHeadlineMediumStyle(context).copyWith(
                  //                   color: APPSTYLE_BackgroundWhite,fontWeight: APPSTYLE_FontWeightBold),
                  //               textAlign: TextAlign.center),
                  //         ],
                  //       ),
                  //     ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
