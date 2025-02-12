import 'dart:convert';
import 'dart:io';

import 'package:dietsteps/feature_modules/auth/controllers/register.controller.auth.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/form_validator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_curve_shape.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/photo_selector.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/update_profile_pic.profile.component.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class RegisterNameEnglishPage_Auth extends StatefulWidget {
    RegisterNameEnglishPage_Auth({super.key});

  @override
  State<RegisterNameEnglishPage_Auth> createState() => _RegisterNameEnglishPage_AuthState();
}

class _RegisterNameEnglishPage_AuthState extends State<RegisterNameEnglishPage_Auth> {

   RegisterController registerController =  Get.put(RegisterController());
  final GlobalKey<FormState> registerEnglishNameFormKey = GlobalKey<FormState>();
   var getArguments = Get.arguments;
  var from=AppRouteNames.loginRoute;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    from = getArguments[0]??AppRouteNames.loginRoute;
    registerController.updateFrom(from);
  }

  @override
  Widget build(BuildContext context) {

    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar:AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation:0.0,
          backgroundColor: APPSTYLE_PrimaryColor,
          elevation: 0.0,
          title: Row(
            children: [
              CustomBackButton(isPrimaryMode:false),
            ],
          ),
          actions: [
            LanguagePreviewButtonComponentShared(textColor:APPSTYLE_BackgroundWhite),
            addHorizontalSpace(APPSTYLE_SpaceLarge)
          ],
        ) ,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              UpdateProfilePic(
                                onClick: () {
                                  openSourceSelector(context);
                                },
                                borderColor: APPSTYLE_PrimaryColorBg,
                                profilePictureUrl: registerController.profilePictureUrl.value,
                              ),
                            ],
                          ),
                          addVerticalSpace(APPSTYLE_SpaceMedium),

                          InkWell(
                            onTap: (){
                              openSourceSelector(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Ionicons.camera_outline,size: APPSTYLE_FontSize20,color:APPSTYLE_Grey80),
                                addHorizontalSpace(APPSTYLE_SpaceSmall),
                                Text( 'upload_profile_picture'.tr,
                                    textAlign: TextAlign.center,
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: APPSTYLE_Grey80,decoration: TextDecoration.underline)),
                              ],
                            ),
                          ),
                          addVerticalSpace(APPSTYLE_SpaceLarge * 2),
                          Padding(
                            padding: APPSTYLE_LargePaddingHorizontal,
                            child: TextFormField(
                              controller: registerController.firstNameEnglishTextEditingController.value,
                              validator: (email) => checkIfNameFormValid(email,'first_name_en'),
                              decoration: InputDecoration(
                                hintText: 'first_name_en_hint'.tr,
                                label: Row(
                                  children: [
                                    Text('first_name_en'.tr),
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Text("*",style: TextStyle(color:APPSTYLE_GuideRed),),
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
                              controller: registerController.lastNameEnglishTextEditingController.value,
                              validator: (email) => checkIfNameFormValid(email,'last_name_en'),
                              decoration: InputDecoration(
                                hintText: 'last_name_en_hint'.tr,
                                label: Row(
                                  children: [
                                    Text('last_name_en'.tr),
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Text("*",style: TextStyle(color:APPSTYLE_GuideRed),),
                                    )
                                  ],
                                ),
                                isDense: true,
                              ),
                            ),
                          ),
                          addVerticalSpace(APPSTYLE_SpaceLarge * 2),

                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: APPSTYLE_SpaceLarge),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: '${'accept'.tr}   ',
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: APPSTYLE_Grey80),
                                    children: <TextSpan>[
                                      TextSpan(
                                          recognizer: new TapGestureRecognizer()
                                            ..onTap = () => Get.toNamed(AppRouteNames.termsRoute),
                                          text: 'terms_n_conditions'.tr,
                                          style: TextStyle(
                                              fontWeight:
                                              APPSTYLE_FontWeightBold,
                                              decoration:
                                              TextDecoration.underline)),
                                    ],
                                  ),
                                ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      getColor),
                                  value:true,
                                  onChanged: (bool? value) {
                                    // showConfirmDialog(value, 'checkout');
                                  },
                                ),
                              ],
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
                            Get.toNamed(AppRouteNames.registerOtherDataRoute);
                          }
                        },
                        style: getElevatedButtonStyle(context),
                        child: Text(
                            "continue".tr,
                            style: getHeadlineMediumStyle(context).copyWith(
                                color: APPSTYLE_BackgroundWhite,
                                fontWeight: APPSTYLE_FontWeightBold),
                            textAlign: TextAlign.center
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

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return APPSTYLE_PrimaryColor;
    }
    return APPSTYLE_PrimaryColor;
  }
  
  void openSourceSelector(context) {
    showDialog(
      context: context,
      builder: (_) => PhotoSelector(
        photoSelected: (File? pictureFile) {
          if (pictureFile != null) {
            Uint8List imageBytes = pictureFile.readAsBytesSync();
              registerController.updateProfilePicture(base64Encode(imageBytes));

          }
          setState(() {});
        },
      ),
    ).then((valueFromDialog) {
      // use the value as you wish

    });
  }
}

