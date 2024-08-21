

 import 'package:dietsteps/feature_modules/profile/controllers/profile.controller.dart';
import 'package:dietsteps/feature_modules/profile/ui/components/preposticon_button.component.shared.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/confirm_dialogue.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
 import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class AboutPage_Profile extends StatefulWidget {
  const AboutPage_Profile({super.key});

  @override
  State<AboutPage_Profile> createState() => _AboutPage_ProfileState();
}

class _AboutPage_ProfileState extends State<AboutPage_Profile> {

  bool isAccountDeleteVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAccountDeleteVisibility();

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

          ],
        ),
      ) ,
      body: SafeArea(
          child: Container(
            child: ListView(
              children: [
                addVerticalSpace(APPSTYLE_SpaceLarge ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ASSETS_NAMELOGO_PRIMARY,width: screenwidth*.4)
                  ],
                ),
                addVerticalSpace(APPSTYLE_SpaceLarge*2 ),
                Padding(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  child: Text("diet_steps_caption".tr,style: getHeadlineMediumStyle(context).copyWith(color: APPSTYLE_Grey60,fontWeight: APPSTYLE_FontWeightBold)),
                ),
                addVerticalSpace(APPSTYLE_SpaceMedium),
                Padding(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  child: Text("diet_steps_description".tr,style: getBodyMediumStyle(context).copyWith(color: APPSTYLE_Grey40 )),
                ),

                addVerticalSpace(APPSTYLE_SpaceLarge ),
                Padding(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  child: Text("what_we_offer".tr,style: getHeadlineMediumStyle(context)
                      .copyWith(color: APPSTYLE_Grey60,fontWeight: APPSTYLE_FontWeightBold)),
                ),
                addVerticalSpace(APPSTYLE_SpaceMedium),
                Padding(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  child:Row(
                    children: [
                      Expanded(
                        child: Container(

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(ASSETS_OFFERPLAN),
                              addVerticalSpace(APPSTYLE_SpaceSmall),
                              Text("tailored_plan".tr,
                                  textAlign: TextAlign.center,
                                  style: getLabelLargeStyle(context),maxLines: 2)
                            ],
                          ),
                        ),
                      ),
                      addHorizontalSpace(APPSTYLE_SpaceSmall),
                      Expanded(
                        child: Container(

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(ASSETS_OFFERTRACKING),
                              addVerticalSpace(APPSTYLE_SpaceSmall),
                              Text("smart_tracking".tr,
                                  textAlign: TextAlign.center,
                                  style: getLabelLargeStyle(context),maxLines: 2)
                            ],
                          ),
                        ),
                      ),
                      addHorizontalSpace(APPSTYLE_SpaceSmall),
                      Expanded(
                        child: Container(

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(ASSETS_OFFERMEAL),
                              addVerticalSpace(APPSTYLE_SpaceSmall),
                              Text("healthy_meal".tr,
                                  textAlign: TextAlign.center,
                                  style: getLabelLargeStyle(context),maxLines: 2)
                            ],
                          ),
                        ),
                      ),
                      addHorizontalSpace(APPSTYLE_SpaceSmall),
                      Expanded(
                        child: Container(

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(ASSETS_OFFERGUIDANCE),
                              addVerticalSpace(APPSTYLE_SpaceSmall),
                              Text("expert_guidance".tr,
                                  textAlign: TextAlign.center,
                                  style: getLabelLargeStyle(context),maxLines: 2)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                addVerticalSpace(APPSTYLE_SpaceLarge ),

                Padding(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  child: Text("our_mission".tr,style: getHeadlineMediumStyle(context)
                      .copyWith(color: APPSTYLE_Grey60,fontWeight: APPSTYLE_FontWeightBold)),
                ),
                addVerticalSpace(APPSTYLE_SpaceMedium),
                Padding(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  child: Text("diet_mission".tr,style: getBodyMediumStyle(context).copyWith(color: APPSTYLE_Grey40 )),
                ),
                addVerticalSpace(APPSTYLE_SpaceLarge ),
                Padding(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  child: Text("contact_us".tr,style: getHeadlineMediumStyle(context)
                      .copyWith(color: APPSTYLE_Grey60,fontWeight: APPSTYLE_FontWeightBold)),
                ),
                addVerticalSpace(APPSTYLE_SpaceMedium),
                Padding(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  child:Row(
                    children: [
                      InkWell(
                      onTap: (){
                        handleRequestSupportClick(context,false);
                      },
                        child: Container(
                          decoration: APPSTYLE_BorderedContainerLargeDecoration.copyWith(
                            color: APPSTYLE_Black
                          ),
                          padding: APPSTYLE_SmallPaddingAll,
                          child: Icon(Ionicons.call,color: APPSTYLE_BackgroundWhite,),
                        ),
                      ),
                      // addHorizontalSpace(APPSTYLE_SpaceSmall),
                      // InkWell(
                      //   onTap: (){
                      //     handleRequestSupportClick(context,false);
                      //   },
                      //   child: Container(
                      //     decoration: APPSTYLE_BorderedContainerLargeDecoration.copyWith(
                      //         color: APPSTYLE_PrimaryColor
                      //     ),
                      //     padding: APPSTYLE_SmallPaddingAll,
                      //     child: Icon(Ionicons.mail,color: APPSTYLE_BackgroundWhite,),
                      //   ),
                      // ),
                      addHorizontalSpace(APPSTYLE_SpaceSmall),
                      InkWell(
                        onTap: (){
                          handleRequestSupportClick(context,true);

                        },
                        child: Container(
                          decoration: APPSTYLE_BorderedContainerLargeDecoration.copyWith(
                              color: APPSTYLE_WhatsappGreen
                          ),
                          padding: APPSTYLE_SmallPaddingAll,
                          child: Icon(Ionicons.logo_whatsapp,color: APPSTYLE_BackgroundWhite,),
                        ),
                      )
                    ],
                  ),
                ),
                addVerticalSpace(APPSTYLE_SpaceSmall ),

                Container(
                  decoration: APPSTYLE_BorderedContainerSmallDecoration.copyWith(color: APPSTYLE_Grey20),
                  padding: APPSTYLE_MediumPaddingAll,
                  margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                  child:  PrePostIconButton(
                    isRemoveVerticalPadding:true,
                    specialColor: 0,
                    onPressed: () {
                      Get.toNamed(AppRouteNames.termsRoute);
                    },
                    theme: 'dark',
                    border: '',
                    buttonTitle: "terms_n_conditions".tr,
                    preIconData: Icons.playlist_add_check_rounded,
                    postIconData:Localizations.localeOf(context)
                        .languageCode
                        .toString() ==
                        'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                  ),
                ),
                Container(
                  decoration: APPSTYLE_BorderedContainerSmallDecoration.copyWith(color: APPSTYLE_Grey20),
                  padding: APPSTYLE_MediumPaddingAll,
                  margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                  child:  PrePostIconButton(
                    isRemoveVerticalPadding:true,
                    specialColor: 0,
                    onPressed: () {
                       Get.toNamed(AppRouteNames.privacyRoute);
                    },
                    theme: 'dark',
                    border: '',
                    buttonTitle: "privacy_policies".tr,
                    preIconData: Ionicons.lock_closed_outline,
                    postIconData:Localizations.localeOf(context)
                        .languageCode
                        .toString() ==
                        'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                  ),
                ),
                addVerticalSpace(APPSTYLE_SpaceLarge ),
                addVerticalSpace(APPSTYLE_SpaceLarge *6),
                Visibility(
                  visible: isAccountDeleteVisible,
                  child: Container(
                    decoration: APPSTYLE_BorderedContainerSmallDecoration.copyWith(color: APPSTYLE_Grey20),
                    padding: APPSTYLE_MediumPaddingHorizontal,
                    margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                    child: PrePostIconButton(
                      specialColor: 1,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => ConfirmDialogue(
                              onClick: () async {
                                Navigator.of(context).pop(true);
                              },
                              titleKey: 'confirm_logout'.tr + " ?",
                              subtitleKey: 'confirm_logout_message'.tr),
                        );
                      },
                      theme: 'dark',
                      border: '',
                      buttonTitle: "delete_account".tr,
                      preIconData: Ionicons.person_remove_outline,
                      postIconData:Localizations.localeOf(context)
                          .languageCode
                          .toString() ==
                          'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                    ),
                  ),
                ),
                addVerticalSpace(APPSTYLE_SpaceLarge ),

              ],
            ),
          )),
    );
  }

  Future<void> handleRequestSupportClick(
      BuildContext buildContext, bool isWhatsapp) async {
    final sharedController = Get.find<SharedController>();

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

  void showDeleteAccountConfirmDialogue(BuildContext context ) async {

    final dialogTitleWidget = Text('account_delete_title'.tr,style: getHeadlineMediumStyle(context).copyWith(
        color: APPSTYLE_Grey80,fontWeight: APPSTYLE_FontWeightBold));
    final dialogTextWidget = Text( 'account_delete_content'.tr,style: getBodyMediumStyle(context));

    final updateButtonTextWidget = Text('yes'.tr,style: TextStyle(color: APPSTYLE_PrimaryColor),);
    final updateButtonCancelTextWidget = Text('no'.tr,style: TextStyle(color: APPSTYLE_Black),);

    updateLogoutAction() async {
      final profileController = Get.find<ProfileController>();
      profileController.deleteAccount();
      Navigator.pop(context);
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

  Future<void> setAccountDeleteVisibility() async {
    await Future.delayed(Duration(seconds: 5));
    isAccountDeleteVisible = true;
    setState(() {

    });
  }
}
