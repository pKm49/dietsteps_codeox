
import 'package:dietsteps/feature_modules/plan_purchase/controllers/plan_purchase.controller.dart';
import 'package:dietsteps/feature_modules/plan_purchase/ui/components/calendar_date.component.plan_purchase.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/default_values.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/calendar_utilities.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/date_conversion.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_curve_shape.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SelectInitialDatePage_PlanPurchase extends StatefulWidget {
  const SelectInitialDatePage_PlanPurchase({super.key});

  @override
  State<SelectInitialDatePage_PlanPurchase> createState() => _SelectInitialDatePage_PlanPurchaseState();
}

class _SelectInitialDatePage_PlanPurchaseState extends State<SelectInitialDatePage_PlanPurchase> {

  final planPurchaseController = Get.find<PlanPurchaseController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        title: Row(
          children: [
            CustomBackButton(isPrimaryMode: false),
          ],
        ),
        actions: [

        ],
      ),
      body: SafeArea(child: Container(
        child:Obx(
              ()=> Column(
            children: [
              CustomCurveShapeComponent_Shared(
                color: APPSTYLE_PrimaryColorBg,
                title: "select_starting_date".tr ,
                subtitle: '',
              ),
              Expanded(
                child:  Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onHorizontalDragEnd: (DragEndDetails details) {
                          if (details.primaryVelocity! < 0) {
                            Localizations.localeOf(context)
                                .languageCode
                                .toString() ==
                                'ar'?
                            planPurchaseController.previousMonth():
                            planPurchaseController.nextMonth();
                          } else if (details.primaryVelocity! > 0) {
                            Localizations.localeOf(context)
                                .languageCode
                                .toString() ==
                                'ar'?
                            planPurchaseController.nextMonth():
                            planPurchaseController.previousMonth();
                          }
                        } ,
                        child: Container(
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
                          margin: APPSTYLE_LargePaddingAll.copyWith(top: 0),
                          padding: APPSTYLE_MediumPaddingAll  ,
                          width: screenwidth-(APPSTYLE_SpaceLarge*2),
                          child: ListView(
                            children: [

                              // Month change arrows and current month title
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      planPurchaseController.previousMonth();

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
                                          getFormattedCurrentMonth( planPurchaseController.currentMonth.value ),
                                          textAlign: TextAlign.center,
                                          style: getHeadlineMediumStyle(context)
                                              .copyWith(
                                              color: APPSTYLE_PrimaryColorBg,
                                              fontWeight: APPSTYLE_FontWeightBold),
                                        ),
                                      )),
                                  InkWell(
                                    onTap: () {
                                      planPurchaseController.nextMonth();
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
                              addVerticalSpace(APPSTYLE_SpaceLarge),
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
                                height: 30 + (APPSTYLE_SpaceExtraSmall * 2),
                                child: Row(
                                  children: [
                                    for(var i=0;i<planPurchaseController.firstWeekDays.length;i++)
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {

                                            if(planPurchaseController.firstWeekDays[i].isAfter(planPurchaseController.minimumPossibleDate.value)
                                                && !isOffDay(planPurchaseController.firstWeekDays[i].weekday)){
                                              planPurchaseController.setSelectedDate(planPurchaseController.firstWeekDays[i]);
                                            }
                                          },
                                          child: CalendarDateComponent_PlanPurchase(
                                              isSelected:isSameDay(planPurchaseController.selectedDate.value, planPurchaseController.firstWeekDays[i]),
                                              isOffDay: isOffDay(planPurchaseController.firstWeekDays[i].weekday) ,
                                              isSubscriptionDay:planPurchaseController.firstWeekDays[i].isAfter(planPurchaseController.minimumPossibleDate.value)
                                                  && !isOffDay(planPurchaseController.firstWeekDays[i].weekday),
                                              borderColor: Colors.transparent,
                                              isMonthDay:planPurchaseController.firstWeekDays[i].month==
                                                  planPurchaseController.currentMonth.value.month,
                                              dateText:
                                              planPurchaseController.firstWeekDays[i].day<10?
                                              '0${planPurchaseController.firstWeekDays[i].day}':planPurchaseController.firstWeekDays[i].day.toString()
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                              Container(
                                width: screenwidth,
                                height: 30 + (APPSTYLE_SpaceExtraSmall * 2),

                                child: Row(
                                  children: [
                                    for(var i=0;i<planPurchaseController.secondWeekDays.length;i++)
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {

                                            if(planPurchaseController.secondWeekDays[i].isAfter(planPurchaseController.minimumPossibleDate.value)
                                                && !isOffDay(planPurchaseController.secondWeekDays[i].weekday)){
                                              planPurchaseController.setSelectedDate(planPurchaseController.secondWeekDays[i]);
                                            }
                                          },
                                          child: CalendarDateComponent_PlanPurchase(
                                              isSelected:isSameDay(planPurchaseController.selectedDate.value, planPurchaseController.secondWeekDays[i]),
                                              isOffDay:isOffDay(planPurchaseController.secondWeekDays[i].weekday),
                                              isSubscriptionDay:planPurchaseController.secondWeekDays[i].isAfter(planPurchaseController.minimumPossibleDate.value)
                                                  && !isOffDay(planPurchaseController.secondWeekDays[i].weekday),
                                              borderColor: Colors.transparent,
                                              isMonthDay:planPurchaseController.secondWeekDays[i].month==
                                                  planPurchaseController.currentMonth.value.month,
                                              dateText:
                                              planPurchaseController.secondWeekDays[i].day<10?
                                              '0${planPurchaseController.secondWeekDays[i].day}':planPurchaseController.secondWeekDays[i].day.toString()
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                              Container(
                                width: screenwidth,
                                height: 30 + (APPSTYLE_SpaceExtraSmall * 2),

                                child: Row(
                                  children: [
                                    for(var i=0;i<planPurchaseController.thirdWeekDays.length;i++)
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {
                                            if(planPurchaseController.thirdWeekDays[i].isAfter(planPurchaseController.minimumPossibleDate.value)
                                                && !isOffDay(planPurchaseController.thirdWeekDays[i].weekday)){
                                              planPurchaseController.setSelectedDate(planPurchaseController.thirdWeekDays[i]);
                                            }
                                          },
                                          child: CalendarDateComponent_PlanPurchase(
                                              isSelected:isSameDay(planPurchaseController.selectedDate.value, planPurchaseController.thirdWeekDays[i]),
                                              isOffDay:isOffDay(planPurchaseController.thirdWeekDays[i].weekday),
                                              isSubscriptionDay:planPurchaseController.thirdWeekDays[i].isAfter(planPurchaseController.minimumPossibleDate.value)
                                                  && !isOffDay(planPurchaseController.thirdWeekDays[i].weekday),
                                              borderColor: Colors.transparent,
                                              isMonthDay:planPurchaseController.thirdWeekDays[i].month==
                                                  planPurchaseController.currentMonth.value.month,
                                              dateText:
                                              planPurchaseController.thirdWeekDays[i].day<10?
                                              '0${planPurchaseController.thirdWeekDays[i].day}':planPurchaseController.thirdWeekDays[i].day.toString()
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                              Container(
                                width: screenwidth,
                                height: 30 + (APPSTYLE_SpaceExtraSmall * 2),

                                child: Row(
                                  children: [
                                    for(var i=0;i<planPurchaseController.fourthWeekDays.length;i++)
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {
                                            if(planPurchaseController.fourthWeekDays[i].isAfter(planPurchaseController.minimumPossibleDate.value)
                                                && !isOffDay(planPurchaseController.fourthWeekDays[i].weekday)){
                                              planPurchaseController.setSelectedDate(planPurchaseController.fourthWeekDays[i]);
                                            }
                                          },
                                          child: CalendarDateComponent_PlanPurchase(
                                              isSelected:isSameDay(planPurchaseController.selectedDate.value, planPurchaseController.fourthWeekDays[i]),
                                              isOffDay:isOffDay(planPurchaseController.fourthWeekDays[i].weekday),
                                              isSubscriptionDay:planPurchaseController.fourthWeekDays[i].isAfter(planPurchaseController.minimumPossibleDate.value)
                                                  && !isOffDay(planPurchaseController.fourthWeekDays[i].weekday),
                                              borderColor: Colors.transparent,
                                              isMonthDay:planPurchaseController.fourthWeekDays[i].month==
                                                  planPurchaseController.currentMonth.value.month,
                                              dateText:
                                              planPurchaseController.fourthWeekDays[i].day<10?
                                              '0${planPurchaseController.fourthWeekDays[i].day}':planPurchaseController.fourthWeekDays[i].day.toString()
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                              Container(
                                width: screenwidth,
                                height: 30 + (APPSTYLE_SpaceExtraSmall * 2),

                                child: Row(
                                  children: [
                                    for(var i=0;i<planPurchaseController.fifthWeekDays.length;i++)
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {
                                            if(planPurchaseController.fifthWeekDays[i].isAfter(planPurchaseController.minimumPossibleDate.value)
                                                && !isOffDay(planPurchaseController.fifthWeekDays[i].weekday)){
                                              planPurchaseController.setSelectedDate(planPurchaseController.fifthWeekDays[i]);
                                            }
                                          },
                                          child:CalendarDateComponent_PlanPurchase (
                                              isSelected:isSameDay(planPurchaseController.selectedDate.value, planPurchaseController.fifthWeekDays[i]),
                                              isOffDay:isOffDay(planPurchaseController.fifthWeekDays[i].weekday),
                                              isSubscriptionDay:planPurchaseController.fifthWeekDays[i].isAfter(planPurchaseController.minimumPossibleDate.value)
                                                  && !isOffDay(planPurchaseController.fifthWeekDays[i].weekday),
                                              borderColor: Colors.transparent,
                                              isMonthDay:planPurchaseController.fifthWeekDays[i].month==
                                                  planPurchaseController.currentMonth.value.month,
                                              dateText:
                                              planPurchaseController.fifthWeekDays[i].day<10?
                                              '0${planPurchaseController.fifthWeekDays[i].day}':planPurchaseController.fifthWeekDays[i].day.toString()
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                              Container(
                                width: screenwidth,
                                height: 30 + (APPSTYLE_SpaceExtraSmall * 2),
                                child: Row(

                                  children: [
                                    for(var i=0;i<planPurchaseController.sixthWeekDays.length;i++)
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {
                                            if(planPurchaseController.sixthWeekDays[i].isAfter(planPurchaseController.minimumPossibleDate.value)
                                                &&  !isOffDay(planPurchaseController.sixthWeekDays[i].weekday)){
                                              planPurchaseController.setSelectedDate(planPurchaseController.sixthWeekDays[i]);
                                            }
                                          },
                                          child:CalendarDateComponent_PlanPurchase (
                                              isSelected:isSameDay(planPurchaseController.selectedDate.value, planPurchaseController.sixthWeekDays[i]),
                                              isOffDay:isOffDay(planPurchaseController.sixthWeekDays[i].weekday),
                                              isSubscriptionDay:planPurchaseController.sixthWeekDays[i].isAfter(planPurchaseController.minimumPossibleDate.value)
                                                  && !isOffDay(planPurchaseController.sixthWeekDays[i].weekday),
                                              borderColor: Colors.transparent,
                                              isMonthDay:planPurchaseController.sixthWeekDays[i].month==
                                                  planPurchaseController.currentMonth.value.month,
                                              dateText:
                                              planPurchaseController.sixthWeekDays[i].day<10?
                                              '0${planPurchaseController.sixthWeekDays[i].day}':planPurchaseController.sixthWeekDays[i].day.toString()
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),

                              addVerticalSpace(APPSTYLE_SpaceMedium),
                              Divider(),
                              addVerticalSpace(APPSTYLE_SpaceSmall),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        isSameDay(planPurchaseController.selectedDate.value,DefaultInvalidDate)?
                                        "select_starting_date".tr:
                                        getFormattedDate(planPurchaseController.selectedDate.value),

                                        style: getHeadlineMediumStyle(context).copyWith(
                                            color: APPSTYLE_PrimaryColor,
                                            fontWeight: APPSTYLE_FontWeightBold
                                        ),),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: APPSTYLE_SpaceLarge,vertical: APPSTYLE_SpaceSmall),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if(!planPurchaseController.isDateChecking.value &&
                          !isSameDay(planPurchaseController.selectedDate.value,DefaultInvalidDate)
                      ){
                        planPurchaseController.checkDateStatus();

                      }else{
                        if(isSameDay(planPurchaseController.selectedDate.value,DefaultInvalidDate)){
                          showSnackbar(context, "select_starting_date".tr, "error");
                        }
                      }
                      // Get.toNamed(AppRouteNames.planPurchaseCheckoutRoute);

                    },
                    style: getElevatedButtonStyle(context),
                    child:    planPurchaseController.isDateChecking.value
                        ? LoadingAnimationWidget.staggeredDotsWave(
                      color: APPSTYLE_BackgroundWhite,
                      size: 24,
                    ):Text("continue".tr,
                        style: getHeadlineMediumStyle(context).copyWith(
                            color: APPSTYLE_BackgroundWhite,
                            fontWeight: APPSTYLE_FontWeightBold),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
            ],
          ),
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

  isOffDay(int weekday) {
    List<int> days = planPurchaseController.currentSubscription.value.dayAvailability.keys.toList();
    if(!days.contains(weekday)){
      return false;
    }
    return  !planPurchaseController.currentSubscription.value.dayAvailability[weekday]!;
  }

}
