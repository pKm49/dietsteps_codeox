import 'package:dietsteps/feature_modules/auth/controllers/login.controller.auth.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/valid_phoneverification_modes.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/form_validator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class LoginPage_Auth extends StatefulWidget {
  const LoginPage_Auth({super.key});

  @override
  State<LoginPage_Auth> createState() => _LoginPage_AuthState();
}

class _LoginPage_AuthState extends State<LoginPage_Auth> {

  final loginController = Get.put(LoginController());
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final sharedController = Get.find<SharedController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          handleRequestSupportClick(context, true);
        },
        child: Icon(Ionicons.logo_whatsapp, color: APPSTYLE_BackgroundWhite),
        backgroundColor: APPSTYLE_WhatsappGreen,
        shape: const CircleBorder(),
      ),
      resizeToAvoidBottomInset: true,
      body:Obx(
            () => Container(
          width: screenwidth,
          height: screenheight,
          decoration: BoxDecoration(

            image: DecorationImage(
              alignment: Alignment(-.2, 0),
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
                  children: [
                    addVerticalSpace(APPSTYLE_SpaceLarge),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        LanguagePreviewButtonComponentShared(textColor:APPSTYLE_BackgroundWhite)
                      ],),
                    Expanded(
                      child: Form(
                        key: loginFormKey,
                        child: ListView(
                          children: [
                            Center(
                              child:             Image.asset(ASSETS_NAMELOGO, width: screenwidth*.2),
                            ),
                            addVerticalSpace(APPSTYLE_SpaceLarge),

                            Text("welcome_back".tr,
                                textAlign: TextAlign.center,
                                style: getHeadlineLargeStyle(context).copyWith(
                                    fontSize: APPSTYLE_FontSize24*1.5,
                                    color: APPSTYLE_BackgroundWhite)),
                            addVerticalSpace(APPSTYLE_SpaceLarge*3),
                            TextFormField(
                                controller:
                                loginController.mobileTextEditingController.value,
                                validator: (value) => checkIfMobileNumberValid(value),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    floatingLabelBehavior: FloatingLabelBehavior.never,

                                    hintText: 'enter_mobile_number'.tr
                                )),
                            addVerticalSpace(APPSTYLE_SpaceMedium),
                            TextFormField(
                                controller:
                                loginController.passwordTextEditingController.value,
                                validator: (value) => checkIfPasswordFieldValid(value),
                                decoration: InputDecoration(
                                    floatingLabelBehavior: FloatingLabelBehavior.never,

                                    hintText: 'enter_password'.tr
                                )),
                            addVerticalSpace(APPSTYLE_SpaceMedium),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    child: Text('forgot_password_q'.tr,
                                        textAlign: TextAlign.center,
                                        style: getBodyMediumStyle(context)
                                            .copyWith(fontWeight: FontWeight.bold,
                                            color: APPSTYLE_BackgroundWhite)),
                                    onPressed: () {

                                      handleResetPasswordClick();

                                    }),
                              ],
                            ),
                            addVerticalSpace(APPSTYLE_SpaceLarge * 3),
                            SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    child:sharedController.isUserDataFetching.value  || loginController.isLoginSubmitting.value
                                        ? LoadingAnimationWidget.staggeredDotsWave(
                                      color: APPSTYLE_BackgroundWhite,
                                      size: 24,
                                    ):  Text('login'.tr,
                                        style: getHeadlineMediumStyle(context).copyWith(
                                            color: APPSTYLE_BackgroundWhite,fontWeight: APPSTYLE_FontWeightBold),
                                        textAlign: TextAlign.center),
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      if (loginFormKey.currentState!.validate() &&
                                          !loginController.isLoginSubmitting.value) {
                                        loginController.handleLogin();
                                      }
                                    })),
                            addVerticalSpace(APPSTYLE_SpaceLarge ),

                            SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(APPSTYLE_BackgroundWhite)
                                    ),
                                    child:   Text('sign_up'.tr,
                                        style: getHeadlineMediumStyle(context).copyWith(
                                            color: APPSTYLE_PrimaryColor,fontWeight: APPSTYLE_FontWeightBold),
                                        textAlign: TextAlign.center),
                                    onPressed: () {
                                      Get.toNamed(AppRouteNames.registerEnglishNameRoute);
                                    })),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> handleRequestSupportClick(
      BuildContext buildContext, bool isWhatsapp) async {
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

  void handleResetPasswordClick() {
    Get
        .toNamed(
        AppRouteNames
            .otpVerificationMobileInputRoute,
        arguments: [
          VALIDPHONEVERIFICATION_MODES.reset_password ]);
  }
}
