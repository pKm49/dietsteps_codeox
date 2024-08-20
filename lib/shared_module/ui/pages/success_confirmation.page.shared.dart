  import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/valid_addressauthor_modes.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessConfirmationPage_Shared extends StatefulWidget {
  const SuccessConfirmationPage_Shared({super.key});

  @override
  State<SuccessConfirmationPage_Shared> createState() =>
      _SuccessConfirmationPage_SharedState();
}

class _SuccessConfirmationPage_SharedState
    extends State<SuccessConfirmationPage_Shared> {
  var getArguments = Get.arguments;
  String assetUrl = ASSETS_SUCCESSMARK;
  String pageTitle = "password_changed";
  String pageInfo = "password_changed_message";
  String buttonText = "back_to_login";
  String toRoute = AppRouteNames.addressAuditRoute;
  String mobile = "";
  bool isButtonPrimary = true;

  @override
  void initState() {
    // TODO: implement initState

    assetUrl = getArguments[0];
    pageTitle = getArguments[1];
    pageInfo = getArguments[2];
    buttonText = getArguments[3];
    isButtonPrimary = getArguments[4];
    toRoute = getArguments[5];
    mobile = getArguments[6];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: APPSTYLE_BackgroundWhite,
        elevation: 0.0,
        scrolledUnderElevation:0.0,

        actions: [
          LanguagePreviewButtonComponentShared(textColor:APPSTYLE_PrimaryColor),
          addHorizontalSpace(APPSTYLE_SpaceLarge)
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          height: screenheight,
          width: screenwidth,
          padding: APPSTYLE_LargePaddingAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView(

                  children: [
                    addVerticalSpace(APPSTYLE_SpaceLarge*4),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          assetUrl,
                          width: screenwidth * .5,
                        ),
                      ],
                    ),
                    addVerticalSpace(APPSTYLE_SpaceLarge),
                    Text(pageTitle.tr,
                        textAlign: TextAlign.center,
                        style: getHeadlineLargeStyle(context).copyWith(
                            fontSize: APPSTYLE_FontSize24*1.5 )),
                    addVerticalSpace(APPSTYLE_SpaceLarge),
                    Text(pageInfo.tr,
                        textAlign: TextAlign.center,
                        style: getHeadlineMediumStyle(context).copyWith()),

                    addVerticalSpace(APPSTYLE_SpaceLarge * 3),

                  ],
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: getElevatedButtonStyle(context),
                      child: Text(
                        buttonText.tr,
                        style: getHeadlineMediumStyle(context).copyWith(
                            color: APPSTYLE_BackgroundWhite,fontWeight: APPSTYLE_FontWeightBold),
                      ),
                      onPressed: () async {
                        //       showSnackbar(Get.context!, "password_reset".tr, "info");
                        if(toRoute == AppRouteNames.addressAuditRoute){
                          print("sending mobile is");
                          print(mobile);
                          Get.toNamed(
                              AppRouteNames.addressAuditRoute,arguments:
                          [VALIDADDRESSAUTHOR_MODES.complete_registration,mobile]);
                        }else if(toRoute == AppRouteNames.loginRoute){
                          showSnackbar(Get.context!, "login_message".tr, "info");
                          final sharedController = Get.find<SharedController>();
                          await sharedController.handleLogout();
                        }else{
                          Get.offAllNamed(toRoute);
                        }

                      })),
            ],
          ),
        ),
      ),
    );
  }
}
