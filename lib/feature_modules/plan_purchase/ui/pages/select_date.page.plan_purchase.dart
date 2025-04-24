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
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SelectInitialDatePage_PlanPurchase extends StatefulWidget {
  const SelectInitialDatePage_PlanPurchase({super.key});

  @override
  State<SelectInitialDatePage_PlanPurchase> createState() => _SelectInitialDatePage_PlanPurchaseState();
}

class _SelectInitialDatePage_PlanPurchaseState extends State<SelectInitialDatePage_PlanPurchase> {
  final planPurchaseController = Get.find<PlanPurchaseController>();

  // Helper method for date selection logic
  bool isDateSelectable(DateTime date) {
    final kuwaitTimeZone = tz.getLocation('Asia/Kuwait');

    // Create dates at midnight in Kuwait timezone
    final selectedDateInKuwait = tz.TZDateTime(
      kuwaitTimeZone,
      date.year,
      date.month,
      date.day,
    );

    final minDateInKuwait = tz.TZDateTime(
      kuwaitTimeZone,
      planPurchaseController.minimumPossibleDate.value.year,
      planPurchaseController.minimumPossibleDate.value.month,
      planPurchaseController.minimumPossibleDate.value.day,
    );

    print("Checking date selectability:");
    print("Date to check: $date");
    print("In Kuwait timezone: $selectedDateInKuwait");
    print("Minimum date: $minDateInKuwait");

    return (selectedDateInKuwait.isAtSameMomentAs(minDateInKuwait) ||
        selectedDateInKuwait.isAfter(minDateInKuwait)) &&
        !isOffDay(date.weekday,date);
  }

  void handleDateTap(DateTime date) {
    final kuwaitTimeZone = tz.getLocation('Asia/Kuwait');

    // Create dates at midnight in Kuwait timezone
    final selectedDateInKuwait = tz.TZDateTime(
      kuwaitTimeZone,
      date.year,
      date.month,
      date.day,
    );

    final minDateInKuwait = tz.TZDateTime(
      kuwaitTimeZone,
      planPurchaseController.minimumPossibleDate.value.year,
      planPurchaseController.minimumPossibleDate.value.month,
      planPurchaseController.minimumPossibleDate.value.day,
    );

    print("🔍 Handling date tap:");
    print("Selected date: $date");
    print("In Kuwait timezone: $selectedDateInKuwait");
    print("Minimum date: $minDateInKuwait");

    if ((selectedDateInKuwait.isAtSameMomentAs(minDateInKuwait) ||
        selectedDateInKuwait.isAfter(minDateInKuwait)) &&
        !isOffDay(date.weekday,date)) {
      print("✅ Date is valid, setting selected date");
      // Pass the original date to maintain correct day
      planPurchaseController.setSelectedDate(date);
    } else {
      print("❌ Date is invalid or is an off day");
      print("Is before min date: ${selectedDateInKuwait.isBefore(minDateInKuwait)}");
      print("Is off day: ${isOffDay(date.weekday,date)}");
    }
  }

