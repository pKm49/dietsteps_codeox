import 'package:dietsteps/feature_modules/my_subscription/controller/my_subscription.controller.dart';
import 'package:dietsteps/feature_modules/my_subscription/ui/components/meal_calendar_date.my_subscription.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/calendar_utilities.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/date_conversion.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_curve_shape.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';

class MealCalendarPage_MySubscription extends StatefulWidget {
  const MealCalendarPage_MySubscription({super.key});

  @override
  State<MealCalendarPage_MySubscription> createState() => _MealCalendarPage_MySubscriptionState();
}

class _MealCalendarPage_MySubscriptionState extends State<MealCalendarPage_MySubscription> {

   final mySubscriptionController = Get.find<MySubscriptionController>();
   final sharedController = Get.find<SharedController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedController.getCustomerSubscriptions();
    mySubscriptionController.getSubscriptionDates(true,false);
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return   Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: APPSTYLE_PrimaryColorBg,
        scrolledUnderElevation:0.0,
        elevation: 0.0,
        actions: [
          InkWell(
            onTap: (){
              openCalendarNotationsGuide(screenwidth);
            },
            child: Icon(Ionicons.help_circle_outline,color: APPSTYLE_BackgroundWhite,),
          ),
          addHorizontalSpace(APPSTYLE_SpaceLarge)
        ],
      ),
      body: SafeArea(child: Container(
        child: Column(
          children: [
            CustomCurveShapeComponent_Shared(
              color: APPSTYLE_PrimaryColorBg,
              title: "meal_calendar".tr ,
              subtitle: " ${sharedController.userData.value.deliveryTime.toString()}",
            ),
            Expanded(
              child: Obx(
                ()=>Column(
                  children: [
                    Visibility(
                      visible:  mySubscriptionController.isSubscriptionDatesLoading.value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: APPSTYLE_Grey20,
                            highlightColor: APPSTYLE_Grey40,
                            child:Container(
                              decoration: APPSTYLE_ShadowedContainerSmallDecoration.copyWith(
                                  boxShadow:  [
                                    const BoxShadow(
                                      color: APPSTYLE_Grey80Shadow24,
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 2,
                                    ),
                                  ],
                                  border: Border.all(
                                      color: Colors.transparent, width: .2),
                                  color: APPSTYLE_Grey20),
                              margin: APPSTYLE_SmallPaddingAll.copyWith(top: 0),
                              height: 450,
                              width: screenwidth-(APPSTYLE_SpaceSmall*2),
                            ),
                          ),

                        ],
                      ),
                    ),

                    Visibility(
                      visible: mySubscriptionController.subscriptionDates.isNotEmpty &&
                           !mySubscriptionController.isSubscriptionDatesLoading.value,
                      child: Expanded(
                        child: GestureDetector(
                            onHorizontalDragEnd: (DragEndDetails details) {
                              if (details.primaryVelocity! < 0) {
                                Localizations.localeOf(context)
                                    .languageCode
                                    .toString() ==
                                    'ar'?
                                mySubscriptionController.previousMonth():
                                mySubscriptionController.nextMonth();
                              } else if (details.primaryVelocity! > 0) {
                                Localizations.localeOf(context)
                                    .languageCode
                                    .toString() ==
                                    'ar'?
                                mySubscriptionController.nextMonth():
                                mySubscriptionController.previousMonth();
                              }
                            } ,
                          child: Container(
                            margin: APPSTYLE_SmallPaddingAll.copyWith(top: 0),
                            width: screenwidth-(APPSTYLE_SpaceSmall*2),
                            child: ListView(
                              children: [

                                // Month change arrows and current month title
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        mySubscriptionController.previousMonth();

                                      },
                                      child: Container(
                                          padding: APPSTYLE_ExtraSmallPaddingAll,
                                          decoration:
                                          APPSTYLE_BorderedContainerExtraSmallDecoration
                                              .copyWith(color: APPSTYLE_BackgroundWhite),
                                          child: Icon(Localizations.localeOf(context)
                                              .languageCode
                                              .toString() ==
                                              'ar'?Ionicons.chevron_forward:Ionicons.chevron_back,
                                              color: Colors.black)),
                                    ),
                                    Expanded(
                                        child: Container(
                                          child: Text(
                                            getFormattedCurrentMonth( mySubscriptionController.currentMonth.value ),
                                            textAlign: TextAlign.center,
                                            style: getHeadlineMediumStyle(context)
                                                .copyWith(
                                                color: APPSTYLE_PrimaryColorBg,
                                                fontWeight: APPSTYLE_FontWeightBold),
                                          ),
                                        )),
                                    InkWell(
                                      onTap: () {
                                        mySubscriptionController.nextMonth();
                                      },
                                      child: Container(
                                          padding: APPSTYLE_ExtraSmallPaddingAll,
                                          decoration:
                                          APPSTYLE_BorderedContainerExtraSmallDecoration
                                              .copyWith(color: APPSTYLE_BackgroundWhite),
                                          child: Icon(Localizations.localeOf(context)
                                              .languageCode
                                              .toString() ==
                                              'ar'?Ionicons.chevron_back:Ionicons.chevron_forward,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                                addVerticalSpace(APPSTYLE_SpaceSmall),
                                // week day names
                                Container(
                                  width: screenwidth,
                                  height:  35,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text( 'sun'.tr,
                                              textAlign: TextAlign.center,
                                              style: getBodyMediumStyle(context)
                                                  .copyWith(color: APPSTYLE_Grey80)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text( 'mon'.tr,
                                              textAlign: TextAlign.center,
                                              style: getBodyMediumStyle(context)
                                                  .copyWith(color: APPSTYLE_Grey80)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text( 'tue'.tr,
                                              textAlign: TextAlign.center,
                                              style: getBodyMediumStyle(context)
                                                  .copyWith(color: APPSTYLE_Grey80)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text( 'wed'.tr,
                                              textAlign: TextAlign.center,
                                              style: getBodyMediumStyle(context)
                                                  .copyWith(color: APPSTYLE_Grey80)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text( 'thu'.tr,
                                              textAlign: TextAlign.center,
                                              style: getBodyMediumStyle(context)
                                                  .copyWith(color: APPSTYLE_Grey80)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text( 'fri'.tr,
                                              textAlign: TextAlign.center,
                                              style: getBodyMediumStyle(context)
                                                  .copyWith(color: APPSTYLE_Grey80)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text( 'sat'.tr,
                                              textAlign: TextAlign.center,
                                              style: getBodyMediumStyle(context)
                                                  .copyWith(color: APPSTYLE_Grey80)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                addVerticalSpace(APPSTYLE_SpaceSmall),


                                //calendar starts here

                                Container(
                                  width: screenwidth,
                                  height: 55 +  (APPSTYLE_SpaceExtraSmall * 2),
                                  child: Row(
                                    children: [
                                      for(var i=0;i<mySubscriptionController.firstWeekDays.length;i++)
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              if(mySubscriptionController.firstWeekDays[i].month==
                                                  mySubscriptionController.currentMonth.value.month && mySubscriptionController.isSubscriptionDay(mySubscriptionController.firstWeekDays[i])){
                                                mySubscriptionController.getMealsByDate(mySubscriptionController.firstWeekDays[i],true);

                                              }

                                            },
                                            child: MealCalendarDateComponent_MySubscription(
                                                dateTime:mySubscriptionController.firstWeekDays[i],
                                                isSelected:isSameDay(mySubscriptionController.firstWeekDays[i],mySubscriptionController.selectedDate.value),
                                                status:mySubscriptionController.getDayStatus(mySubscriptionController.firstWeekDays[i]),

                                                isSubscriptionDay:mySubscriptionController.isSubscriptionDay(mySubscriptionController.firstWeekDays[i]),

                                                borderColor: Colors.transparent,
                                                isMonthDay:mySubscriptionController.firstWeekDays[i].month==
                                                    mySubscriptionController.currentMonth.value.month,
                                                dateText:
                                                mySubscriptionController.firstWeekDays[i].day<10?
                                                '0${mySubscriptionController.firstWeekDays[i].day}':mySubscriptionController.firstWeekDays[i].day.toString()
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                                Container(
                                  width: screenwidth,
                                  height: 55 +  (APPSTYLE_SpaceExtraSmall * 2),

                                  child: Row(
                                    children: [
                                      for(var i=0;i<mySubscriptionController.secondWeekDays.length;i++)
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              if(mySubscriptionController.secondWeekDays[i].month==
                                                  mySubscriptionController.currentMonth.value.month && mySubscriptionController.isSubscriptionDay(mySubscriptionController.secondWeekDays[i])){
                                                mySubscriptionController.getMealsByDate(mySubscriptionController.secondWeekDays[i],true);

                                              }

                                            },
                                            child: MealCalendarDateComponent_MySubscription(
                                                dateTime:mySubscriptionController.secondWeekDays[i],
                                                isSelected:isSameDay(mySubscriptionController.secondWeekDays[i],mySubscriptionController.selectedDate.value),
                                                status:mySubscriptionController.getDayStatus(mySubscriptionController.secondWeekDays[i]),

                                                isSubscriptionDay:mySubscriptionController.isSubscriptionDay(mySubscriptionController.secondWeekDays[i]),
                                                borderColor: Colors.transparent,
                                                isMonthDay:mySubscriptionController.secondWeekDays[i].month==
                                                    mySubscriptionController.currentMonth.value.month,
                                                dateText:
                                                mySubscriptionController.secondWeekDays[i].day<10?
                                                '0${mySubscriptionController.secondWeekDays[i].day}':mySubscriptionController.secondWeekDays[i].day.toString()
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                                Container(
                                  width: screenwidth,
                                  height: 55 +  (APPSTYLE_SpaceExtraSmall * 2),

                                  child: Row(
                                    children: [
                                      for(var i=0;i<mySubscriptionController.thirdWeekDays.length;i++)
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              if(mySubscriptionController.thirdWeekDays[i].month==
                                                  mySubscriptionController.currentMonth.value.month && mySubscriptionController.isSubscriptionDay(mySubscriptionController.thirdWeekDays[i])){
                                                mySubscriptionController.getMealsByDate(mySubscriptionController.thirdWeekDays[i],true);

                                              }

                                            },
                                            child: MealCalendarDateComponent_MySubscription(
                                                dateTime:mySubscriptionController.thirdWeekDays[i],
                                                isSelected:isSameDay(mySubscriptionController.thirdWeekDays[i],mySubscriptionController.selectedDate.value),
                                                status:mySubscriptionController.getDayStatus(mySubscriptionController.thirdWeekDays[i]),

                                                isSubscriptionDay:mySubscriptionController.isSubscriptionDay(mySubscriptionController.thirdWeekDays[i]),
                                                borderColor: Colors.transparent,
                                                isMonthDay:mySubscriptionController.thirdWeekDays[i].month==
                                                    mySubscriptionController.currentMonth.value.month,
                                                 dateText:
                                                mySubscriptionController.thirdWeekDays[i].day<10?
                                                '0${mySubscriptionController.thirdWeekDays[i].day}':mySubscriptionController.thirdWeekDays[i].day.toString()
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                                Container(
                                  width: screenwidth,
                                  height: 55 +  (APPSTYLE_SpaceExtraSmall * 2),

                                  child: Row(
                                    children: [
                                      for(var i=0;i<mySubscriptionController.fourthWeekDays.length;i++)
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              if(mySubscriptionController.fourthWeekDays[i].month==
                                                  mySubscriptionController.currentMonth.value.month && mySubscriptionController.isSubscriptionDay(mySubscriptionController.fourthWeekDays[i])){
                                                mySubscriptionController.getMealsByDate(mySubscriptionController.fourthWeekDays[i],true);

                                              }

                                            },
                                            child: MealCalendarDateComponent_MySubscription(
                                                dateTime:mySubscriptionController.fourthWeekDays[i],
                                                isSelected:isSameDay(mySubscriptionController.fourthWeekDays[i],mySubscriptionController.selectedDate.value),
                                                status:mySubscriptionController.getDayStatus(mySubscriptionController.fourthWeekDays[i]),

                                                isSubscriptionDay:mySubscriptionController.isSubscriptionDay(mySubscriptionController.fourthWeekDays[i]),
                                                borderColor: Colors.transparent,
                                                isMonthDay:mySubscriptionController.fourthWeekDays[i].month==
                                                    mySubscriptionController.currentMonth.value.month,
                                                dateText:
                                                mySubscriptionController.fourthWeekDays[i].day<10?
                                                '0${mySubscriptionController.fourthWeekDays[i].day}':mySubscriptionController.fourthWeekDays[i].day.toString()
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                                Container(
                                  width: screenwidth,
                                  height: 55 +  (APPSTYLE_SpaceExtraSmall * 2),

                                  child: Row(
                                    children: [
                                      for(var i=0;i<mySubscriptionController.fifthWeekDays.length;i++)
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              if(mySubscriptionController.fifthWeekDays[i].month==
                                                  mySubscriptionController.currentMonth.value.month && mySubscriptionController.isSubscriptionDay(mySubscriptionController.fifthWeekDays[i])){
                                                mySubscriptionController.getMealsByDate(mySubscriptionController.fifthWeekDays[i],true);

                                              }
                                            },
                                            child:MealCalendarDateComponent_MySubscription (
                                                dateTime:mySubscriptionController.fifthWeekDays[i],
                                                isSelected:isSameDay(mySubscriptionController.fifthWeekDays[i],mySubscriptionController.selectedDate.value),
                                                status:mySubscriptionController.getDayStatus(mySubscriptionController.fifthWeekDays[i]),

                                                isSubscriptionDay:mySubscriptionController.isSubscriptionDay(mySubscriptionController.fifthWeekDays[i]),
                                                borderColor: Colors.transparent,
                                                isMonthDay:mySubscriptionController.fifthWeekDays[i].month==
                                                    mySubscriptionController.currentMonth.value.month,
                                                dateText:
                                                mySubscriptionController.fifthWeekDays[i].day<10?
                                                '0${mySubscriptionController.fifthWeekDays[i].day}':mySubscriptionController.fifthWeekDays[i].day.toString()
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                                Container(
                                  width: screenwidth,
                                  height: 55 +  (APPSTYLE_SpaceExtraSmall * 2),
                                  child: Row(
                                    children: [
                                      for(var i=0;i<mySubscriptionController.sixthWeekDays.length;i++)
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              if(mySubscriptionController.sixthWeekDays[i].month==
                                                  mySubscriptionController.currentMonth.value.month && mySubscriptionController.isSubscriptionDay(mySubscriptionController.sixthWeekDays[i])){
                                                mySubscriptionController.getMealsByDate(mySubscriptionController.sixthWeekDays[i],true);

                                              }
                                            },
                                            child:MealCalendarDateComponent_MySubscription (
                                                dateTime:mySubscriptionController.sixthWeekDays[i],
                                                isSelected:isSameDay(mySubscriptionController.sixthWeekDays[i],mySubscriptionController.selectedDate.value),
                                                status:mySubscriptionController.getDayStatus(mySubscriptionController.sixthWeekDays[i]),
                                                isSubscriptionDay:mySubscriptionController.isSubscriptionDay(mySubscriptionController.sixthWeekDays[i]),
                                                borderColor: Colors.transparent,
                                                isMonthDay:mySubscriptionController.sixthWeekDays[i].month==
                                                    mySubscriptionController.currentMonth.value.month,
                                                dateText:
                                                mySubscriptionController.sixthWeekDays[i].day<10?
                                                '0${mySubscriptionController.sixthWeekDays[i].day}':mySubscriptionController.sixthWeekDays[i].day.toString()
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // No subs message

                    Visibility(
                      visible: mySubscriptionController.subscriptionDates.isEmpty &&
                          !mySubscriptionController.isSubscriptionDatesLoading.value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              color: APPSTYLE_Grey20,
                            ),
                            width: screenwidth * .3,
                            height: screenwidth * .3,
                            child: Center(
                              child: Icon(Ionicons.cash_outline,
                                  size: screenwidth * .15,
                                  color: APPSTYLE_PrimaryColorBg),
                            ),
                          )
                        ],
                      ),
                    ), 
                    Visibility(
                        visible: mySubscriptionController.subscriptionDates.isEmpty &&
                            !mySubscriptionController.isSubscriptionDatesLoading.value,child: addVerticalSpace(APPSTYLE_SpaceLarge)),
                    Visibility(
                      visible: mySubscriptionController.subscriptionDates.isEmpty &&
                          !mySubscriptionController.isSubscriptionDatesLoading.value,
                      child: Text("no_active_subscription".tr,
                          textAlign: TextAlign.center,
                          style: getHeadlineMediumStyle(context)),
                    ),
                    Visibility(
                        visible: mySubscriptionController.subscriptionDates.isEmpty &&
                            !mySubscriptionController.isSubscriptionDatesLoading.value,child: addVerticalSpace(APPSTYLE_SpaceLarge)),
                    Visibility(
                      visible: mySubscriptionController.subscriptionDates.isEmpty &&
                          !mySubscriptionController.isSubscriptionDatesLoading.value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: screenwidth * .6,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry>(
                                          const EdgeInsets.symmetric(
                                              horizontal: APPSTYLE_SpaceMedium,
                                              vertical:
                                              APPSTYLE_SpaceExtraSmall)),
                                      shape: MaterialStateProperty.all<OutlinedBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(1000)))),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(  "purchase_subscription"
                                        .tr,
                                        style: getLabelLargeStyle(context)
                                            .copyWith(
                                            color:
                                            APPSTYLE_BackgroundWhite,
                                            fontWeight:
                                            APPSTYLE_FontWeightBold),
                                        textAlign: TextAlign.center),
                                  ),
                                  onPressed: () {
                                    Get.toNamed(AppRouteNames
                                        .planPurchaseSubscriptionPlansCategoryListRoute);
                                  })),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      )),
    );
  }


  String getCalendarDayText(int index) {
    if (index < 7) {
      return getDayNameByIndex(index);
    }
    if (index == 7) {
      return "31";
    }
    if (index < 39) {
      if ((index - 7) < 10) {
        return '0${(index - 7).toString()}';
      }
      return (index - 7).toString();
    }
    if ((index - 38) < 10) {
      return '0${(index - 38).toString()}';
    }
    return (index - 38).toString();
  }

  getCalendarDayTextColor(int index) {
    if (index < 7) {
      return APPSTYLE_Black;
    }
    if (index == 7) {
      return APPSTYLE_Grey40;
    }
    if (index > 38) {
      return APPSTYLE_Grey40;
    }
    return APPSTYLE_PrimaryColorBg;
  }

  void openCalendarNotationsGuide(double screenwidth) {
    Get.bottomSheet(
      Container(
        width: screenwidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(APPSTYLE_BorderRadiusSmall),
            topRight: Radius.circular(APPSTYLE_BorderRadiusSmall),
          ),
        ),
        padding: APPSTYLE_LargePaddingAll,
        child:  Column(
          children: [
            Text("calendar_notations".tr,style: getHeadlineLargeStyle(context)),
            addVerticalSpace(APPSTYLE_SpaceExtraSmall),
            Divider(),
            addVerticalSpace(APPSTYLE_SpaceSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex:2,child: Column(
                      children: [
                        SvgPicture.asset(ASSETS_FOODTRUCK,height: 20,color: APPSTYLE_WhatsappGreen,),
                        Text("delivered_single".tr,style: getLabelLargeStyle(context).copyWith(color:APPSTYLE_WhatsappGreen ))

                      ],
                    )),
                addHorizontalSpace(APPSTYLE_SpaceMedium),
                Expanded(
                  flex: 10,
                  child: Text("delivered".tr,
                    style: getHeadlineMediumStyle(context) ,
                    textAlign: TextAlign.start),),

              ],
            ),
            addVerticalSpace(APPSTYLE_SpaceSmall),


            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex:2,child: Column(
                      children: [
                        SvgPicture.asset(ASSETS_FOODPLATE,height: 20,color: APPSTYLE_GuideGreen,),
                        Text("meal-selected_single".tr,style: getLabelLargeStyle(context).copyWith(color:APPSTYLE_GuideGreen ))

                      ],
                    )),
                addHorizontalSpace(APPSTYLE_SpaceMedium),
                Expanded(
                  flex: 10,
                  child: Text("meal-selected".tr,
                      style: getHeadlineMediumStyle(context),
                      textAlign: TextAlign.start),),

              ],
            ),
            addVerticalSpace(APPSTYLE_SpaceSmall),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex:2,child: Column(
                      children: [
                        SvgPicture.asset(ASSETS_SELECTHAND,width: 20,color: APPSTYLE_PrimaryColor,),
                        Text("meal-not-selected_single".tr,style: getLabelLargeStyle(context).copyWith(color:APPSTYLE_PrimaryColor ))
                      ],
                    )),
                addHorizontalSpace(APPSTYLE_SpaceMedium),
                Expanded(
                  flex: 10,
                  child: Text("meal-not-selected".tr,
                      style: getHeadlineMediumStyle(context),
                      textAlign: TextAlign.start),),

              ],
            ),
            addVerticalSpace(APPSTYLE_SpaceSmall),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex:2,child: Column(
                      children: [
                        SvgPicture.asset(ASSETS_OFFDAY,height: 20,color: APPSTYLE_GuideRed,),
                        Text("off-day_single".tr,style: getLabelLargeStyle(context).copyWith(color:APPSTYLE_GuideRed ))

                      ],
                    )),
                addHorizontalSpace(APPSTYLE_SpaceMedium),
                Expanded(
                  flex: 10,
                  child: Text("off-day".tr,
                      style: getHeadlineMediumStyle(context),
                      textAlign: TextAlign.start),),

              ],
            ),
            addVerticalSpace(APPSTYLE_SpaceMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex:2,child: Column(
                      children: [
                        SvgPicture.asset(ASSETS_PAUSE,height: 20,color: APPSTYLE_GuideOrange,),
                        Text("freezed_single".tr,style: getLabelLargeStyle(context).copyWith(color:APPSTYLE_GuideOrange ))
                      ],
                    )),
                addHorizontalSpace(APPSTYLE_SpaceMedium),
                Expanded(
                  flex: 10,child: Text("freezed".tr,
                    style: getHeadlineMediumStyle(context),
                    textAlign: TextAlign.start),),
              ],
            ),
          ],
        ),
      ),
    );
  }


}
