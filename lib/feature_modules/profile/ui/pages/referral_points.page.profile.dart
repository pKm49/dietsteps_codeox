

 import 'package:dietsteps/feature_modules/profile/controllers/profile.controller.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/update_profile_pic.profile.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

class ReferralPointsPage_Profile extends StatefulWidget {
  const ReferralPointsPage_Profile({super.key});

  @override
  State<ReferralPointsPage_Profile> createState() => _ReferralPointsPage_ProfileState();
}

class _ReferralPointsPage_ProfileState extends State<ReferralPointsPage_Profile> {

  final profileController = Get.find<ProfileController>();
  final sharedController = Get.find<SharedController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.getRefferalData();
  }

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation:0.0,
        backgroundColor: APPSTYLE_BackgroundWhite,
        elevation: 0.0,
        title: Row(
          children: [
            CustomBackButton(isPrimaryMode:false),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'referral_points'.tr,
                  style: getHeadlineLargeStyle(context).copyWith(
                      fontWeight: APPSTYLE_FontWeightBold),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ) ,
      body: SafeArea(
          child: Obx(
            ()=> Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: screenwidth,
                    padding: APPSTYLE_MediumPaddingAll,
                    margin: APPSTYLE_LargePaddingAll,
                    height: 300,
                    decoration: APPSTYLE_BorderedContainerSmallDecoration.copyWith(color: APPSTYLE_Grey20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Visibility(
                              visible: !sharedController.isUserDataFetching.value,

                              child: UpdateProfilePic(
                                onClick: () {
                                  Get.toNamed(AppRouteNames.updateProfileRoute);
                                },
                                borderColor: APPSTYLE_PrimaryColorBg,
                                profilePictureUrl: sharedController.userData.value.profilePictureUrl,
                              ),
                            ),
                            Visibility(
                              visible: sharedController.isUserDataFetching.value,
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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: sharedController.isUserDataFetching.value,
                              child: Shimmer.fromColors(
                                baseColor: APPSTYLE_Grey20,
                                highlightColor: APPSTYLE_Grey40,
                                child: Container(
                                  height: 30,
                                  width: screenwidth * .5,
                                  decoration:
                                  APPSTYLE_BorderedContainerExtraSmallDecoration
                                      .copyWith(
                                    border: null,
                                    color: APPSTYLE_Grey20,
                                    borderRadius: BorderRadius.circular(
                                        APPSTYLE_BlurRadiusSmall),
                                  ),),
                              ),),
                            Visibility(
                                visible: !sharedController.isUserDataFetching.value,
                                child: Text(
                                  (Localizations.localeOf(context)
                                      .languageCode
                                      .toString() ==
                                      'ar')? "${sharedController.userData.value.firstNameArabic} ${sharedController.userData.value.lastNameArabic}"
                                      :"${sharedController.userData.value.firstName} ${sharedController.userData.value.lastName}",
                                  style: getHeadlineLargeStyle(context)
                                      .copyWith(color: APPSTYLE_Grey80),
                                )),

                          ],
                        ),
                        addVerticalSpace(APPSTYLE_SpaceExtraSmall),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Visibility(
                              visible:  sharedController.isUserDataFetching.value,
                              child: Shimmer.fromColors(
                                baseColor: APPSTYLE_Grey20,
                                highlightColor: APPSTYLE_Grey40,
                                child: Container(
                                  height: 25,
                                  width: screenwidth * .25,
                                  decoration:
                                  APPSTYLE_BorderedContainerExtraSmallDecoration
                                      .copyWith(
                                    border: null,
                                    color: APPSTYLE_Grey20,
                                    borderRadius: BorderRadius.circular(
                                        APPSTYLE_BorderRadiusLarge),
                                  ),),
                              ),),
                            Visibility(
                              visible:  !sharedController.isUserDataFetching.value,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusLarge),
                                    color: APPSTYLE_PrimaryColorBg
                                ),
                                padding: APPSTYLE_ExtraSmallPaddingAll.copyWith(left: APPSTYLE_SpaceMedium,right: APPSTYLE_SpaceMedium),
                                child: Text(
                                  sharedController.userData.value.customerCode,
                                  style: getLabelSmallStyle(context)
                                      .copyWith(color: APPSTYLE_BackgroundWhite),
                                ),
                              ),
                            ),
                          ],
                        ),
                        addVerticalSpace(APPSTYLE_SpaceLarge),
                        Text(
                          'earnings'.tr,
                          textAlign: TextAlign.center,
                          style: getBodyMediumStyle(context).copyWith(color: APPSTYLE_Grey80),
                        ),
                        addVerticalSpace(APPSTYLE_SpaceSmall),
                        Visibility(
                          visible:  profileController.isRefferalDataFetching.value,
                          child: Shimmer.fromColors(
                            baseColor: APPSTYLE_Grey20,
                            highlightColor: APPSTYLE_Grey40,
                            child: Container(
                              height: 25,
                              width: screenwidth * .25,
                              decoration:
                              APPSTYLE_BorderedContainerExtraSmallDecoration
                                  .copyWith(
                                border: null,
                                color: APPSTYLE_Grey20,
                                borderRadius: BorderRadius.circular(
                                    APPSTYLE_BorderRadiusLarge),
                              ),),
                          ),),
                        Visibility(
                          visible: !profileController.isRefferalDataFetching.value,
                          child: Text(
                            profileController.referralData.value.refferalEarnings,
                            textAlign: TextAlign.center,
                            style: getHeadlineLargeStyle(context).copyWith(color: APPSTYLE_Grey80),
                          ),
                        ),
                      ],
                    ),
                  ),
                  addVerticalSpace(APPSTYLE_SpaceLarge),

                  Padding(padding: APPSTYLE_LargePaddingHorizontal,child:  Text(
                    'referral_code'.tr,
                    textAlign: TextAlign.start,
                    style: getBodyMediumStyle(context).copyWith(color: APPSTYLE_Grey80),
                  ),),
                  Container(
                    decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                    padding: APPSTYLE_MediumPaddingAll,
                    margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible:  profileController.isRefferalDataFetching.value,
                          child: Shimmer.fromColors(
                            baseColor: APPSTYLE_Grey20,
                            highlightColor: APPSTYLE_Grey40,
                            child: Container(
                              height: 25,
                              width: screenwidth * .25,
                              decoration:
                              APPSTYLE_BorderedContainerExtraSmallDecoration
                                  .copyWith(
                                border: null,
                                color: APPSTYLE_Grey20,
                                borderRadius: BorderRadius.circular(
                                    APPSTYLE_BorderRadiusLarge),
                              ),),
                          ),),
                        Visibility(
                          visible: !profileController.isRefferalDataFetching.value,
                          child: Text(
                            profileController.referralData.value.refferalCode,
                            textAlign: TextAlign.center,
                            style: getBodyMediumStyle(context).copyWith(
                                color: APPSTYLE_Grey80, fontWeight: APPSTYLE_FontWeightBold),
                          ),
                        ),

                      ],
                    ),
                  ),
                  addVerticalSpace(APPSTYLE_SpaceMedium),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenwidth*.3,
                        child: ElevatedButton(
                          onPressed: () {
                            if(!profileController.isRefferalDataFetching.value){
                              Share.share(
                                  profileController.referralData.value.refferalCode,
                                  subject: 'Diet Done');
                            }


                          },
                          style: getElevatedButtonStyle(context).copyWith(
                            padding:  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(
                                    horizontal: APPSTYLE_SpaceLarge,
                                    vertical:APPSTYLE_SpaceSmall))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.share,color: APPSTYLE_BackgroundWhite,size: APPSTYLE_FontSize20),
                              addHorizontalSpace(APPSTYLE_SpaceSmall),
                              Expanded(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "share".tr ,
                                    style: getBodyMediumStyle(context).copyWith(color: APPSTYLE_BackgroundWhite,fontWeight: APPSTYLE_FontWeightBold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
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
}
