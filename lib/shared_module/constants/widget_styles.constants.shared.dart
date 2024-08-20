 import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// flutter component styles

const APPSTYLE_FontWeightExtraLight = FontWeight.w200;
const APPSTYLE_FontWeightLight = FontWeight.w300;
const APPSTYLE_FontWeightRegular = FontWeight.w400;
const APPSTYLE_FontWeightMedium = FontWeight.w500;
const APPSTYLE_FontWeightBold = FontWeight.w700;

const APPSTYLE_LargePaddingAll = EdgeInsets.all(APPSTYLE_SpaceLarge);
const APPSTYLE_LargePaddingHorizontal =
EdgeInsets.symmetric(horizontal: APPSTYLE_SpaceLarge);
const APPSTYLE_LargePaddingVertical =
EdgeInsets.symmetric(vertical: APPSTYLE_SpaceLarge);
const APPSTYLE_MediumPaddingAll = EdgeInsets.all(APPSTYLE_SpaceMedium);
const APPSTYLE_MediumPaddingVertical =
EdgeInsets.symmetric(vertical: APPSTYLE_SpaceMedium);
const APPSTYLE_MediumPaddingHorizontal =
EdgeInsets.symmetric(horizontal: APPSTYLE_SpaceMedium);
const APPSTYLE_MediumPaddingTop = EdgeInsets.only(top: APPSTYLE_SpaceMedium);
const APPSTYLE_SmallPaddingAll = EdgeInsets.all(APPSTYLE_SpaceSmall);
const APPSTYLE_SmallPaddingVertical =
EdgeInsets.symmetric(vertical: APPSTYLE_SpaceSmall);
 const APPSTYLE_SmallPaddingHorizontal =
 EdgeInsets.symmetric(horizontal: APPSTYLE_SpaceSmall);
const APPSTYLE_ExtraSmallPaddingAll = EdgeInsets.all(APPSTYLE_SpaceExtraSmall);
const APPSTYLE_ExtraSmallPaddingVertical =
EdgeInsets.symmetric(vertical: APPSTYLE_SpaceExtraSmall);
 const APPSTYLE_ExtraSmallPaddingHorizontal =
 EdgeInsets.symmetric(horizontal: APPSTYLE_SpaceExtraSmall);
var APPSTYLE_ContainerShadow = [
  const BoxShadow(
    color: APPSTYLE_Grey80Shadow24,
    offset: Offset(0, 4.0),
    blurRadius: APPSTYLE_BlurRadiusLarge,
  ),
];

var APPSTYLE_ContainerTopShadow = [
  const BoxShadow(
    color: APPSTYLE_Grey80Shadow24,
    offset: Offset(0, -4.0),
    blurRadius: APPSTYLE_BlurRadiusLarge,
  ),
];

var APPSTYLE_ItemShadow = [
  const BoxShadow(
    color: APPSTYLE_Grey80Shadow24,
    offset: Offset(0, 4.0),
    blurRadius: APPSTYLE_BlurRadiusSmall,
  ),
];

var APPSTYLE_DefaultBorderAll = Border.all(color: APPSTYLE_Grey40, width: .2);

var APPSTYLE_DefaultBorderTopOnly = const Border(
  top: BorderSide(
    color: APPSTYLE_Grey40,
    width: 1.0,
  ),
);

var APPSTYLE_DefaultBorderBottomOnly = const Border(
  bottom: BorderSide(
    color: APPSTYLE_Grey40,
    width: 1.0,
  ),
);

var APPSTYLE_ShadowedContainerLargeDecoration = BoxDecoration(
  color: APPSTYLE_BackgroundWhite,
  boxShadow: APPSTYLE_ContainerShadow,
  borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusLarge),
);

var APPSTYLE_TopShadowedContainerLargeDecoration = BoxDecoration(
  color: APPSTYLE_BackgroundWhite,
  boxShadow: APPSTYLE_ContainerTopShadow,
  borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusLarge),
);

var APPSTYLE_ShadowedContainerMediumDecoration = BoxDecoration(
  color: APPSTYLE_BackgroundWhite,
  boxShadow: APPSTYLE_ContainerShadow,
  borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusMedium),
);

var APPSTYLE_BorderedContainerDarkMediumDecoration = BoxDecoration(
  color: APPSTYLE_Grey20,
  border: APPSTYLE_DefaultBorderAll,
  borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusMedium),
);

