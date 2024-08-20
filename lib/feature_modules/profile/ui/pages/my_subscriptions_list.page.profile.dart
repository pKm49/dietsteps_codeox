 import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/calendar_utilities.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/date_conversion.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';

class MySubscriptionListPage_Profile extends StatefulWidget {
  const MySubscriptionListPage_Profile({super.key});

  @override
  State<MySubscriptionListPage_Profile> createState() =>
      _MySubscriptionListPage_ProfileState();
}

class _MySubscriptionListPage_ProfileState
    extends State<MySubscriptionListPage_Profile> {
  final sharedController = Get.find<SharedController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedController.getCustomerSubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        title: Row(
          children: [
            CustomBackButton(isPrimaryMode: false),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'subscriptions'.tr,
                  style: getHeadlineLargeStyle(context)
                      .copyWith(fontWeight: APPSTYLE_FontWeightBold),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
          child: Container(
        child: Obx(
          () => Container(
            child: Column(
              children: [
                Visibility(
                  visible:  sharedController.isUserDataFetching.value ||
                      sharedController.isSubscriptionsFetching.value,
                  child: Expanded(
                      child: ListView(
                    children: [
                          Container(
                          padding: APPSTYLE_MediumPaddingAll,
                          margin: APPSTYLE_LargePaddingAll,
                          decoration: APPSTYLE_ShadowedContainerMediumDecoration,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: APPSTYLE_Grey20,
                                    highlightColor: APPSTYLE_Grey40,
                                    child: Container(
                                      height: 30,
                                      width: screenwidth*.25,
                                      decoration:
                                      APPSTYLE_BorderedContainerExtraSmallDecoration
                                          .copyWith(
                                        border: null,
                                        color: APPSTYLE_Grey20,
                                        borderRadius: BorderRadius.circular(
                                            APPSTYLE_BlurRadiusSmall),
                                      ),),
                                  ),
                                  Shimmer.fromColors(
                                    baseColor: APPSTYLE_Grey20,
                                    highlightColor: APPSTYLE_Grey40,
                                    child: Container(
                                      height: 30,
                                      width: screenwidth*.25,
                                      decoration:
                                      APPSTYLE_BorderedContainerExtraSmallDecoration
                                          .copyWith(
                                        border: null,
                                        color: APPSTYLE_Grey20,
                                        borderRadius: BorderRadius.circular(
                                            APPSTYLE_BlurRadiusSmall),
                                      ),),
                                  ),
                                ],
                              ),
                              Divider(
                                color: const Color.fromARGB(
                                    255, 231, 231, 231),
                              ),
                              addVerticalSpace(APPSTYLE_SpaceSmall),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                alignment: WrapAlignment.start,
                                crossAxisAlignment:
                                WrapCrossAlignment.start,
                                children: List.generate(
                                  4,
                                      (index) => IntrinsicWidth(
                                    child: Shimmer.fromColors(
                                      baseColor: APPSTYLE_Grey20,
                                      highlightColor: APPSTYLE_Grey40,
                                      child: Container(
                                        height: 30,
                                        width: screenwidth*.2,
                                        decoration:
                                        APPSTYLE_BorderedContainerExtraSmallDecoration
                                            .copyWith(
                                          border: null,
                                          color: APPSTYLE_Grey20,
                                          borderRadius: BorderRadius.circular(
                                              APPSTYLE_BlurRadiusSmall),
                                        ),),
                                    ),
                                  ),
                                ),
                              ),
                              addVerticalSpace(APPSTYLE_SpaceSmall),
                              Divider(
                                color: APPSTYLE_Grey20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Shimmer.fromColors(
                                      baseColor: APPSTYLE_Grey20,
                                      highlightColor: APPSTYLE_Grey40,
                                      child: Container(
                                        height: 30,
                                        decoration:
                                        APPSTYLE_BorderedContainerExtraSmallDecoration
                                            .copyWith(
                                          border: null,
                                          color: APPSTYLE_Grey20,
                                          borderRadius: BorderRadius.circular(
                                              APPSTYLE_BlurRadiusSmall),
                                        ),),
                                    ),
                                  ),
                                ],
                              )
                          ]
                      ))
                    ],
                  )),
                ),
                Visibility(
                  visible: sharedController.mySubscriptions.isNotEmpty &&
                      !sharedController.isUserDataFetching.value && !sharedController.isSubscriptionsFetching.value ,
                  child: Expanded(
                    child: ListView.builder(
                        itemCount: sharedController.mySubscriptions.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: APPSTYLE_MediumPaddingAll,
                            margin: APPSTYLE_LargePaddingAll,
                            decoration:
                                APPSTYLE_ShadowedContainerMediumDecoration,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child:  FittedBox(
                                          alignment: Localizations.localeOf(context)
                                              .languageCode
                                              .toString() ==
                                              'ar'
                                              ?  Alignment.centerRight: Alignment.centerLeft,
                                      fit:BoxFit.scaleDown,
                                      child: Text(
                                          Localizations.localeOf(context)
                                              .languageCode
                                              .toString() ==
                                              'ar'
                                              ? sharedController
                                              .mySubscriptions[index]
                                              .planArabicName
                                              : sharedController
                                              .mySubscriptions[index].planName,
                                          textAlign: Localizations.localeOf(context)
                                              .languageCode
                                              .toString() ==
                                              'ar'
                                              ? TextAlign.end:TextAlign.start,
                                          style: getHeadlineMediumStyle(context)
                                              .copyWith(
                                              fontWeight:
                                              APPSTYLE_FontWeightBold)),
                                    )),
                                    Container(
                                      decoration: APPSTYLE_BorderedContainerExtraSmallDecoration.copyWith(
                                        borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall*.5),

                                        color:  sharedController.mySubscriptions[index].status=="in_progress"?APPSTYLE_WhatsappGreen:
                                        sharedController.mySubscriptions[index].status=="paid"?APPSTYLE_Black:APPSTYLE_PrimaryColor,
                                      ),
                                      padding: APPSTYLE_ExtraSmallPaddingAll.copyWith(left: APPSTYLE_SpaceSmall,right: APPSTYLE_SpaceSmall),
                                      child: Text(sharedController.mySubscriptions[index].status.split("_").join(" ").toString().toUpperCase(),
                                      style: getLabelLargeStyle(context).copyWith(color: APPSTYLE_BackgroundWhite) ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: APPSTYLE_Grey20,
                                ),
                                addVerticalSpace(APPSTYLE_SpaceSmall),
                                Container(
                                  width: screenwidth -
                                      ((APPSTYLE_SpaceLarge * 2) +
                                          (APPSTYLE_SpaceMedium * 2)),
                                  child: Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    children: List.generate(
                                      sharedController.mySubscriptions[index]
                                          .mealsConfig.length,
                                      (indx) => IntrinsicWidth(
                                        child: Container(
                                          decoration:
                                              APPSTYLE_BorderedContainerSmallDecoration,
                                          padding: APPSTYLE_SmallPaddingAll,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                Localizations.localeOf(context)
                                                            .languageCode
                                                            .toString() ==
                                                        'ar'
                                                    ? sharedController
                                                        .mySubscriptions[index]
                                                        .mealsConfig[indx]
                                                        .arabicName
                                                    : sharedController
                                                        .mySubscriptions[index]
                                                        .mealsConfig[indx]
                                                        .name,
                                                style:
                                                    getBodyMediumStyle(context),
                                              ),
                                              const SizedBox(width: 5),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: APPSTYLE_PrimaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                padding: APPSTYLE_SmallPaddingAll
                                                    .copyWith(
                                                        top:
                                                            APPSTYLE_SpaceExtraSmall,
                                                        bottom:
                                                            APPSTYLE_SpaceExtraSmall),
                                                child: Text(
                                                  sharedController
                                                      .mySubscriptions[index]
                                                      .mealsConfig[indx]
                                                      .itemCount.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                addVerticalSpace(APPSTYLE_SpaceSmall),
                                Divider(
                                  color: APPSTYLE_Grey20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.calendar_month,size: APPSTYLE_FontSize20,),
                                    addHorizontalSpace(APPSTYLE_SpaceExtraSmall),
                                    Expanded(
                                      child: FittedBox(
                                        alignment: Alignment.centerLeft,
                                        fit:BoxFit.scaleDown,
                                        child: Text(
                                          getFormattedSubscriptionDuration(sharedController
                                              .mySubscriptions[index].fromDate, sharedController
                                              .mySubscriptions[index].toDate) ,
                                          style: getBodyMediumStyle(context),textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
                Visibility(
                  visible: sharedController.mySubscriptions.isEmpty &&
                      !sharedController.isUserDataFetching.value && !sharedController.isSubscriptionsFetching.value ,
                  child: Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
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
                      addVerticalSpace(APPSTYLE_SpaceLarge),
                      Text("no_subscription".tr,
                          style: getHeadlineMediumStyle(context)),
                    ],
                  )),
                )
              ],
            ),
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
}