  // Build calendar day component
  Widget buildCalendarDay(DateTime date, bool isMonthDay) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () => handleDateTap(date),
        child: CalendarDateComponent_PlanPurchase(
            isSelected: isSameDay(planPurchaseController.selectedDate.value, date),
            isOffDay: isOffDay(date.weekday,date),
            isSubscriptionDay: isDateSelectable(date),
            borderColor: Colors.transparent,
            isMonthDay: isMonthDay,
            dateText: date.day < 10 ? '0${date.day}' : date.day.toString()
        ),
      ),
    );
  }

  // Build week row
  Widget buildWeekRow(List<DateTime> weekDays) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 30 + (APPSTYLE_SpaceExtraSmall * 2),
      child: Row(
        children: weekDays.map((date) => buildCalendarDay(
            date,
            date.month == planPurchaseController.currentMonth.value.month
        )).toList(),
      ),
    );
  }

  // Build week day header
  Widget buildWeekDayHeader(String day) {
    return Expanded(
      flex: 1,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
            day.tr,
            textAlign: TextAlign.center,
            style: getBodyMediumStyle(context).copyWith(color: APPSTYLE_Grey80)
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: APPSTYLE_PrimaryColorBg,
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        title: Row(
          children: [
            CustomBackButton(isPrimaryMode: false),
          ],
        ),
        actions: [],
      ),
      body: SafeArea(
        child: Container(
          child: Obx(() => Column(
            children: [
              CustomCurveShapeComponent_Shared(
                subtitle: '',
                color: APPSTYLE_PrimaryColorBg,
                title: "select_starting_date".tr,
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onHorizontalDragEnd: (DragEndDetails details) {
                          if (details.primaryVelocity! < 0) {
                            Localizations.localeOf(context).languageCode == 'ar'
                                ? planPurchaseController.previousMonth()
                                : planPurchaseController.nextMonth();
                          } else if (details.primaryVelocity! > 0) {
                            Localizations.localeOf(context).languageCode == 'ar'
                                ? planPurchaseController.nextMonth()
                                : planPurchaseController.previousMonth();
                          }
                        },
                        child: Container(
                          decoration: APPSTYLE_ShadowedContainerSmallDecoration.copyWith(
                              boxShadow: [
                                const BoxShadow(
                                  color: APPSTYLE_Grey80Shadow24,
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 2,
                                ),
                              ],
                              border: Border.all(color: Colors.transparent, width: .2),
                              color: APPSTYLE_Grey20
                          ),
                          margin: APPSTYLE_LargePaddingAll.copyWith(top: 0),
                          padding: APPSTYLE_MediumPaddingAll,
                          width: screenwidth - (APPSTYLE_SpaceLarge * 2),
                          child: ListView(
                            children: [
                              // Month navigation
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () => planPurchaseController.previousMonth(),
                                    child: Container(
                                      padding: APPSTYLE_ExtraSmallPaddingAll,
                                      decoration: APPSTYLE_BorderedContainerExtraSmallDecoration
                                          .copyWith(color: APPSTYLE_BackgroundWhite),
                                      child: Icon(
                                          Localizations.localeOf(context).languageCode == 'ar'
                                              ? Ionicons.chevron_forward
                                              : Ionicons.chevron_back,
                                          color: Colors.black
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                        child: Text(
                                          getFormattedCurrentMonth(planPurchaseController.currentMonth.value),
                                          textAlign: TextAlign.center,
                                          style: getHeadlineMediumStyle(context).copyWith(
                                              color: APPSTYLE_PrimaryColorBg,
                                              fontWeight: APPSTYLE_FontWeightBold
                                          ),
                                        ),
                                      )
                                  ),
                                  InkWell(
                                    onTap: () => planPurchaseController.nextMonth(),
                                    child: Container(
                                      padding: APPSTYLE_ExtraSmallPaddingAll,
                                      decoration: APPSTYLE_BorderedContainerExtraSmallDecoration
                                          .copyWith(color: APPSTYLE_BackgroundWhite),
                                      child: Icon(
                                          Localizations.localeOf(context).languageCode == 'ar'
                                              ? Ionicons.chevron_back
                                              : Ionicons.chevron_forward,
                                          color: Colors.black
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              addVerticalSpace(APPSTYLE_SpaceLarge),

                              // Week day headers
                              Container(
                                width: screenwidth,
                                height: 35,
                                child: Row(
                                  children: [
                                    buildWeekDayHeader('sun'),
                                    buildWeekDayHeader('mon'),
                                    buildWeekDayHeader('tue'),
                                    buildWeekDayHeader('wed'),
                                    buildWeekDayHeader('thu'),
                                    buildWeekDayHeader('fri'),
                                    buildWeekDayHeader('sat'),
                                  ],
                                ),
                              ),
                              addVerticalSpace(APPSTYLE_SpaceSmall),

                              // Calendar weeks
                              buildWeekRow(planPurchaseController.firstWeekDays),
                              addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                              buildWeekRow(planPurchaseController.secondWeekDays),
                              addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                              buildWeekRow(planPurchaseController.thirdWeekDays),
                              addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                              buildWeekRow(planPurchaseController.fourthWeekDays),
                              addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                              buildWeekRow(planPurchaseController.fifthWeekDays),
                              addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                              buildWeekRow(planPurchaseController.sixthWeekDays),

                              addVerticalSpace(APPSTYLE_SpaceMedium),
                              Divider(),
                              addVerticalSpace(APPSTYLE_SpaceSmall),

                              // Selected date display
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        isSameDay(planPurchaseController.selectedDate.value, DefaultInvalidDate)
                                            ? "select_starting_date".tr
                                            : getFormattedDate(planPurchaseController.selectedDate.value),
                                        style: getHeadlineMediumStyle(context).copyWith(
                                            color: APPSTYLE_PrimaryColor,
                                            fontWeight: APPSTYLE_FontWeightBold
                                        ),
                                      ),
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

              // Continue button
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: APPSTYLE_SpaceLarge,
                    vertical: APPSTYLE_SpaceSmall
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!planPurchaseController.isDateChecking.value &&
                          !isSameDay(planPurchaseController.selectedDate.value, DefaultInvalidDate)) {
                        planPurchaseController.checkDateStatus();
                      } else {
                        if (isSameDay(planPurchaseController.selectedDate.value, DefaultInvalidDate)) {
                          showSnackbar(context, "select_starting_date".tr, "error");
                        }
                      }
                    },
                    style: getElevatedButtonStyle(context),
                    child: planPurchaseController.isDateChecking.value
                        ? LoadingAnimationWidget.staggeredDotsWave(
                      color: APPSTYLE_BackgroundWhite,
                      size: 24,
                    )
                        : Text(
                        "continue".tr,
                        style: getHeadlineMediumStyle(context).copyWith(
                            color: APPSTYLE_BackgroundWhite,
                            fontWeight: APPSTYLE_FontWeightBold
                        ),
                        textAlign: TextAlign.center
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  // Helper method for off days
  isOffDay(int weekday,DateTime dateTime) {
    if (dateTime.year == 2025) {
      if ((dateTime.month == 3 && dateTime.day == 30)) {
        return true;
      }
    }
    List<int> days = planPurchaseController.currentSubscription.value.dayAvailability.keys.toList();
    if(!days.contains(weekday)){
      return false;
    }
    return  !planPurchaseController.currentSubscription.value.dayAvailability[weekday]!;
  }
}