 import 'package:dietsteps/feature_modules/auth/controllers/register.controller.auth.dart';

import 'package:dietsteps/shared_module/constants/available_sources.shared.constant.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
 import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
 import 'package:get/get.dart';
 import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterOriginPage_Auth extends StatefulWidget {
  const RegisterOriginPage_Auth({super.key});

  @override
  State<RegisterOriginPage_Auth> createState() =>
      _RegisterOriginPage_AuthState();
}

class _RegisterOriginPage_AuthState
    extends State<RegisterOriginPage_Auth> {

  RegisterController registerController =  Get.put(RegisterController());
  final sharedController = Get.find<SharedController>();
  var otherSourceTextFieldFocusNode = FocusNode();

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
        body: SafeArea(
          child: Obx(
                ()=> Container(
              padding: APPSTYLE_LargePaddingHorizontal,
              height: screenheight,
              child:Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        addVerticalSpace(APPSTYLE_SpaceLarge ),

                        Text(
                          'let_us_know_how_you_found_us'.tr,
                          style: getHeadlineLargeStyle(context).copyWith(
                              fontWeight: APPSTYLE_FontWeightBold),
                          textAlign: TextAlign.start,
                        ),

                        addVerticalSpace(APPSTYLE_SpaceLarge ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              activeColor: APPSTYLE_PrimaryColor,
                              value: VALID_SOURCES.social.name,
                              onChanged: (value) {
                                if(value != null){
                                  registerController.changeSource(VALID_SOURCES.social.name);
                                }
                              }, groupValue: registerController.source.value),
                            TextButton(
                                onPressed: () {},
                                child: Text("social_media".tr,
                                    style: getLabelLargeStyle(context))),
                          ],
                        ),
                        addVerticalSpace(APPSTYLE_SpaceExtraSmall ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              activeColor: APPSTYLE_PrimaryColor,
                              value: VALID_SOURCES.friends.name,
                              onChanged: (value) {
                                if(value != null){
                                  registerController.changeSource(VALID_SOURCES.friends.name);
                                }
                              }, groupValue: registerController.source.value,),
                            TextButton(
                                onPressed: () {},
                                child: Text("through_a_friend".tr,
                                    style: getLabelLargeStyle(context))),
                          ],
                        ),
                        addVerticalSpace(APPSTYLE_SpaceExtraSmall ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              activeColor: APPSTYLE_PrimaryColor,
                              value: VALID_SOURCES.other.name,
                              onChanged: (value) {
                                if(value != null){
                                  registerController.changeSource(VALID_SOURCES.other.name);
                                  otherSourceTextFieldFocusNode.requestFocus();

                                }
                              }, groupValue: registerController.source.value,),
                            TextButton(
                                onPressed: () {},
                                child: Text("others".tr,
                                    style: getLabelLargeStyle(context))),
                          ],
                        ),
                        addVerticalSpace(APPSTYLE_SpaceMedium ),

                        Visibility(
                          visible: registerController.source.value == VALID_SOURCES.other.name,
                          child: TextFormField(
                            focusNode: otherSourceTextFieldFocusNode,
                            controller: registerController.otherSourceTextEditingController.value,
                            decoration:
                            InputDecoration(hintText: "let_us_know_how_you_found_us".tr),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          child: Text('skip'.tr,
                              textAlign: TextAlign.center,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: FontWeight.bold,
                                  color: APPSTYLE_BackgroundWhite)),
                          onPressed: () {

                            FocusManager.instance.primaryFocus?.unfocus();
                            if (  !registerController.isRegisterSubmitting.value) {
                              registerController.handleRegistration("");
                            }
                          }),
                    ],
                  ),
                  addVerticalSpace(APPSTYLE_SpaceMedium),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 0,vertical: APPSTYLE_SpaceSmall),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (  !registerController.isRegisterSubmitting.value) {
                            registerController.handleRegistration(registerController.source.value);
                          }
                        },
                        style: getElevatedButtonStyle(context),
                        child:sharedController.isUserDataFetching.value  || registerController.isRegisterSubmitting.value
                            ? LoadingAnimationWidget.staggeredDotsWave(
                          color: APPSTYLE_BackgroundWhite,
                          size: 24,
                        ):  Text(
                            "continue".tr,
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
}
