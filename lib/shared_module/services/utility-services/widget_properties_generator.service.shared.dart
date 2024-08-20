
 import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextStyle getHeadlineLargeStyle(BuildContext context) {
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.headlineLarge!.copyWith(
      fontSize: Localizations.localeOf(context).languageCode.toString() == 'en'
          ? APPSTYLE_FontSize20
          : APPSTYLE_FontSize20,
      fontFamily:
          Localizations.localeOf(context).languageCode.toString() == 'en'
              ? APPSTYLE_DefaultFontFamilyEnglish
              : APPSTYLE_DefaultFontFamilyArabic);
}

TextStyle getHeadlineMediumStyle(BuildContext context) {
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.headlineMedium!.copyWith(
      fontSize: Localizations.localeOf(context).languageCode.toString() == 'en'
          ? APPSTYLE_FontSize16
          : APPSTYLE_FontSize16,
      fontFamily:
          Localizations.localeOf(context).languageCode.toString() == 'en'
              ? APPSTYLE_DefaultFontFamilyEnglish
              : APPSTYLE_DefaultFontFamilyArabic);
}

TextStyle getBodyMediumStyle(BuildContext context) {
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.bodyMedium!.copyWith(
      fontSize: Localizations.localeOf(context).languageCode.toString() == 'en'
          ? APPSTYLE_FontSize14
          : APPSTYLE_FontSize14,
      fontFamily:
          Localizations.localeOf(context).languageCode.toString() == 'en'
              ? APPSTYLE_DefaultFontFamilyEnglish
              : APPSTYLE_DefaultFontFamilyArabic);
}

TextStyle getLabelLargeStyle(BuildContext context) {
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.labelLarge!.copyWith(
      fontSize: Localizations.localeOf(context).languageCode.toString() == 'en'
          ? APPSTYLE_FontSize12
          : APPSTYLE_FontSize12,
      fontFamily:
          Localizations.localeOf(context).languageCode.toString() == 'en'
              ? APPSTYLE_DefaultFontFamilyEnglish
              : APPSTYLE_DefaultFontFamilyArabic);
}

TextStyle getLabelSmallStyle(BuildContext context) {
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.labelSmall!.copyWith(
      fontSize: Localizations.localeOf(context).languageCode.toString() == 'en'
          ? APPSTYLE_FontSize12
          : APPSTYLE_FontSize12,
      fontFamily:
          Localizations.localeOf(context).languageCode.toString() == 'en'
              ? APPSTYLE_DefaultFontFamilyEnglish
              : APPSTYLE_DefaultFontFamilyArabic);
}

TextStyle getElevatedButtonLabelStylePrimary(BuildContext context) {
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.labelLarge!.copyWith(
      color: APPSTYLE_PrimaryColor,
      fontSize: Localizations.localeOf(context).languageCode.toString() == 'en'
          ? APPSTYLE_FontSize12
          : APPSTYLE_FontSize12,
      fontFamily:
          Localizations.localeOf(context).languageCode.toString() == 'en'
              ? APPSTYLE_DefaultFontFamilyEnglish
              : APPSTYLE_DefaultFontFamilyArabic);
}

TextStyle getElevatedButtonLabelStyleLight(BuildContext context) {
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.labelLarge!.copyWith(
      color: APPSTYLE_Grey20,
      fontSize: Localizations.localeOf(context).languageCode.toString() == 'en'
          ? APPSTYLE_FontSize12
          : APPSTYLE_FontSize12,
      fontFamily:
          Localizations.localeOf(context).languageCode.toString() == 'en'
              ? APPSTYLE_DefaultFontFamilyEnglish
              : APPSTYLE_DefaultFontFamilyArabic);
}

ButtonStyle getElevatedButtonStyle(BuildContext context) {
  return ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
              horizontal: APPSTYLE_SpaceLarge,
              vertical:
                  Localizations.localeOf(context).languageCode.toString() ==
                          'en'
                      ? APPSTYLE_SpaceMedium * 1.2
                      : APPSTYLE_SpaceMedium * .9)));

}
