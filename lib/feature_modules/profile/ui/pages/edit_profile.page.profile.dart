

 import 'dart:convert';
import 'dart:io';

import 'package:dietsteps/feature_modules/profile/controllers/profile.controller.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/available_genders.shared.constant.dart';
 import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/valid_phoneverification_modes.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/form_validator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/dob_picker.profile.component.dart';
import 'package:dietsteps/shared_module/ui/components/photo_selector.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/update_profile_pic.profile.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

class EditProfilePage_Profile extends StatefulWidget {
    EditProfilePage_Profile({super.key});

  @override
  State<EditProfilePage_Profile> createState() => _EditProfilePage_ProfileState();
}

class _EditProfilePage_ProfileState extends State<EditProfilePage_Profile> {
  final profileController = Get.find<ProfileController>();
  final GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();
  final sharedController = Get.find<SharedController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenhight = MediaQuery.of(context).size.height;

    return Obx(
      ()=> Scaffold(
        appBar:AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation:0.0,
          backgroundColor: APPSTYLE_BackgroundWhite,
          elevation: 0.0,
          title: Row(
            children: [
              CustomBackButton(isPrimaryMode:false),
            ],
          ),
          actions: [
            Visibility(
              visible: !profileController.isUserDataFetching.value,
              child: InkWell(
                onTap: (){
                  if(!profileController.isUserDataFetching.value &&
                  profileController.userData.value.id  != -1){
                    sharedController.changeMobile(profileController.userData.value.mobile);
                    sharedController.sendOtp(true, false);
                    //  Get.toNamed(AppRouteNames.resetPasswordNewpasswordRoute,arguments: [profileController.userData.value.mobile]);
                  }
                },
                child: Container(
                  width: screenwidth*.4,
                  decoration: APPSTYLE_ShadowedContainerExtraSmallDecoration.
                  copyWith(
                    boxShadow: [
                      const BoxShadow(
                        color: APPSTYLE_Grey80Shadow24,
                        offset: Offset(0, 3.0),
                        blurRadius: APPSTYLE_BlurRadiusLarge,
                      ),
                    ],
                    color: APPSTYLE_Black
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: APPSTYLE_SpaceSmall,horizontal: APPSTYLE_SpaceSmall
                  ),
                  child: Row(
                    children: [
                      Icon(Ionicons.key,color: APPSTYLE_BackgroundWhite,
                          size: APPSTYLE_FontSize16),
                      addHorizontalSpace(APPSTYLE_SpaceExtraSmall),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "reset_password".tr,
                            style: getBodyMediumStyle(context)
                                .copyWith(
                                color:
                                APPSTYLE_BackgroundWhite),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            addHorizontalSpace(APPSTYLE_SpaceLarge)
          ],
        ) ,
        body: SafeArea(
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Form(
                      key: editProfileFormKey,
                      child: ListView(
                        children: [
                          addVerticalSpace(APPSTYLE_SpaceLarge),
                          Row(

                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Visibility(
                                visible: !profileController.isUserDataFetching.value,

                                child: UpdateProfilePic(
                                  onClick: () {
                                    if(!profileController.isUserDataFetching.value &&
                                        profileController.userData.value.id  != -1){
                                      openSourceSelector(context);
                                    }
                                   },
                                  borderColor: APPSTYLE_PrimaryColorBg,
                                  profilePictureUrl: profileController.profilePictureUrl.value,
                                ),
                              ),
                              Visibility(
                                visible: profileController.isUserDataFetching.value,
                                child: Shimmer.fromColors(
                                  baseColor: APPSTYLE_Grey20,
                                  highlightColor: APPSTYLE_Grey40,
                                  child: Container(
                                    height: screenwidth * .3,
                                    width: screenwidth * .3,

                                    decoration:
                                    APPSTYLE_BorderedContainerExtraSmallDecoration
                                        .copyWith(
                                        borderRadius: BorderRadius.circular(1000),
                                        border: Border.all(color: APPSTYLE_BackgroundWhite, width: 1),
                                        color: APPSTYLE_Grey20
                                    ),),
                                ),),
                            ],

                          ),
                          addVerticalSpace(APPSTYLE_SpaceSmall),

                          Visibility(
                            visible: !profileController.isUserDataFetching.value,
                            child: InkWell(
                              onTap: (){
                                if(!profileController.isUserDataFetching.value &&
                                    profileController.userData.value.id  != -1){
                                  openSourceSelector(context);
                                }
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
                          ),
                          addVerticalSpace(APPSTYLE_SpaceLarge),
                          Visibility(
                            visible: profileController.isUserDataFetching.value,
                            child: Padding(
                              padding: APPSTYLE_LargePaddingHorizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child:  Shimmer.fromColors(
                                      baseColor: APPSTYLE_Grey20,
                                      highlightColor: APPSTYLE_Grey40,
                                      child: Container(
                                        height: screenhight  * 0.07,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(40),
                                          color:profileController.gender.value==VALID_GENDERS.female.name?
                                          APPSTYLE_Black:APPSTYLE_Grey20,),

                                      ),
                                    ),
                                  ),
                                  addHorizontalSpace(APPSTYLE_SpaceMedium),
                                  Expanded(
                                    child:  Shimmer.fromColors(
                                    baseColor: APPSTYLE_Grey20,
                                    highlightColor: APPSTYLE_Grey40,
                                    child: Container(
                                      height: screenhight  * 0.07,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color:profileController.gender.value==VALID_GENDERS.female.name?
                                        APPSTYLE_Black:APPSTYLE_Grey20,),

                                    ),
                                  ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !profileController.isUserDataFetching.value,
                            child: Padding(
                              padding: APPSTYLE_LargePaddingHorizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        profileController.changeGender(VALID_GENDERS.male.name);
                                      },
                                      child: Container(
                                        height: screenhight * 0.07,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(40),
                                          color:profileController.gender.value==VALID_GENDERS.male.name?
                                          APPSTYLE_Black:APPSTYLE_Grey20,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(ASSETS_MALE,
                                              height: screenhight * 0.05,
                                              color:profileController.gender.value==VALID_GENDERS.male.name?
                                              APPSTYLE_BackgroundWhite:APPSTYLE_Black ,
                                            ),
                                            addHorizontalSpace(APPSTYLE_SpaceSmall),
                                            Text(
                                              "Male",
                                              style: getBodyMediumStyle(context).copyWith(
                                                  color:profileController.gender.value==VALID_GENDERS.male.name?
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
                                        profileController.changeGender(VALID_GENDERS.female.name);
                                      },
                                      child: Container(
                                        height: screenhight  * 0.07,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(40),
                                          color:profileController.gender.value==VALID_GENDERS.female.name?
                                          APPSTYLE_Black:APPSTYLE_Grey20,),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              ASSETS_FEMALE,
                                              height: screenhight * 0.05,
                                              color:profileController.gender.value==VALID_GENDERS.female.name?
                                              APPSTYLE_BackgroundWhite:APPSTYLE_Black ,
                                            ),
                                            addHorizontalSpace(APPSTYLE_SpaceSmall),
                                            Text(
                                              "Female",
                                              style: getBodyMediumStyle(context).copyWith(
                                                  color:profileController.gender.value==VALID_GENDERS.female.name?
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
                            ),
                          ),
                          Container(
                            decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                            padding: APPSTYLE_MediumPaddingAll,
                            margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex:1,
                                    child: Text('first_name_en'.tr,
                                        style: getBodyMediumStyle(context)
                                            .copyWith(color: APPSTYLE_Grey40))),
                                Visibility(
                                  visible: profileController.isUserDataFetching.value,
                                  child: Expanded(
                                    flex:2,
                                    child: Shimmer.fromColors(
                                      baseColor: APPSTYLE_Grey20,
                                      highlightColor: APPSTYLE_Grey40,
                                      child: Container(
                                        height: 30,
                                        decoration:
                                        APPSTYLE_BorderedContainerExtraSmallDecoration
                                            .copyWith(
                                          border: null,
                                          color: APPSTYLE_Grey20,
                                          borderRadius: BorderRadius.circular(
                                              APPSTYLE_BlurRadiusSmall),
                                        ),),
                                    ),
                                  ),),
                                Visibility(
                                  visible: !profileController.isUserDataFetching.value,
                                  child: Expanded(
                                      flex:2,
                                      child:  TextFormField(
                                        controller: profileController.firstNameEnglishTextEditingController.value,
                                        validator: (email) => checkIfNameFormValid(email,'first_name_en'),
                                        decoration: bottomBorderInputDecoration.copyWith(
                                          hintText: 'first_name_en_hint_short'.tr,

                                          isDense: true,
                                        )

                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                            padding: APPSTYLE_MediumPaddingAll,
                            margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex:1,

                                    child: Text('last_name_en'.tr,
                                        style: getBodyMediumStyle(context)
                                            .copyWith(color: APPSTYLE_Grey40))),
                                Visibility(
                                  visible: profileController.isUserDataFetching.value,
                                  child: Expanded(
                                    flex:2,
                                    child: Shimmer.fromColors(
                                      baseColor: APPSTYLE_Grey20,
                                      highlightColor: APPSTYLE_Grey40,
                                      child: Container(
                                        height: 30,
                                        decoration:
                                        APPSTYLE_BorderedContainerExtraSmallDecoration
                                            .copyWith(
                                          border: null,
                                          color: APPSTYLE_Grey20,
                                          borderRadius: BorderRadius.circular(
                                              APPSTYLE_BlurRadiusSmall),
                                        ),),
                                    ),
                                  ),),
                                Visibility(
                                  visible: !profileController.isUserDataFetching.value,
                                  child: Expanded(
                                      flex:2,
                                      child:  TextFormField(
                                          controller: profileController.lastNameEnglishTextEditingController.value,
                                          validator: (email) => checkIfNameFormValid(email,'last_name_en'),
                                          decoration: bottomBorderInputDecoration.copyWith(
                                            hintText: 'last_name_en_hint_short'.tr,

                                            isDense: true,
                                          )

                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                            padding: APPSTYLE_MediumPaddingAll,
                            margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex:1,

                                    child: Text('first_name_ar'.tr,
                                        style: getBodyMediumStyle(context)
                                            .copyWith(color: APPSTYLE_Grey40))),
                                Visibility(
                                  visible: profileController.isUserDataFetching.value,
                                  child: Expanded(
                                    flex:2,
                                    child: Shimmer.fromColors(
                                      baseColor: APPSTYLE_Grey20,
                                      highlightColor: APPSTYLE_Grey40,
                                      child: Container(
                                        height: 30,
                                        decoration:
                                        APPSTYLE_BorderedContainerExtraSmallDecoration
                                            .copyWith(
                                          border: null,
                                          color: APPSTYLE_Grey20,
                                          borderRadius: BorderRadius.circular(
                                              APPSTYLE_BlurRadiusSmall),
                                        ),),
                                    ),
                                  ),),
                                Visibility(
                                  visible: !profileController.isUserDataFetching.value,
                                  child: Expanded(
                                      flex:2,
                                      child:  TextFormField(
                                          controller: profileController.firstNameArabicTextEditingController.value,
                                          validator: (email) => checkIfArabicNameValid(email,'first_name_ar',true),
                                          decoration: bottomBorderInputDecoration.copyWith(
                                            hintText: 'first_name_ar_hint_short'.tr,

                                            isDense: true,
                                          )

                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                            padding: APPSTYLE_MediumPaddingAll,
                            margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex:1,
                                    child: Text('last_name_ar'.tr,
                                        style: getBodyMediumStyle(context)
                                            .copyWith(color: APPSTYLE_Grey40))),
                                Visibility(
                                  visible: profileController.isUserDataFetching.value,
                                  child: Expanded(
                                    flex:2,
                                    child: Shimmer.fromColors(
                                      baseColor: APPSTYLE_Grey20,
                                      highlightColor: APPSTYLE_Grey40,
                                      child: Container(
                                        height: 30,
                                        decoration:
                                        APPSTYLE_BorderedContainerExtraSmallDecoration
                                            .copyWith(
                                          border: null,
                                          color: APPSTYLE_Grey20,
                                          borderRadius: BorderRadius.circular(
                                              APPSTYLE_BlurRadiusSmall),
                                        ),),
                                    ),
                                  ),),
                                Visibility(
                                  visible: !profileController.isUserDataFetching.value,
                                  child: Expanded(
                                      flex:2,
                                      child:  TextFormField(
                                          controller: profileController.lastNameArabicTextEditingController.value,
                                          validator: (email) => checkIfArabicNameValid(email,'last_name_ar',true),
                                          decoration: bottomBorderInputDecoration.copyWith(
                                            hintText: 'last_name_ar_hint_short'.tr,

                                            isDense: true,
                                          )

                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                            padding: APPSTYLE_MediumPaddingAll,
                            margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex:1,
                                    child: Text('birthday'.tr,
                                        style: getBodyMediumStyle(context)
                                            .copyWith(color: APPSTYLE_Grey40))),
                                Visibility(
                                  visible: profileController.isUserDataFetching.value,
                                  child: Expanded(
                                    flex:2,
                                    child: Shimmer.fromColors(
                                      baseColor: APPSTYLE_Grey20,
                                      highlightColor: APPSTYLE_Grey40,
                                      child: Container(
                                        height: 30,
                                        decoration:
                                        APPSTYLE_BorderedContainerExtraSmallDecoration
                                            .copyWith(
                                          border: null,
                                          color: APPSTYLE_Grey20,
                                          borderRadius: BorderRadius.circular(
                                              APPSTYLE_BlurRadiusSmall),
                                        ),),
                                    ),
                                  ),),
                                Visibility(
                                  visible: !profileController.isUserDataFetching.value,
                                  child: Expanded(
                                      flex:2,
                                      child:  TextFormField(
                                          onTap: () {
                                            showDOBPickerDialog();
                                          },
                                          showCursor: true,
                                          readOnly: true,
                                          controller: profileController.birthDayController.value,
                                          decoration: bottomBorderInputDecoration.copyWith(
                                            hintText:'${'day'.tr} / ${'month'.tr} / ${'year'.tr}',
                                            isDense: true,
                                          )

                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                            padding: APPSTYLE_MediumPaddingAll,
                            margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex:1,
                                    child: Text('email'.tr,
                                        style: getBodyMediumStyle(context)
                                            .copyWith(color: APPSTYLE_Grey40))),
                                Visibility(
                                  visible: profileController.isUserDataFetching.value,
                                  child: Expanded(
                                    flex:2,
                                    child: Shimmer.fromColors(
                                      baseColor: APPSTYLE_Grey20,
                                      highlightColor: APPSTYLE_Grey40,
                                      child: Container(
                                        height: 30,
                                        decoration:
                                        APPSTYLE_BorderedContainerExtraSmallDecoration
                                            .copyWith(
                                          border: null,
                                          color: APPSTYLE_Grey20,
                                          borderRadius: BorderRadius.circular(
                                              APPSTYLE_BlurRadiusSmall),
                                        ),),
                                    ),
                                  ),),
                                Visibility(
                                  visible: !profileController.isUserDataFetching.value,
                                  child: Expanded(
                                      flex:2,
                                      child:  TextFormField(
                                          controller: profileController.emailTextEditingController.value,
                                          validator: (email) => checkIfEmailFormValid(email ),
                                          decoration: bottomBorderInputDecoration.copyWith(
                                            hintText: 'enter_email'.tr,

                                            isDense: true,
                                          )

                                      )),
                                ),
                              ],
                            ),
                          ),

                          addVerticalSpace(APPSTYLE_SpaceLarge)
                        ],
                      ),
                    ),
                  ),

                  Visibility(
                    visible: !profileController.isUserDataFetching.value,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: APPSTYLE_SpaceLarge,vertical: APPSTYLE_SpaceSmall),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (editProfileFormKey.currentState!.validate() &&
                            !profileController.isProfileUpdating.value) {
                              profileController.updateProfile();
                            }
                          },
                          style: getElevatedButtonStyle(context),
                          child:profileController.isProfileUpdating.value
                              ? LoadingAnimationWidget.staggeredDotsWave(
                            color: APPSTYLE_BackgroundWhite,
                            size: 24,
                          ):  Text(
                              "update".tr,
                              style: getHeadlineMediumStyle(context).copyWith(
                                  color: APPSTYLE_BackgroundWhite,
                                  fontWeight: APPSTYLE_FontWeightBold),
                              textAlign: TextAlign.center
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void showLogoutConfirmDialogue(BuildContext context ) async {

    final dialogTitleWidget = Text('confirm_logout'.tr,style: getHeadlineMediumStyle(context).copyWith(
        color: APPSTYLE_Grey80,fontWeight: APPSTYLE_FontWeightBold));
    final dialogTextWidget = Text(  'confirm_logout_message'.tr,style: getBodyMediumStyle(context),
    );

    final updateButtonTextWidget = Text('yes'.tr,style: TextStyle(color: APPSTYLE_PrimaryColor),);
    final updateButtonCancelTextWidget = Text('no'.tr,style: TextStyle(color: APPSTYLE_Black),);

    updateLogoutAction() {
      // Get.offAllNamed(Approute_LoginPage_Auth);
    }
    updateAction() {
      Navigator.pop(context);

    }
    List<Widget> actions = [

      TextButton(
          onPressed:updateAction,
          style: APPSTYLE_TextButtonStylePrimary.copyWith(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                  horizontal: APPSTYLE_SpaceLarge,
                  vertical: APPSTYLE_SpaceSmall))),
          child:  updateButtonCancelTextWidget),

      TextButton(
          onPressed:updateLogoutAction,
          style: APPSTYLE_TextButtonStylePrimary.copyWith(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                  horizontal: APPSTYLE_SpaceLarge,
                  vertical: APPSTYLE_SpaceSmall))),
          child:  updateButtonTextWidget),
    ];

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            child: AlertDialog(
              title: dialogTitleWidget,
              content: dialogTextWidget,
              actions: actions,
            ),
            onWillPop: () => Future.value(false));
      },
    );
  }

  void openSourceSelector(context) {
    showDialog(
      context: context,
      builder: (_) => PhotoSelector(
        photoSelected: (File? pictureFile) {
          if (pictureFile != null) {
            Uint8List imageBytes = pictureFile.readAsBytesSync();
            profileController.updateProfilePicture(base64Encode(imageBytes));
          }
          setState(() {});
        },
      ),
    ).then((valueFromDialog) {
      // use the value as you wish
    });
  }

  showDOBPickerDialog() async {
    showDialog(
      context: context,
      builder: (_) => DOBPicker(
          dob: profileController.selectedDOB.value,
          dobPicked: (DateTime selectedDob) {
            profileController.changeDob(selectedDob);
          }),
    );
  }

}
