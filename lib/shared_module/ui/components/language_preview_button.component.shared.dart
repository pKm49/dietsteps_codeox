import 'package:dietsteps/shared_module/constants/available_languages.shared.constant.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class LanguagePreviewButtonComponentShared extends StatelessWidget {

  Color textColor;

  LanguagePreviewButtonComponentShared({super.key, required this.textColor});

  final sharedController = Get.find<SharedController>();


  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (){
        Get.bottomSheet(
          Container(
            width: screenwidth,
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(APPSTYLE_BorderRadiusSmall),
                topRight: Radius.circular(APPSTYLE_BorderRadiusSmall),
              ),
            ),
            padding: APPSTYLE_LargePaddingAll,
            child:  Column(
              children: [
                Text("app_language".tr,style: getHeadlineLargeStyle(context)),
                addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                const Divider(),
                addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                Row(
                  children: [
                    Expanded(child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          sharedController.changeLanguage('ar', false);
                          Navigator.pop(context);
                        },
                        style: getElevatedButtonStyle(context).copyWith(
                            padding:  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                const EdgeInsets.symmetric(
                                    horizontal: APPSTYLE_SpaceLarge,
                                    vertical:APPSTYLE_SpaceSmall))
                        ),
                        child: Text("عربي",
                            style: getHeadlineMediumStyle(context).copyWith(
                                color: APPSTYLE_BackgroundWhite,
                                fontWeight: APPSTYLE_FontWeightBold),
                            textAlign: TextAlign.center),
                      ),
                    )),
                    addHorizontalSpace(APPSTYLE_SpaceMedium),
                    Expanded(child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(

                        onPressed: () {
                          sharedController.changeLanguage('en', false);
                          Navigator.pop(context);
                        },
                        style: getElevatedButtonStyle(context).copyWith(
                            padding:  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                const EdgeInsets.symmetric(
                                    horizontal: APPSTYLE_SpaceLarge,
                                    vertical:APPSTYLE_SpaceSmall))
                        ),
                        child: Text("English",
                            style: getHeadlineMediumStyle(context).copyWith(
                                color: APPSTYLE_PrimaryColor,
                                fontWeight: APPSTYLE_FontWeightBold),
                            textAlign: TextAlign.center),
                      ),
                    )),

                  ],
                )
              ],
            ),
          ),
        );
        
      //   AlertDialog(
        //           title: Text("app_language".tr),
        //           actions: [
        //             TextButton(
        //                 onPressed: () {
        //                   sharedController.changeLanguage('ar', false);
        //                   Get.back();
        //                 },
        //                 child: Text("عربي",style: getHeadlineMediumStyle(context).copyWith(color: APPSTYLE_PrimaryColor),)),
        //             TextButton(
        //                 onPressed: () {
        //                   sharedController.changeLanguage('en', false);
        //                   Get.back();
        //                 },
        //                 child: Text("English")),
        //           ],
        //         )
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: APPSTYLE_SpaceExtraSmall,
          horizontal: APPSTYLE_SpaceSmall
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Ionicons.globe_outline,color: textColor),
            addHorizontalSpace(APPSTYLE_SpaceSmall),
            Text(Localizations.localeOf(context)
                .languageCode
                .toString() ==
                'ar'?'ع':'Eng',style: getBodyMediumStyle(context).copyWith(
              color: textColor
            ),),
            // Expanded(
            //   flex: 1,
            //   child: InkWell(
            //     onTap: () {
            //        sharedController.changeLanguage('en', false);
            //     },
            //     child: Container(
            //       alignment: Alignment.center,
            //       decoration:
            //           APPSTYLE_BorderedContainerDarkSmallDecoration.copyWith(
            //               borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
            //
            //               border:
            //                   Border.all(color: Colors.transparent, width: .2),
            //               color: Localizations.localeOf(context)
            //                           .languageCode
            //                           .toString() ==
            //                       'en'
            //                   ? isPrimaryMode==true?APPSTYLE_PrimaryColor: APPSTYLE_Black
            //                   : APPSTYLE_BackgroundWhite),
            //       child: FittedBox(
            //         fit: BoxFit.scaleDown,
            //         child: Text(
            //           'En',
            //           style: TextStyle(
            //               color: Localizations.localeOf(context)
            //                           .languageCode
            //                           .toString() ==
            //                       'en'
            //                   ? APPSTYLE_BackgroundWhite
            //                   : APPSTYLE_Black,
            //               fontSize: APPSTYLE_FontSize12,
            //               fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Expanded(
            //   flex: 1,
            //   child: InkWell(
            //     onTap: () {
            //         sharedController.changeLanguage('ar', false);
            //     },
            //     child: Container(
            //       alignment: Alignment.center,
            //       decoration:
            //           APPSTYLE_BorderedContainerDarkSmallDecoration.copyWith(
            //               borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
            //
            //               border:
            //                   Border.all(color: Colors.transparent, width: .2),
            //               color: Localizations.localeOf(context)
            //                           .languageCode
            //                           .toString() ==
            //                       'ar'
            //                   ? isPrimaryMode==true?APPSTYLE_PrimaryColor: APPSTYLE_Black
            //                   : APPSTYLE_BackgroundWhite),
            //       child:  FittedBox(
            //         fit: BoxFit.scaleDown,
            //         child: Text('ع',
            //             style: TextStyle(
            //                 color: Localizations.localeOf(context)
            //                             .languageCode
            //                             .toString() ==
            //                         'ar'
            //                     ? APPSTYLE_BackgroundWhite
            //                     : APPSTYLE_Black,
            //
            //                 fontWeight: FontWeight.bold)),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
