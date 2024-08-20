import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePage_Auth extends StatelessWidget {
  const WelcomePage_Auth({super.key});

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  addVerticalSpace(APPSTYLE_SpaceLarge),

                  Expanded(child: Center(
                    child:             Image.asset(ASSETS_NAMELOGO, width: screenwidth*.3),
                  )),
                  addVerticalSpace(APPSTYLE_SpaceLarge ),
                  Text("welcome_message_title".tr,
                      textAlign: TextAlign.center,
                      style: getHeadlineLargeStyle(context).copyWith(
                          fontSize: APPSTYLE_FontSize24*1.5,
                          color: APPSTYLE_BackgroundWhite)),
                  addVerticalSpace(APPSTYLE_SpaceLarge*2),
                  Text("welcome_message_description".tr,
                      textAlign: TextAlign.center,
                      style: getHeadlineMediumStyle(context).copyWith(color: APPSTYLE_BackgroundWhite)),
                  addVerticalSpace(APPSTYLE_SpaceLarge*3),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
