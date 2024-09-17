 import 'package:dietsteps/feature_modules/address/models/shipping_address.model.address.dart';
import 'package:dietsteps/feature_modules/auth/controllers/register.controller.auth.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/available_genders.shared.constant.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/date_conversion.service.shared.dart';
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

class RegisterAboutmePage_Auth extends StatefulWidget {
  const RegisterAboutmePage_Auth({super.key});

  @override
  State<RegisterAboutmePage_Auth> createState() =>
      _RegisterAboutmePage_AuthState();
}

class _RegisterAboutmePage_AuthState
    extends State<RegisterAboutmePage_Auth> {
   RegisterController registerController =  Get.put(RegisterController());
   final GlobalKey<FormState> registerEnglishNameFormKey = GlobalKey<FormState>();
   var getArguments = Get.arguments;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(getArguments[0] is Address){
      registerController.updateAddressData(getArguments[0]);
      if(getArguments[1] is String){
        registerController.updateMobile(getArguments[1]);
      }
    }else{
      Get.back();
    }
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
                                    registerController.changeGender(VALID_GENDERS.male.name);
                                  },
                                  child: Container(
                                    height: size.height * 0.07,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color:registerController.gender.value==VALID_GENDERS.male.name?
                                      APPSTYLE_Black:APPSTYLE_Grey20,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(ASSETS_MALE,
                                          height: size.height * 0.05,
                                          color:registerController.gender.value==VALID_GENDERS.male.name?
                                          APPSTYLE_BackgroundWhite:APPSTYLE_Black ,
                                        ),
                                        addHorizontalSpace(APPSTYLE_SpaceSmall),
                                        Text(
                                          "Male",
                                          style: getBodyMediumStyle(context).copyWith(
                                            color:registerController.gender.value==VALID_GENDERS.male.name?
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
                                    registerController.changeGender(VALID_GENDERS.female.name);
                                  },
                                  child: Container(
                                    height: size.height * 0.07,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                      color:registerController.gender.value==VALID_GENDERS.female.name?
                                      APPSTYLE_Black:APPSTYLE_Grey20,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          ASSETS_FEMALE,
                                          height: size.height * 0.05,
                                          color:registerController.gender.value==VALID_GENDERS.female.name?
                                          APPSTYLE_BackgroundWhite:APPSTYLE_Black ,
                                        ),
                                        addHorizontalSpace(APPSTYLE_SpaceSmall),
                                        Text(
                                          "Female",
                                          style: getBodyMediumStyle(context).copyWith(
                                              color:registerController.gender.value==VALID_GENDERS.female.name?
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
                              controller: registerController.birthDayController.value,
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
                            'how_tall_q'.tr,
                            style: getBodyMediumStyle(context).copyWith(  fontWeight: APPSTYLE_FontWeightBold),
                            textAlign: TextAlign.start,
                          ),

                          addVerticalSpace(APPSTYLE_SpaceMedium),
                          Row(children: [
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller: registerController.heightTextEditingController.value,
                              validator: (password) =>
                                  checkIfNameFormValid(password,"height"),
                                keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                              decoration: InputDecoration(
                                hintText: 'height_in_cm'.tr,
                                label: Row(
                                  children: [
                                    Text('height'.tr),
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Text("*",style: TextStyle(color:APPSTYLE_GuideRed),),
                                    )
                                  ],
                                ),
                                isDense: true,
                              ),
                            ),),
                            addHorizontalSpace(APPSTYLE_SpaceMedium),

                            Expanded(
                              flex: 1,
                              child:

                            Text(
                              'cm'.tr,
                              style: getBodyMediumStyle(context).copyWith(),
                              textAlign: TextAlign.start,
                            ), ),
                          ],),
                          addVerticalSpace(APPSTYLE_SpaceLarge*2),
                          Text(
                            'what_is_weight_q'.tr,
                            style: getBodyMediumStyle(context).copyWith(  fontWeight: APPSTYLE_FontWeightBold),
                            textAlign: TextAlign.start,
                          ),
                          addVerticalSpace(APPSTYLE_SpaceMedium),
                          Row(children: [
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller: registerController.weightTextEditingController.value,
                              validator: (password) =>
                                  checkIfNameFormValid(password,"weight"),
                                keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                              decoration: InputDecoration(
                                hintText: 'weight_in_kg'.tr,
                                label: Row(
                                  children: [
                                    Text('weight'.tr),
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Text("*",style: TextStyle(color:APPSTYLE_GuideRed),),
                                    )
                                  ],
                                ),
                                isDense: true,
                              ),
                            ),),
                            addHorizontalSpace(APPSTYLE_SpaceMedium),

                            Expanded(
                              flex: 1,
                              child:

                            Text(
                              'Kg'.tr,
                              style: getBodyMediumStyle(context).copyWith(),
                              textAlign: TextAlign.start,
                            ), ),
                          ],),
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
                          if (registerEnglishNameFormKey.currentState!.validate() &&
                              !isSameDay(registerController.selectedDOB.value,DateTime.now())) {
                            Get.toNamed(AppRouteNames.registerOriginRoute);
                          }else{
                            if(isSameDay(registerController.selectedDOB.value,DateTime.now())){
                              showSnackbar(context, "when_bday_q".tr, "info");
                            }
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
           dob: registerController.selectedDOB.value,
           dobPicked: (DateTime selectedDob) {
             registerController.changeDob(selectedDob);
           }),
     );
   }
}
