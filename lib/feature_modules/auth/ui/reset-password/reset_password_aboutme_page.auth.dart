 import 'package:dietsteps/feature_modules/address/models/shipping_address.model.address.dart';
import 'package:dietsteps/feature_modules/auth/controllers/register.controller.auth.dart';
import 'package:dietsteps/feature_modules/auth/controllers/reset_password.controller.auth.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/available_genders.shared.constant.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/form_validator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/dob_picker.profile.component.dart';
import 'package:dietsteps/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ResetPasswordAboutMePage_Auth extends StatefulWidget {
  const ResetPasswordAboutMePage_Auth({super.key});

  @override
  State<ResetPasswordAboutMePage_Auth> createState() =>
      _ResetPasswordAboutMePage_AuthState();
}

class _ResetPasswordAboutMePage_AuthState
    extends State<ResetPasswordAboutMePage_Auth> {
  ResetPasswordController resetPasswordController =  Get.put(ResetPasswordController());
   final GlobalKey<FormState> registerEnglishNameFormKey = GlobalKey<FormState>();
   var getArguments = Get.arguments;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'about_me'.tr,
                    style: getHeadlineLargeStyle(context).copyWith(
                        fontWeight: APPSTYLE_FontWeightBold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
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
                    child: Form(
                      key: registerEnglishNameFormKey,
                      child: ListView(
                        children: [

                          addVerticalSpace(APPSTYLE_SpaceLarge  ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    resetPasswordController.changeGender(VALID_GENDERS.male.name);
                                  },
                                  child: Container(
                                    height: size.height * 0.07,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color:resetPasswordController.gender.value==VALID_GENDERS.male.name?
                                      APPSTYLE_Black:APPSTYLE_Grey20,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(ASSETS_MALE,
                                          height: size.height * 0.05,
                                          color:resetPasswordController.gender.value==VALID_GENDERS.male.name?
                                          APPSTYLE_BackgroundWhite:APPSTYLE_Black ,
                                        ),
                                        addHorizontalSpace(APPSTYLE_SpaceSmall),
                                        Text(
                                          "Male",
                                          style: getBodyMediumStyle(context).copyWith(
                                            color:resetPasswordController.gender.value==VALID_GENDERS.male.name?
                                            APPSTYLE_BackgroundWhite:APPSTYLE_Black ,
                                            fontWeight: APPSTYLE_FontWeightBold
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              addHorizontalSpace(APPSTYLE_SpaceMedium),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    resetPasswordController.changeGender(VALID_GENDERS.female.name);
                                  },
                                  child: Container(
                                    height: size.height * 0.07,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                      color:resetPasswordController.gender.value==VALID_GENDERS.female.name?
                                      APPSTYLE_Black:APPSTYLE_Grey20,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          ASSETS_FEMALE,
                                          height: size.height * 0.05,
                                          color:resetPasswordController.gender.value==VALID_GENDERS.female.name?
                                          APPSTYLE_BackgroundWhite:APPSTYLE_Black ,
                                        ),
                                        addHorizontalSpace(APPSTYLE_SpaceSmall),
                                        Text(
                                          "Female",
                                          style: getBodyMediumStyle(context).copyWith(
                                              color:resetPasswordController.gender.value==VALID_GENDERS.female.name?
                                              APPSTYLE_BackgroundWhite:APPSTYLE_Black ,
                                              fontWeight: APPSTYLE_FontWeightBold
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          addVerticalSpace(APPSTYLE_SpaceLarge*2),
                          Text(
                            'when_bday_q'.tr,
                            style: getBodyMediumStyle(context).copyWith(  fontWeight: APPSTYLE_FontWeightBold),
                            textAlign: TextAlign.start,
                          ),
                          addVerticalSpace(APPSTYLE_SpaceMedium),
                          TextFormField(
                              controller: resetPasswordController.birthDayController.value,
                              onTap: () {
                                showDOBPickerDialog();
                              },
                              showCursor: true,
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText:'${'day'.tr} / ${'month'.tr} / ${'year'.tr}',
                                labelText:  'birthday'.tr,
                              )),
                          addVerticalSpace(APPSTYLE_SpaceLarge * 2),
                          Text(
                            'enter_email'.tr,
                            style: getBodyMediumStyle(context).copyWith(  fontWeight: APPSTYLE_FontWeightBold),
                            textAlign: TextAlign.start,
                          ),
                          addVerticalSpace(APPSTYLE_SpaceMedium),
                          TextFormField(
                            controller: resetPasswordController.emailTextEditingController.value,
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

                          addVerticalSpace(APPSTYLE_SpaceLarge  ),

                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 0,vertical: APPSTYLE_SpaceSmall),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();



                          if ( !resetPasswordController.isResetingPassword.value) {
                            resetPasswordController.resetPassword();
                          }
                        },
                        style: getElevatedButtonStyle(context),
                        child: Text(
                            "continue".tr,
                            style: getHeadlineMediumStyle(context).copyWith(
                                color: APPSTYLE_BackgroundWhite,
                                fontWeight: APPSTYLE_FontWeightBold)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

   showDOBPickerDialog() async {
     showDialog(
       context: context,
       builder: (_) => DOBPicker(
           dob: resetPasswordController.selectedDOB.value,
           dobPicked: (DateTime selectedDob) {
             resetPasswordController.changeDob(selectedDob);
           }),
     );
   }
}
