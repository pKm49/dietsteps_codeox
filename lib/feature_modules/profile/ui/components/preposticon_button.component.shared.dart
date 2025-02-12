 import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';

class PrePostIconButton extends StatelessWidget {
  final num? specialColor;
  final String? border;
  final String? theme;
  final IconData? preIconData;
  final IconData? postIconData;
  final bool? isRemoveVerticalPadding;
  final String buttonTitle;
  final GestureTapCallback onPressed;

  const PrePostIconButton(
      {super.key,
      required this.specialColor,
      required this.theme,
      required this.border,
      required this.preIconData,
        this.isRemoveVerticalPadding,
        required this.onPressed,
      required this.postIconData,
      required this.buttonTitle});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onPressed,
      child: Container(
          padding: isRemoveVerticalPadding==null? EdgeInsets.symmetric(vertical: APPSTYLE_SpaceSmall*1.5):null,
          decoration: BoxDecoration(
              border:border!=""? Border(
                  bottom:BorderSide(width: border!.contains('bottom')? .15 :0.0, color:
                  theme=='light'? APPSTYLE_Grey20: APPSTYLE_Grey40 )):null,
              color: Colors.transparent, ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(visible: preIconData != null, child: Padding(
                padding:   EdgeInsets.only(
                    left: (Localizations.localeOf(context)
                        .languageCode
                        .toString() ==
                        'ar'? APPSTYLE_SpaceMedium:0 ),
                    right:( Localizations.localeOf(context)
                        .languageCode
                        .toString() ==
                        'ar'?0: APPSTYLE_SpaceMedium) ),
                child: Icon(preIconData,color:
                specialColor ==1?APPSTYLE_GuideRed:
                specialColor ==2?APPSTYLE_PrimaryColor:
                theme=='light'? APPSTYLE_BackgroundOffWhite: APPSTYLE_PrimaryColor),
              )),
              Expanded(child: Text(buttonTitle,textAlign: TextAlign.start ,

                  style: getBodyMediumStyle(context).copyWith(color:
                  specialColor ==1?APPSTYLE_GuideRed:
                  specialColor ==2?APPSTYLE_PrimaryColor:
                  theme=='light'? APPSTYLE_BackgroundOffWhite: APPSTYLE_Black,fontWeight:theme=='light'? APPSTYLE_FontWeightLight : FontWeight.normal))),
              Visibility(visible: postIconData != null, child: Icon(postIconData,color:
              specialColor ==1?APPSTYLE_GuideRed:
              specialColor ==2?APPSTYLE_PrimaryColor:
              theme=='light'? APPSTYLE_Grey20: APPSTYLE_Grey60))
            ],
          )),
    );
  }
}
