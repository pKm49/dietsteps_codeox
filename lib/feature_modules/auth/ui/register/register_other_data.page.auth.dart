import 'package:dietsteps/feature_modules/auth/controllers/register.controller.auth.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
 import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/valid_phoneverification_modes.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
 import 'package:dietsteps/shared_module/services/utility-services/form_validator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_curve_shape.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterOtherDataPage_Auth extends StatelessWidget {
  RegisterOtherDataPage_Auth({super.key});

  RegisterController registerController =  Get.put(RegisterController());
  final GlobalKey<FormState> registerEnglishNameFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: APPSTYLE_PrimaryColor,
          scrolledUnderElevation:0.0,
          elevation: 0.0,
          title: Row(
            children: [
              CustomBackButton(isPrimaryMode: false),
            ],
          ),
          actions: [
            LanguagePreviewButtonComponentShared(textColor:APPSTYLE_BackgroundWhite),
            addHorizontalSpace(APPSTYLE_SpaceLarge)
          ],
        ),
        body: SafeArea(
          child: Obx(
                ()=> Container(
              height: screenheight,
              child: Column(
                children: [

                  Expanded(
                    child: Form(
                      key: registerEnglishNameFormKey,
                      child: ListView(
                        children: [
                          CustomCurveShapeComponent_Shared(
                            color: APPSTYLE_PrimaryColor,
                            title: "sign_up".tr,
                            subtitle: '',
                          ),
                          Padding(
                            padding: APPSTYLE_LargePaddingHorizontal,
                            child: TextFormField(
                              controller: registerController.firstNameArabicTextEditingController.value,
                              // validator: (email) =>
                              //     checkIfArabicNameValid(email, 'first_name_ar',false),
                              decoration: InputDecoration(
                                hintText: 'first_name_ar_hint'.tr,
                                label: Row(
                                  children: [
                                    Text('first_name_ar'.tr),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "*",
                                        style: TextStyle(color: APPSTYLE_GuideRed),
                                      ),
                                    )
                                  ],
                                ),
                                isDense: true,
                              ),
                            ),
                          ),
                          addVerticalSpace(APPSTYLE_SpaceMedium),
                          Padding(
                            padding: APPSTYLE_LargePaddingHorizontal,
                            child: TextFormField(
                              controller: registerController.lastNameArabicTextEditingController.value,
                              // validator: (email) =>
                              //     checkIfArabicNameValid(email, 'last_name_ar',false),
                              decoration: InputDecoration(
                                hintText: 'last_name_ar_hint'.tr,
                                label: Row(
                                  children: [
                                    Text('last_name_ar'.tr),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "*",
                                        style: TextStyle(color: APPSTYLE_GuideRed),
                                      ),
                                    )
                                  ]
                                ),
                                isDense: true,
                              ),
                            ),
                          ),
                          addVerticalSpace(APPSTYLE_SpaceMedium),
                          Padding(
                            padding: APPSTYLE_LargePaddingHorizontal,
                            child: TextFormField(
                              controller: registerController.emailTextEditingController.value,
                              validator: (email) => checkIfEmailFormValid(email),
                              decoration: InputDecoration(
                                hintText: 'enter_email'.tr,
                                label: Row(
                                  children: [
                                    Text('email'.tr),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "*",
                                        style: TextStyle(color: APPSTYLE_GuideRed),
                                      ),
                                    )
                                  ],
                                ),
                                isDense: true,
                              ),
                            ),
                          ),
                          addVerticalSpace(APPSTYLE_SpaceMedium),
                          Padding(
                            padding: APPSTYLE_LargePaddingHorizontal,
                            child: TextFormField(
                              controller: registerController.passwordTextEditingController.value,

                              validator: (password) =>
                                  checkIfPasswordFieldValid(password),
                              decoration: InputDecoration(
                                hintText: 'enter_password'.tr,
                                label: Row(
                                  children: [
                                    Text('password'.tr),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "*",
                                        style: TextStyle(color: APPSTYLE_GuideRed),
                                      ),
                                    )
                                  ],
                                ),
                                isDense: true,
                              ),
                            ),
                          ),
                          addVerticalSpace(APPSTYLE_SpaceMedium),
                          Padding(
                            padding: APPSTYLE_LargePaddingHorizontal,
                            child: TextFormField(
                              controller: registerController.confirmPasswordTextEditingController.value,

                              validator: (confirm_password) =>
                                  checkIfConfirmPasswordFieldValid(
                                      confirm_password,registerController.passwordTextEditingController.value.text),
                              decoration: InputDecoration(
                                hintText: 're_enter_password'.tr,
                                label: Row(
                                  children: [
                                    Text('confirm_password'.tr),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "*",
                                        style: TextStyle(color: APPSTYLE_GuideRed),
                                      ),
                                    )
                                  ],
                                ),
                                isDense: true,
                              ),
                            ),
                          ),
                          addVerticalSpace(APPSTYLE_SpaceLarge ),

                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: APPSTYLE_SpaceLarge,vertical: APPSTYLE_SpaceSmall),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (registerEnglishNameFormKey.currentState!.validate() ) {
                            handleSubmit();
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

  void handleSubmit() {
    Get
        .toNamed(
        AppRouteNames
            .otpVerificationMobileInputRoute,
        arguments: [VALIDPHONEVERIFICATION_MODES.register]);
  }
}
