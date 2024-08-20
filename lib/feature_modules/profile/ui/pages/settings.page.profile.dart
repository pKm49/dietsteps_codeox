

 import 'package:app_settings/app_settings.dart';
import 'package:dietsteps/feature_modules/profile/ui/components/preposticon_button.component.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class SettingsPage_Profile extends StatelessWidget {
    SettingsPage_Profile({super.key});
  final sharedController = Get.find<SharedController>();

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
                  'app_settings'.tr,
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
          child: Container(
            child: ListView(
              children: [
                addVerticalSpace(APPSTYLE_SpaceLarge ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        color: APPSTYLE_Grey20,
                      ),
                      width: screenwidth*.3,
                      height: screenwidth*.3,
                      child: Center(
                        child: Icon(Icons.settings_suggest_outlined,size: screenwidth*.15,
                            color: APPSTYLE_Grey80),
                      ),
                    )
                  ],
                ),
                addVerticalSpace(APPSTYLE_SpaceLarge ),
                Container(
                  decoration: APPSTYLE_BorderedContainerSmallDecoration.copyWith(color: APPSTYLE_Grey20),
                  padding: APPSTYLE_MediumPaddingAll,
                  margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                  child:  PrePostIconButton(
                    isRemoveVerticalPadding:true,
                    specialColor: 0,
                    onPressed: () {
                      try {
                        AppSettings.openAppSettings(type: AppSettingsType.notification);
                        // await platform.invokeMethod('openNotificationSettings');
                      } on Exception catch (e) {
                        print(e);
                      }
                    },
                    theme: 'dark',
                    border: '',
                    buttonTitle: "notifications".tr,
                    preIconData: Ionicons.notifications_outline,
                    postIconData:Localizations.localeOf(context)
                        .languageCode
                        .toString() ==
                        'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                  ),
                ),
                addVerticalSpace(APPSTYLE_SpaceLarge*2),
                Padding(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  child: Text("app_language".tr,style: getHeadlineMediumStyle(context)
                      .copyWith(color: APPSTYLE_Grey60,fontWeight: APPSTYLE_FontWeightBold)),
                ),
                addVerticalSpace(APPSTYLE_SpaceMedium),

                Container(
                  height: 40,
                  margin: APPSTYLE_LargePaddingHorizontal,

                  decoration: APPSTYLE_BorderedContainerDarkSmallDecoration,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                             sharedController.changeLanguage('en', false);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            decoration: APPSTYLE_BorderedContainerDarkSmallDecoration
                                .copyWith(
                                border: Border.all(
                                    color: Colors.transparent, width: .2),
                                color:  Localizations.localeOf(context)
                                    .languageCode
                                    .toString() ==
                                    'en'
                                    ? APPSTYLE_PrimaryColor
                                    : APPSTYLE_Grey20),
                            child: Text('View In English',style: getBodyMediumStyle(context).copyWith(
                                color:
                                Localizations.localeOf(context)
                                    .languageCode
                                    .toString() ==
                                    'en'?APPSTYLE_BackgroundWhite:APPSTYLE_Grey60,fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            sharedController.changeLanguage('ar', false);

                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            decoration: APPSTYLE_BorderedContainerDarkSmallDecoration
                                .copyWith(
                                border: Border.all(
                                    color: Colors.transparent, width: .2),
                                color:Localizations.localeOf(context)
                                    .languageCode
                                    .toString() ==
                                    'ar'?
                                APPSTYLE_PrimaryColor
                                    : APPSTYLE_Grey20),
                            child: Text('اللغه العربيه',
                                style: getBodyMediumStyle(context).copyWith(
                                    color:
                                    Localizations.localeOf(context)
                                        .languageCode
                                        .toString() ==
                                        'ar'? APPSTYLE_BackgroundWhite:APPSTYLE_Grey60,fontWeight: FontWeight.bold
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                addVerticalSpace(APPSTYLE_SpaceLarge ),

              ],
            ),
          )),
    );
  }
 
}
