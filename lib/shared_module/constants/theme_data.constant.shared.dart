  import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
 import 'package:flutter/material.dart';
 import 'dart:ui';


ThemeData getThemeData( String type, String locale) {
  return type == 'light'
      ? ThemeData(
    snackBarTheme:
    const SnackBarThemeData(backgroundColor: APPSTYLE_BackgroundOffWhite),
    brightness: Brightness.light,
    primaryColor: APPSTYLE_PrimaryColor,
    fontFamily: locale == 'en'
        ? APPSTYLE_DefaultFontFamilyEnglish
        : APPSTYLE_DefaultFontFamilyArabic,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: APPSTYLE_PrimaryColor),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: APPSTYLE_FontSize24,
          fontWeight: APPSTYLE_FontWeightBold,
          color: APPSTYLE_PrimaryColorDark),
      headlineMedium: TextStyle(
          fontSize: APPSTYLE_FontSize20,
          fontWeight: APPSTYLE_FontWeightMedium,
          color: APPSTYLE_Grey80),
      labelLarge: TextStyle(
          fontSize: APPSTYLE_FontSize14,
          fontWeight: APPSTYLE_FontWeightMedium,
          color: APPSTYLE_Grey60),
      labelSmall: TextStyle(
          fontSize: APPSTYLE_FontSize12,
          fontWeight: APPSTYLE_FontWeightLight,
          color: APPSTYLE_Grey60),
      bodyMedium: TextStyle(
          fontSize: APPSTYLE_FontSize16,
          height: 1.4,
          fontWeight: APPSTYLE_FontWeightRegular,
          color: APPSTYLE_Grey80),
      // labelSmall
      //  bodyMedium
    ),
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusLarge))),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            side: MaterialStateProperty.all<BorderSide>(
                const BorderSide(color: APPSTYLE_PrimaryColor, width: 2)),
            textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                fontWeight: APPSTYLE_FontWeightMedium, color: APPSTYLE_PrimaryColor)),
            foregroundColor:
            MaterialStateProperty.all<Color>(APPSTYLE_PrimaryColor),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(
                    horizontal: APPSTYLE_SpaceLarge, vertical: APPSTYLE_SpaceMedium)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall))))),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                fontWeight: APPSTYLE_FontWeightMedium, color: APPSTYLE_BackgroundWhite)),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(
                    horizontal: APPSTYLE_SpaceLarge, vertical: APPSTYLE_SpaceMedium)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall))),
            backgroundColor:
            MaterialStateProperty.all<Color>(APPSTYLE_PrimaryColor))),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                decoration: TextDecoration.underline,
                fontSize: APPSTYLE_FontSize12,
                fontWeight: APPSTYLE_FontWeightLight,
                decorationThickness: 2,
                color: APPSTYLE_Grey40,
                height: 1.3)),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.zero),
            minimumSize: MaterialStateProperty.all<Size>(Size.zero),
            foregroundColor: MaterialStateProperty.all<Color>(APPSTYLE_Grey60),
            backgroundColor:
            MaterialStateProperty.all<Color>(Colors.transparent))),
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: APPSTYLE_Grey20,
        contentPadding:
        const EdgeInsets.symmetric(vertical: APPSTYLE_SpaceMedium, horizontal: APPSTYLE_SpaceLarge ),
        labelStyle: TextStyle(color: APPSTYLE_Grey80),
        hintStyle: TextStyle(color: APPSTYLE_Grey60),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
            borderSide: BorderSide(width: .5,color: APPSTYLE_Grey20 )),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
            borderSide: BorderSide(width: .5, color: APPSTYLE_Grey40)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
            borderSide: const BorderSide(
                color:APPSTYLE_GuideRed, width: 1.0)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
            borderSide: const BorderSide(
                color: APPSTYLE_Grey40, width: 1.0)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
            borderSide: const BorderSide(
                color: APPSTYLE_GuideRed, width: 1.0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
            borderSide: const BorderSide(
                color: APPSTYLE_Grey40, width: .50)) ),
    scaffoldBackgroundColor: APPSTYLE_BackgroundWhite,
    appBarTheme: AppBarTheme(
        titleTextStyle:TextStyle(
          fontWeight: APPSTYLE_FontWeightBold,
          fontSize:locale=='en'?
          APPSTYLE_FontSize20:APPSTYLE_FontSize16,
          color: APPSTYLE_PrimaryColorDark,
          fontFamily: locale == 'en'
              ? APPSTYLE_DefaultFontFamilyEnglish
              : APPSTYLE_DefaultFontFamilyArabic,
        ),
        backgroundColor: APPSTYLE_BackgroundWhite,
        foregroundColor: APPSTYLE_Grey80,
        centerTitle: true,
        elevation: 2.0),
  )
      :  ThemeData(
    snackBarTheme:
    const SnackBarThemeData(backgroundColor: APPSTYLE_BackgroundOffWhite),
    brightness: Brightness.light,
    primaryColor: APPSTYLE_PrimaryColor,
    fontFamily: locale == 'en'
        ? APPSTYLE_DefaultFontFamilyEnglish
        : APPSTYLE_DefaultFontFamilyArabic,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: APPSTYLE_PrimaryColor),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: APPSTYLE_FontSize24,
          fontWeight: APPSTYLE_FontWeightBold,
          color: APPSTYLE_PrimaryColorDark),
      headlineMedium: TextStyle(
          fontSize: APPSTYLE_FontSize20,
          fontWeight: APPSTYLE_FontWeightMedium,
          color: APPSTYLE_Grey80),
      labelLarge: TextStyle(
          fontSize: APPSTYLE_FontSize14,
          fontWeight: APPSTYLE_FontWeightMedium,
          color: APPSTYLE_Grey60),
      labelSmall: TextStyle(
          fontSize: APPSTYLE_FontSize12,
          fontWeight: APPSTYLE_FontWeightLight,
          color: APPSTYLE_Grey60),
      bodyMedium: TextStyle(
          fontSize: APPSTYLE_FontSize16,
          height: 1.4,
          fontWeight: APPSTYLE_FontWeightRegular,
          color: APPSTYLE_Grey80),
      // labelSmall
      //  bodyMedium
    ),
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusLarge))),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            side: MaterialStateProperty.all<BorderSide>(
                const BorderSide(color: APPSTYLE_PrimaryColor, width: 2)),
            textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                fontWeight: APPSTYLE_FontWeightMedium, color: APPSTYLE_PrimaryColor)),
            foregroundColor:
            MaterialStateProperty.all<Color>(APPSTYLE_PrimaryColor),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(
                    horizontal: APPSTYLE_SpaceLarge, vertical: APPSTYLE_SpaceMedium)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall))))),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                fontWeight: APPSTYLE_FontWeightMedium, color: APPSTYLE_BackgroundWhite)),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(
                    horizontal: APPSTYLE_SpaceLarge, vertical: APPSTYLE_SpaceMedium)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall))),
            backgroundColor:
            MaterialStateProperty.all<Color>(APPSTYLE_PrimaryColor))),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                decoration: TextDecoration.underline,
                fontSize: APPSTYLE_FontSize12,
                fontWeight: APPSTYLE_FontWeightLight,
                decorationThickness: 2,
                color: APPSTYLE_Grey40,
                height: 1.3)),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.zero),
            minimumSize: MaterialStateProperty.all<Size>(Size.zero),
            foregroundColor: MaterialStateProperty.all<Color>(APPSTYLE_Grey60),
            backgroundColor:
            MaterialStateProperty.all<Color>(Colors.transparent))),
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: APPSTYLE_Grey20,
        contentPadding:
        const EdgeInsets.symmetric(vertical: APPSTYLE_SpaceMedium, horizontal: APPSTYLE_SpaceLarge ),
        labelStyle: TextStyle(color: APPSTYLE_Grey80),
        hintStyle: TextStyle(color: APPSTYLE_Grey60),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
            borderSide: BorderSide(width: .5,color: APPSTYLE_Grey20 )),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
            borderSide: BorderSide(width: .5, color: APPSTYLE_Grey40)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
            borderSide: const BorderSide(
                color:APPSTYLE_GuideRed, width: 1.0)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
            borderSide: const BorderSide(
                color: APPSTYLE_Grey40, width: 1.0)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
            borderSide: const BorderSide(
                color: APPSTYLE_GuideRed, width: 1.0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
            borderSide: const BorderSide(
                color: APPSTYLE_Grey40, width: .50)) ),
    scaffoldBackgroundColor: APPSTYLE_BackgroundWhite,
    appBarTheme: AppBarTheme(
        titleTextStyle:TextStyle(
          fontWeight: APPSTYLE_FontWeightBold,
          fontSize:locale=='en'?
          APPSTYLE_FontSize20:APPSTYLE_FontSize16,
          color: APPSTYLE_PrimaryColorDark,
          fontFamily: locale == 'en'
              ? APPSTYLE_DefaultFontFamilyEnglish
              : APPSTYLE_DefaultFontFamilyArabic,
        ),
        backgroundColor: APPSTYLE_BackgroundWhite,
        foregroundColor: APPSTYLE_Grey80,
        centerTitle: true,
        elevation: 2.0),
  );
}
