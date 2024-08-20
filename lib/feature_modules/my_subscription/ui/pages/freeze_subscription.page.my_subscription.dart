// import 'package:dietsteps/feature_modules/my_subscription/controller/my_subscription.controller.dart';
// import 'package:dietsteps/feature_modules/my_subscription/ui/components/meal_calendar_date.my_subscription.dart';
// import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
// import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
// import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
// import 'package:dietsteps/shared_module/services/utility-services/calendar_utilities.service.shared.dart';
// import 'package:dietsteps/shared_module/services/utility-services/date_conversion.service.shared.dart';
// import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
// import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
// import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
// import 'package:dietsteps/shared_module/ui/components/custom_curve_shape.component.shared.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:shimmer/shimmer.dart';
//
// class FreezeSubscriptionPage_MySubscription extends StatefulWidget {
//   const FreezeSubscriptionPage_MySubscription({super.key});
//
//   @override
//   State<FreezeSubscriptionPage_MySubscription> createState() => _FreezeSubscriptionPage_MySubscriptionState();
// }
//
// class _FreezeSubscriptionPage_MySubscriptionState extends State<FreezeSubscriptionPage_MySubscription> {
//
//   final mySubscriptionController = Get.find<MySubscriptionController>();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     mySubscriptionController.getSubscriptionDates(true);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     double screenwidth = MediaQuery.of(context).size.width;
//     return   Scaffold(
//
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: APPSTYLE_PrimaryColorBg,
//         scrolledUnderElevation:0.0,
//         elevation: 0.0,
//         title: Row(
//           children: [
//             CustomBackButton(isPrimaryMode: false),
//           ],
//         ),
//         actions: [
//
//         ],
//       ),
//       body: SafeArea(child: Container(
//         child:Obx(
//               ()=> Column(
//             children: [
//               CustomCurveShapeComponent_Shared(
//                 color: APPSTYLE_PrimaryColorBg,
//                 title: "freeze_sub".tr ,
//               ),
//               Expanded(
//                 child: Column(
//                     children: [
//                       Visibility(
//                         visible:  mySubscriptionController.isSubscriptionDatesLoading.value,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Shimmer.fromColors(
//                               baseColor: APPSTYLE_Grey20,
//                               highlightColor: APPSTYLE_Grey40,
//                               child:Container(
//                                 decoration: APPSTYLE_ShadowedContainerSmallDecoration.copyWith(
//                                     boxShadow:  [
//                                       const BoxShadow(
//                                         color: APPSTYLE_Grey80Shadow24,
//                                         offset: Offset(1.0, 1.0),
//                                         blurRadius: 2,
//                                       ),
//                                     ],
//                                     border: Border.all(
//                                         color: Colors.transparent, width: .2),
//                                     color: APPSTYLE_Grey20),
//                                 margin: APPSTYLE_LargePaddingAll.copyWith(top: 0),
//                                 padding: APPSTYLE_MediumPaddingAll,
//                                 height: 350,
//                                 width: screenwidth-(APPSTYLE_SpaceLarge*2),
//                               ),
//                             ),
//
//                           ],
//                         ),
//                       ),
//                       Visibility(
//                         visible: mySubscriptionController.subscriptionDates.isNotEmpty &&
//                             !mySubscriptionController.isSubscriptionDatesLoading.value,
//                         child: Expanded(
//                           child: Container(
//                             decoration: APPSTYLE_ShadowedContainerSmallDecoration.copyWith(
//                                 boxShadow:  [
//                                   const BoxShadow(
//                                     color: APPSTYLE_Grey80Shadow24,
//                                     offset: Offset(1.0, 1.0),
//                                     blurRadius: 2,
//                                   ),
//                                 ],
//                                 border: Border.all(
//                                     color: Colors.transparent, width: .2),
//                                 color: APPSTYLE_Grey20),
//                             margin: APPSTYLE_LargePaddingAll.copyWith(top: 0),
//                             padding: APPSTYLE_MediumPaddingAll  ,
//                             width: screenwidth-(APPSTYLE_SpaceLarge*2),
//                             child: ListView(
//                               children: [
//
//                                 // Month change arrows and current month title
//                                 Row(
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         mySubscriptionController.previousMonth();
//
//                                       },
//                                       child: Container(
//                                           padding: APPSTYLE_ExtraSmallPaddingAll,
//                                           decoration:
//                                           APPSTYLE_BorderedContainerExtraSmallDecoration
//                                               .copyWith(color: APPSTYLE_BackgroundWhite),
//                                           child: Icon(Localizations.localeOf(context)
//                                               .languageCode
//                                               .toString() ==
//                                               'ar'?Ionicons.chevron_forward:Ionicons.chevron_back,
//                                               color: Colors.black)),
//                                     ),
//                                     Expanded(
//                                         child: Container(
//                                           child: Text(
//                                             getFormattedCurrentMonth( mySubscriptionController.currentMonth.value ),
//                                             textAlign: TextAlign.center,
//                                             style: getHeadlineMediumStyle(context)
//                                                 .copyWith(
//                                                 color: APPSTYLE_PrimaryColorBg,
//                                                 fontWeight: APPSTYLE_FontWeightBold),
//                                           ),
//                                         )),
//                                     InkWell(
//                                       onTap: () {
//                                         mySubscriptionController.nextMonth();
//                                       },
//                                       child: Container(
//                                           padding: APPSTYLE_ExtraSmallPaddingAll,
//                                           decoration:
//                                           APPSTYLE_BorderedContainerExtraSmallDecoration
//                                               .copyWith(color: APPSTYLE_BackgroundWhite),
//                                           child: Icon(Localizations.localeOf(context)
//                                               .languageCode
//                                               .toString() ==
//                                               'ar'?Ionicons.chevron_back:Ionicons.chevron_forward,
//                                               color: Colors.black)),
//                                     ),
//                                   ],
//                                 ),
//                                 addVerticalSpace(APPSTYLE_SpaceLarge),
//                                 // week day names
//                                 Container(
//                                   width: screenwidth,
//                                   height:  35,
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         flex: 1,
//                                         child: FittedBox(
//                                           fit: BoxFit.scaleDown,
//                                           child: Text( 'sun'.tr,
//                                               textAlign: TextAlign.center,
//                                               style: getBodyMediumStyle(context)
//                                                   .copyWith(color: APPSTYLE_Grey80)),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 1,
//                                         child: FittedBox(
//                                           fit: BoxFit.scaleDown,
//                                           child: Text( 'mon'.tr,
//                                               textAlign: TextAlign.center,
//                                               style: getBodyMediumStyle(context)
//                                                   .copyWith(color: APPSTYLE_Grey80)),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 1,
//                                         child: FittedBox(
//                                           fit: BoxFit.scaleDown,
//                                           child: Text( 'tue'.tr,
//                                               textAlign: TextAlign.center,
//                                               style: getBodyMediumStyle(context)
//                                                   .copyWith(color: APPSTYLE_Grey80)),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 1,
//                                         child: FittedBox(
//                                           fit: BoxFit.scaleDown,
//                                           child: Text( 'wed'.tr,
//                                               textAlign: TextAlign.center,
//                                               style: getBodyMediumStyle(context)
//                                                   .copyWith(color: APPSTYLE_Grey80)),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 1,
//                                         child: FittedBox(
//                                           fit: BoxFit.scaleDown,
//                                           child: Text( 'thu'.tr,
//                                               textAlign: TextAlign.center,
//                                               style: getBodyMediumStyle(context)
//                                                   .copyWith(color: APPSTYLE_Grey80)),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 1,
//                                         child: FittedBox(
//                                           fit: BoxFit.scaleDown,
//                                           child: Text( 'fri'.tr,
//                                               textAlign: TextAlign.center,
//                                               style: getBodyMediumStyle(context)
//                                                   .copyWith(color: APPSTYLE_Grey80)),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 1,
//                                         child: FittedBox(
//                                           fit: BoxFit.scaleDown,
//                                           child: Text( 'sat'.tr,
//                                               textAlign: TextAlign.center,
//                                               style: getBodyMediumStyle(context)
//                                                   .copyWith(color: APPSTYLE_Grey80)),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 addVerticalSpace(APPSTYLE_SpaceSmall),
//
//
//                                 //calendar starts here
//
//                                 Container(
//                                   width: screenwidth,
//                                   height: 40 + (APPSTYLE_SpaceExtraSmall * 2),
//                                   child: Row(
//                                     children: [
//                                       for(var i=0;i<mySubscriptionController.firstWeekDays.length;i++)
//                                         Expanded(
//                                           flex: 1,
//                                           child: InkWell(
//                                             onTap: () {
//                                               mySubscriptionController.addDayToFreeze(mySubscriptionController.firstWeekDays[i]);
//
//                                             },
//                                             child: MealCalendarDateComponent_MySubscription(
//                                                 isSelected:mySubscriptionController.isAlreadySelectedForFreezing(mySubscriptionController.firstWeekDays[i]),
//                                                 status:mySubscriptionController.getDayStatus(mySubscriptionController.firstWeekDays[i]),
//
//                                                 isSubscriptionDay:mySubscriptionController.isSubscriptionDay(mySubscriptionController.firstWeekDays[i]),
//
//                                                 borderColor: Colors.transparent,
//                                                 isMonthDay:mySubscriptionController.firstWeekDays[i].month==
//                                                     mySubscriptionController.currentMonth.value.month,
//                                                 dateText:
//                                                 mySubscriptionController.firstWeekDays[i].day<10?
//                                                 '0${mySubscriptionController.firstWeekDays[i].day}':mySubscriptionController.firstWeekDays[i].day.toString()
//                                             ),
//                                           ),
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                                 addVerticalSpace(APPSTYLE_SpaceExtraSmall),
//                                 Container(
//                                   width: screenwidth,
//                                   height: 40 + (APPSTYLE_SpaceExtraSmall * 2),
//
//                                   child: Row(
//                                     children: [
//                                       for(var i=0;i<mySubscriptionController.secondWeekDays.length;i++)
//                                         Expanded(
//                                           flex: 1,
//                                           child: InkWell(
//                                             onTap: () {
//                                               mySubscriptionController.addDayToFreeze(mySubscriptionController.secondWeekDays[i]);
//
//                                             },
//                                             child: MealCalendarDateComponent_MySubscription(
//                                                 isSelected:mySubscriptionController.isAlreadySelectedForFreezing(mySubscriptionController.secondWeekDays[i]),
//                                                 status:mySubscriptionController.getDayStatus(mySubscriptionController.secondWeekDays[i]),
//
//                                                 isSubscriptionDay:mySubscriptionController.isSubscriptionDay(mySubscriptionController.secondWeekDays[i]),
//                                                 borderColor: Colors.transparent,
//                                                 isMonthDay:mySubscriptionController.secondWeekDays[i].month==
//                                                     mySubscriptionController.currentMonth.value.month,
//                                                 dateText:
//                                                 mySubscriptionController.secondWeekDays[i].day<10?
//                                                 '0${mySubscriptionController.secondWeekDays[i].day}':mySubscriptionController.secondWeekDays[i].day.toString()
//                                             ),
//                                           ),
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                                 addVerticalSpace(APPSTYLE_SpaceExtraSmall),
//                                 Container(
//                                   width: screenwidth,
//                                   height: 40 + (APPSTYLE_SpaceExtraSmall * 2),
//
//                                   child: Row(
//                                     children: [
//                                       for(var i=0;i<mySubscriptionController.thirdWeekDays.length;i++)
//                                         Expanded(
//                                           flex: 1,
//                                           child: InkWell(
//                                             onTap: () {
//                                               mySubscriptionController.addDayToFreeze(mySubscriptionController.thirdWeekDays[i]);
//
//                                             },
//                                             child: MealCalendarDateComponent_MySubscription(
//                                                 isSelected:mySubscriptionController.isAlreadySelectedForFreezing(mySubscriptionController.thirdWeekDays[i]),
//                                                 status:mySubscriptionController.getDayStatus(mySubscriptionController.thirdWeekDays[i]),
//
//                                                 isSubscriptionDay:mySubscriptionController.isSubscriptionDay(mySubscriptionController.thirdWeekDays[i]),
//                                                 borderColor: Colors.transparent,
//                                                 isMonthDay:mySubscriptionController.thirdWeekDays[i].month==
//                                                     mySubscriptionController.currentMonth.value.month,
//                                                 dateText:
//                                                 mySubscriptionController.thirdWeekDays[i].day<10?
//                                                 '0${mySubscriptionController.thirdWeekDays[i].day}':mySubscriptionController.thirdWeekDays[i].day.toString()
//                                             ),
//                                           ),
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                                 addVerticalSpace(APPSTYLE_SpaceExtraSmall),
//                                 Container(
//                                   width: screenwidth,
//                                   height: 40 + (APPSTYLE_SpaceExtraSmall * 2),
//
//                                   child: Row(
//                                     children: [
//                                       for(var i=0;i<mySubscriptionController.fourthWeekDays.length;i++)
//                                         Expanded(
//                                           flex: 1,
//                                           child: InkWell(
//                                             onTap: () {
//                                               mySubscriptionController.addDayToFreeze(mySubscriptionController.fourthWeekDays[i]);
//
//                                             },
//                                             child: MealCalendarDateComponent_MySubscription(
//                                                 isSelected:mySubscriptionController.isAlreadySelectedForFreezing(mySubscriptionController.fourthWeekDays[i]),
//                                                 status:mySubscriptionController.getDayStatus(mySubscriptionController.fourthWeekDays[i]),
//
//                                                 isSubscriptionDay:mySubscriptionController.isSubscriptionDay(mySubscriptionController.fourthWeekDays[i]),
//                                                 borderColor: Colors.transparent,
//                                                 isMonthDay:mySubscriptionController.fourthWeekDays[i].month==
//                                                     mySubscriptionController.currentMonth.value.month,
//                                                 dateText:
//                                                 mySubscriptionController.fourthWeekDays[i].day<10?
//                                                 '0${mySubscriptionController.fourthWeekDays[i].day}':mySubscriptionController.fourthWeekDays[i].day.toString()
//                                             ),
//                                           ),
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                                 addVerticalSpace(APPSTYLE_SpaceExtraSmall),
//                                 Container(
//                                   width: screenwidth,
//                                   height: 40 + (APPSTYLE_SpaceExtraSmall * 2),
//
//                                   child: Row(
//                                     children: [
//                                       for(var i=0;i<mySubscriptionController.fifthWeekDays.length;i++)
//                                         Expanded(
//                                           flex: 1,
//                                           child: InkWell(
//                                             onTap: () {
//                                               mySubscriptionController.addDayToFreeze(mySubscriptionController.fifthWeekDays[i]);
//
//                                             },
//                                             child:MealCalendarDateComponent_MySubscription (
//                                                 isSelected:mySubscriptionController.isAlreadySelectedForFreezing(mySubscriptionController.fifthWeekDays[i]),
//                                                 status:mySubscriptionController.getDayStatus(mySubscriptionController.fifthWeekDays[i]),
//
//                                                 isSubscriptionDay:mySubscriptionController.isSubscriptionDay(mySubscriptionController.fifthWeekDays[i]),
//                                                 borderColor: Colors.transparent,
//                                                 isMonthDay:mySubscriptionController.fifthWeekDays[i].month==
//                                                     mySubscriptionController.currentMonth.value.month,
//                                                 dateText:
//                                                 mySubscriptionController.fifthWeekDays[i].day<10?
//                                                 '0${mySubscriptionController.fifthWeekDays[i].day}':mySubscriptionController.fifthWeekDays[i].day.toString()
//                                             ),
//                                           ),
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                                 addVerticalSpace(APPSTYLE_SpaceExtraSmall),
//                                 Container(
//                                   width: screenwidth,
//                                   height: 40 + (APPSTYLE_SpaceExtraSmall * 2),
//                                   child: Row(
//                                     children: [
//                                       for(var i=0;i<mySubscriptionController.sixthWeekDays.length;i++)
//                                         Expanded(
//                                           flex: 1,
//                                           child: InkWell(
//                                             onTap: () {
//                                               mySubscriptionController.addDayToFreeze(mySubscriptionController.sixthWeekDays[i]);
//                                             },
//                                             child:MealCalendarDateComponent_MySubscription (
//                                                 isSelected:mySubscriptionController.isAlreadySelectedForFreezing(mySubscriptionController.sixthWeekDays[i]),
//                                                 status:mySubscriptionController.getDayStatus(mySubscriptionController.sixthWeekDays[i]),
//                                                 isSubscriptionDay:mySubscriptionController.isSubscriptionDay(mySubscriptionController.sixthWeekDays[i]),
//                                                 borderColor: Colors.transparent,
//                                                 isMonthDay:mySubscriptionController.sixthWeekDays[i].month==
//                                                     mySubscriptionController.currentMonth.value.month,
//                                                 dateText:
//                                                 mySubscriptionController.sixthWeekDays[i].day<10?
//                                                 '0${mySubscriptionController.sixthWeekDays[i].day}':mySubscriptionController.sixthWeekDays[i].day.toString()
//                                             ),
//                                           ),
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//
//
//
//                       // No subs message
//
//                       Visibility(
//                         visible: mySubscriptionController.subscriptionDates.isEmpty &&
//                             !mySubscriptionController.isSubscriptionDatesLoading.value,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(1000),
//                                 color: APPSTYLE_Grey20,
//                               ),
//                               width: screenwidth * .3,
//                               height: screenwidth * .3,
//                               child: Center(
//                                 child: Icon(Ionicons.cash_outline,
//                                     size: screenwidth * .15,
//                                     color: APPSTYLE_PrimaryColorBg),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       Visibility(
//                           visible: mySubscriptionController.subscriptionDates.isEmpty &&
//                               !mySubscriptionController.isSubscriptionDatesLoading.value,child: addVerticalSpace(APPSTYLE_SpaceLarge)),
//                       Visibility(
//                         visible: mySubscriptionController.subscriptionDates.isEmpty &&
//                             !mySubscriptionController.isSubscriptionDatesLoading.value,
//                         child: Text("no_active_subscription".tr,
//                             textAlign: TextAlign.center,
//                             style: getHeadlineMediumStyle(context)),
//                       ),
//                       Visibility(
//                           visible: mySubscriptionController.subscriptionDates.isEmpty &&
//                               !mySubscriptionController.isSubscriptionDatesLoading.value,child: addVerticalSpace(APPSTYLE_SpaceLarge)),
//                       Visibility(
//                         visible: mySubscriptionController.subscriptionDates.isEmpty &&
//                             !mySubscriptionController.isSubscriptionDatesLoading.value,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                                 width: screenwidth * .6,
//                                 child: ElevatedButton(
//                                     style: ButtonStyle(
//                                         padding: MaterialStateProperty.all<
//                                             EdgeInsetsGeometry>(
//                                             const EdgeInsets.symmetric(
//                                                 horizontal: APPSTYLE_SpaceMedium,
//                                                 vertical:
//                                                 APPSTYLE_SpaceExtraSmall)),
//                                         shape: MaterialStateProperty.all<OutlinedBorder>(
//                                             RoundedRectangleBorder(
//                                                 borderRadius:
//                                                 BorderRadius.circular(1000)))),
//                                     child: FittedBox(
//                                       fit: BoxFit.scaleDown,
//                                       child: Text(  "purchase_subscription"
//                                           .tr,
//                                           style: getLabelLargeStyle(context)
//                                               .copyWith(
//                                               color:
//                                               APPSTYLE_BackgroundWhite,
//                                               fontWeight:
//                                               APPSTYLE_FontWeightBold),
//                                           textAlign: TextAlign.center),
//                                     ),
//                                     onPressed: () {
//                                       Get.toNamed(AppRouteNames
//                                           .planPurchaseSubscriptionPlansCategoryListRoute);
//                                     })),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: APPSTYLE_SpaceLarge,vertical: APPSTYLE_SpaceSmall),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                         if(!mySubscriptionController
//                             .isFreezing.value){
//                           mySubscriptionController.freezeSubscription();
//                         }
//                     },
//                     style: getElevatedButtonStyle(context),
//                     child:  mySubscriptionController
//                         .isFreezing.value
//                         ? LoadingAnimationWidget.staggeredDotsWave(
//                       color: APPSTYLE_BackgroundWhite,
//                       size: 24,
//                     )
//                         : Text("freeze".tr,
//                         style: getHeadlineMediumStyle(context).copyWith(
//                             color: APPSTYLE_BackgroundWhite,
//                             fontWeight: APPSTYLE_FontWeightBold),
//                         textAlign: TextAlign.center),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )),
//     );
//   }
//
//
//   String getCalendarDayText(int index) {
//     if (index < 7) {
//       return getDayNameByIndex(index);
//     }
//     if (index == 7) {
//       return "31";
//     }
//     if (index < 39) {
//       if ((index - 7) < 10) {
//         return '0${(index - 7).toString()}';
//       }
//       return (index - 7).toString();
//     }
//     if ((index - 38) < 10) {
//       return '0${(index - 38).toString()}';
//     }
//     return (index - 38).toString();
//   }
//
//   getCalendarDayTextColor(int index) {
//     if (index < 7) {
//       return APPSTYLE_Black;
//     }
//     if (index == 7) {
//       return APPSTYLE_Grey40;
//     }
//     if (index > 38) {
//       return APPSTYLE_Grey40;
//     }
//     return APPSTYLE_PrimaryColorBg;
//   }
//
// }
