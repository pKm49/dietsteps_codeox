import 'package:dietsteps/feature_modules/auth/controllers/reset_password.controller.auth.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';

import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/form_validator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
 import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ResetPasswordPage_auth extends StatefulWidget {
  ResetPasswordPage_auth({super.key});

  @override
  State<ResetPasswordPage_auth> createState() => _ResetPasswordPage_authState();
}

class _ResetPasswordPage_authState extends State<ResetPasswordPage_auth> {
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  ResetPasswordController resetPasswordController = Get.put(ResetPasswordController());

  var mobile = "";

  var getArguments = Get.arguments;


  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      mobile = getArguments[0]??"";
      if(mobile!=""){
        resetPasswordController.updateMobile(mobile);
      }
    }

  @override
  Widget build(BuildContext context) {

    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar:AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: APPSTYLE_BackgroundWhite,
          scrolledUnderElevation:0.0,
          elevation: 0.0,
          title: Row(
            children: [
              CustomBackButton(isPrimaryMode:false),
            ],
          ),
          actions: [
            LanguagePreviewButtonComponentShared(textColor:APPSTYLE_PrimaryColor),
            addHorizontalSpace(APPSTYLE_SpaceLarge)
          ],
        ) ,
        body:  SafeArea(
            child:Obx(
                  ()=> Container(
                padding: APPSTYLE_LargePaddingAll,
                height: screenheight,
                child: Column(
                  children: [
                    Expanded(
                      child: Form(
                        key: resetPasswordFormKey,
                        child: ListView(
                          children: [
                            Text(
                              'create_new_password'.tr,
                              style: getHeadlineLargeStyle(context).copyWith(
                                  fontWeight: APPSTYLE_FontWeightBold),
                              textAlign: TextAlign.center,
                            ),
                            addVerticalSpace(APPSTYLE_SpaceLarge * 2),

                            TextFormField(
                              controller: resetPasswordController.passwordTextEditingController.value,
                              validator: (password) =>
                                  checkIfPasswordFieldValid(password),
                              decoration: InputDecoration(
                                hintText: 'new_password'.tr,
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
                            addVerticalSpace(APPSTYLE_SpaceMedium),
                            TextFormField(
                              controller: resetPasswordController.confirmPasswordTextEditingController.value,
                              validator: (confirm_password) =>
                                  checkIfConfirmPasswordFieldValid(
                                      confirm_password, resetPasswordController.passwordTextEditingController.value.text),
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

                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (resetPasswordFormKey.currentState!.validate() &&
                              !resetPasswordController.isResetingPassword.value) {
                            Get.toNamed(AppRouteNames.resetPasswordAboutMeRoute);
                          }

                        },
                        style: getElevatedButtonStyle(context),
                        child:resetPasswordController.isResetingPassword.value
                            ? LoadingAnimationWidget.staggeredDotsWave(
                          color: APPSTYLE_BackgroundWhite,
                          size: 24,
                        ): Text("submit".tr,
                            style: getHeadlineMediumStyle(context).copyWith(
                                color: APPSTYLE_BackgroundWhite,
                                fontWeight: APPSTYLE_FontWeightBold),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ) ;
  }
}
