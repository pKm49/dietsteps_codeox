 
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/valid_subscription_day_status.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class MealCalendarDateComponent_MySubscription extends StatelessWidget {

  Color borderColor;
  DateTime dateTime;
  String dateText;
  String status;
  bool isSelected;
  bool isMonthDay;

  bool isSubscriptionDay;
  MealCalendarDateComponent_MySubscription({super.key,required this.isSubscriptionDay,required this.isSelected,required this.isMonthDay,
    required this.borderColor ,  required this.status , required this.dateTime ,   required this.dateText});


  @override
  Widget build(BuildContext context) {

    DateTime threeDaysBefore = DateTime.now().add(Duration(days: -3));

    return Container(
        height: 55 + (APPSTYLE_SpaceExtraSmall * 2),
        decoration:   BoxDecoration(
            borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
            color:(isSelected && isMonthDay) ?APPSTYLE_PrimaryColor:isMonthDay?APPSTYLE_Grey20:APPSTYLE_BackgroundWhite
        ),
        margin: EdgeInsets.only(right:APPSTYLE_SpaceExtraSmall ),
        padding: APPSTYLE_ExtraSmallPaddingAll,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  dateText,
                  textAlign: TextAlign.center,
                  style: getLabelLargeStyle(context)
                      .copyWith(
                      color:isSelected?APPSTYLE_BackgroundWhite:
                      (isSubscriptionDay && isMonthDay)? APPSTYLE_PrimaryColor:
                      isMonthDay ? APPSTYLE_Grey80:APPSTYLE_BackgroundWhite
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            Visibility(
                visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.offDay ) &&  (isMonthDay && isSubscriptionDay) ,
                child: SvgPicture.asset(ASSETS_OFFDAY,height: 13,color:isSelected?APPSTYLE_BackgroundWhite: APPSTYLE_GuideRed)
            ),
            Visibility(
              visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.offDay ) &&  (isMonthDay && isSubscriptionDay) ,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("off-day_single".tr,style: getLabelSmallStyle(context).copyWith(
                  color:isSelected?APPSTYLE_BackgroundWhite: APPSTYLE_GuideRed
                ),),
              ),
            ),

            Visibility(
                visible: status==VALIDSUBSCRIPTIONDAY_STATUS.delivered &&
                    dateTime.isBefore(threeDaysBefore)
                    &&  (isMonthDay && isSubscriptionDay) ,
                child:   Icon(Ionicons.star,color: isSelected?APPSTYLE_BackgroundWhite:APPSTYLE_GuideRed,size: 15)
            ),
            Visibility(
              visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.delivered ) &&
                  dateTime.isBefore(threeDaysBefore) &&  (isMonthDay && isSubscriptionDay) ,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("rate".tr,style: getLabelSmallStyle(context).copyWith(
                    color:isSelected?APPSTYLE_BackgroundWhite: APPSTYLE_GuideRed
                ),),
              ),
            ),
            Visibility(
                visible:  status==VALIDSUBSCRIPTIONDAY_STATUS.delivered  && dateTime.isAfter(threeDaysBefore)&&  (isMonthDay && isSubscriptionDay) ,
                child: SvgPicture.asset(ASSETS_FOODTRUCK,height: 13,color: isSelected?APPSTYLE_BackgroundWhite:APPSTYLE_WhatsappGreen)
            ),
            Visibility(
              visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.delivered )  && dateTime.isAfter(threeDaysBefore)&&  (isMonthDay && isSubscriptionDay) ,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("delivered_single".tr,style: getLabelSmallStyle(context).copyWith(
                    color:isSelected?APPSTYLE_BackgroundWhite: APPSTYLE_WhatsappGreen
                ),),
              ),
            ),

            Visibility(
                visible: status==VALIDSUBSCRIPTIONDAY_STATUS.freezed  &&  (isMonthDay && isSubscriptionDay)  ,
                child: SvgPicture.asset(ASSETS_PAUSE,height: 13,color: isSelected?APPSTYLE_BackgroundWhite:APPSTYLE_GuideOrange)
            ),
            Visibility(
              visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.freezed ) &&  (isMonthDay && isSubscriptionDay) ,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("freezed_single".tr,style: getLabelSmallStyle(context).copyWith(
                    color:isSelected?APPSTYLE_BackgroundWhite: APPSTYLE_GuideOrange
                ),),
              ),
            ),
            Visibility(
                visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.mealSelected ) &&  (isMonthDay && isSubscriptionDay) ,
                child: SvgPicture.asset(ASSETS_FOODPLATE,height: 13,color: isSelected?APPSTYLE_BackgroundWhite:APPSTYLE_WhatsappGreen)
            ),
            Visibility(
              visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.mealSelected ) &&  (isMonthDay && isSubscriptionDay) ,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("meal-selected_single".tr,style: getLabelSmallStyle(context).copyWith(
                    color: isSelected?APPSTYLE_BackgroundWhite:APPSTYLE_WhatsappGreen
                ),),
              ),
            ),
            Visibility(
              visible: status==VALIDSUBSCRIPTIONDAY_STATUS.mealNotSelected  &&  (isMonthDay && isSubscriptionDay)  ,
              child: SvgPicture.asset(ASSETS_SELECTHAND,height: 13,color: isSelected?APPSTYLE_BackgroundWhite:APPSTYLE_PrimaryColor,)
            ),
            Visibility(
              visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.mealNotSelected ) &&  (isMonthDay && isSubscriptionDay) ,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("meal-not-selected_single".tr,style: getLabelSmallStyle(context).copyWith(
                    color: isSelected?APPSTYLE_BackgroundWhite:APPSTYLE_PrimaryColor
                ),),
              ),
            ),
          ],
        ));
  }
}
