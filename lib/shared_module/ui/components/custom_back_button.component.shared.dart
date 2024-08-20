import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CustomBackButton extends StatelessWidget {
  bool? isPrimaryMode;

  CustomBackButton({super.key, this.isPrimaryMode});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Container(
          height: 35,
          width: 35,
          padding: APPSTYLE_ExtraSmallPaddingAll,
          decoration: APPSTYLE_BorderedContainerSmallDecoration.copyWith(
              borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
              border:   Border.all(color:APPSTYLE_Black, width: .5),
              color: isPrimaryMode== true?APPSTYLE_PrimaryColor :APPSTYLE_BackgroundWhite),
          child: Icon(
              Localizations.localeOf(context)
                  .languageCode
                  .toString() ==
                  'en'
                  ? Ionicons.chevron_back
                  :Ionicons.chevron_forward,
              size: APPSTYLE_FontSize24,
              color: isPrimaryMode == true?APPSTYLE_BackgroundWhite:Colors.black)),
    );
  }
}