var APPSTYLE_ShadowedContainerSmallDecoration = BoxDecoration(
  color: APPSTYLE_BackgroundWhite,
  border: APPSTYLE_DefaultBorderAll,
  boxShadow: APPSTYLE_ContainerShadow,
  borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusSmall),
);
 var APPSTYLE_ShadowedContainerExtraSmallDecoration = BoxDecoration(
   color: APPSTYLE_BackgroundWhite,
   border: APPSTYLE_DefaultBorderAll,
   boxShadow: APPSTYLE_ContainerShadow,
   borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
 );
 var APPSTYLE_BorderedContainerExtraSmallDecoration = BoxDecoration(
   color: APPSTYLE_BackgroundWhite,
   border: APPSTYLE_DefaultBorderAll,
   borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
 );

var APPSTYLE_BorderedContainerDarkSmallDecoration = BoxDecoration(
  color: APPSTYLE_Grey20,
  border: APPSTYLE_DefaultBorderAll,
  borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusSmall),
);

var APPSTYLE_ShadowedContainerSmallWithBorderDecoration = BoxDecoration(
  color: APPSTYLE_BackgroundWhite,
  boxShadow: APPSTYLE_ContainerShadow,
  border: APPSTYLE_DefaultBorderAll,
  borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusSmall),
);

var APPSTYLE_BorderedContainerLargeDecoration = BoxDecoration(
  color: APPSTYLE_BackgroundWhite,
  border: APPSTYLE_DefaultBorderAll,
  borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusLarge),
);

var APPSTYLE_BorderedContainerMediumDecoration = BoxDecoration(
  color: APPSTYLE_BackgroundWhite,
  border: APPSTYLE_DefaultBorderAll,
  borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusMedium),
);

var APPSTYLE_BorderedContainerSmallDecoration = BoxDecoration(
  color: APPSTYLE_BackgroundWhite,
  border: APPSTYLE_DefaultBorderAll,
  borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusSmall),
);

var APPSTYLE_ElevatedButtonStyleDark =
ElevatedButton.styleFrom(backgroundColor: APPSTYLE_Grey80);

var APPSTYLE_OutlinedButtonStylePrimary = OutlinedButton.styleFrom(
  side: BorderSide(color: APPSTYLE_PrimaryColor, width: 2),
  textStyle: TextStyle(
      fontWeight: APPSTYLE_FontWeightMedium, color: APPSTYLE_PrimaryColor),
);

 var APPSTYLE_TextButtonStylePrimary = TextButton.styleFrom(
   textStyle: TextStyle(
       fontWeight: APPSTYLE_FontWeightMedium, color: APPSTYLE_PrimaryColor),
 );


var noBorderInputDecoration = InputDecoration(

    contentPadding: const EdgeInsets.symmetric(vertical: APPSTYLE_SpaceSmall),
    labelStyle: TextStyle(color: APPSTYLE_Grey80),
    hintStyle: TextStyle(color: APPSTYLE_Grey60),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusSmall * 100),
        borderSide: BorderSide(width: 0, color: Colors.transparent)),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusSmall * 100),
        borderSide: BorderSide(width: 0, color: Colors.transparent)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusSmall * 100),
        borderSide: const BorderSide(color: Colors.transparent, width: 0)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusSmall * 100),
        borderSide: const BorderSide(color: Colors.transparent, width: 0)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusSmall * 100),
        borderSide: const BorderSide(color: Colors.transparent, width: 0)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusSmall * 100),
        borderSide: const BorderSide(color: Colors.transparent, width: 0)));

var bottomBorderInputDecoration = InputDecoration(
    filled: true,
    fillColor: APPSTYLE_BackgroundWhite,

    contentPadding: const EdgeInsets.symmetric(vertical: APPSTYLE_SpaceExtraSmall,
        horizontal: APPSTYLE_SpaceExtraSmall),
    labelStyle: TextStyle(color: APPSTYLE_Grey80,fontSize: APPSTYLE_FontSize12),
    hintStyle: TextStyle(color: APPSTYLE_Grey60,fontSize: APPSTYLE_FontSize12),
    border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide(width: .5,color: APPSTYLE_Grey20 )),
    disabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide(width: .5, color: APPSTYLE_Grey40)),
    errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: const BorderSide(
            color:APPSTYLE_GuideRed, width: 1.0)),
    focusedBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: const BorderSide(
            color: APPSTYLE_Grey40, width: 1.0)),
    focusedErrorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: const BorderSide(
            color: APPSTYLE_GuideRed, width: 1.0)),
    enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: const BorderSide(
            color: APPSTYLE_Grey40, width: .50)));
