 
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/valid_subscription_day_status.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/calendar_utilities.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class MealCalendarDateMealSelectionComponent_MySubscription extends StatelessWidget {
 
  DateTime date;
  String status;
  bool isSelected; 
  
  MealCalendarDateMealSelectionComponent_MySubscription({super.key,
    required this.isSelected, 
    required this.status ,   required this.date});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      height: 100 ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getDayNameByDate(date),
            style: getLabelSmallStyle(context).copyWith(
                color: APPSTYLE_Grey80),
          ),
          addVerticalSpace(APPSTYLE_SpaceExtraSmall),
          Container(
            height: 75,
            decoration: BoxDecoration(
              color: isSelected
                  ? APPSTYLE_GuideRed
                  :  APPSTYLE_BackgroundOffWhite,
              borderRadius:
              BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
              border: Border.all(color: APPSTYLE_Grey60, width: .4),
            ),
            width: screenwidth * .14,
            padding: APPSTYLE_ExtraSmallPaddingAll.copyWith(
                top: APPSTYLE_SpaceSmall, bottom: APPSTYLE_SpaceSmall),
            margin: APPSTYLE_ExtraSmallPaddingHorizontal,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        date.day.toString(),
                        textAlign: TextAlign.center,
                        style: getLabelLargeStyle(context)
                            .copyWith(
                            color: isSelected?APPSTYLE_BackgroundWhite:
                            status==VALIDSUBSCRIPTIONDAY_STATUS.offDay?APPSTYLE_GuideRed:
                            status==VALIDSUBSCRIPTIONDAY_STATUS.freezed?APPSTYLE_GuideOrange:
                            status==VALIDSUBSCRIPTIONDAY_STATUS.delivered?APPSTYLE_GuideGreen:
                            status==VALIDSUBSCRIPTIONDAY_STATUS.mealNotSelected?APPSTYLE_PrimaryColor:
                             APPSTYLE_WhatsappGreen
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  Visibility(
                      visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.offDay ) ,
                      child:  Padding(
                        padding: const EdgeInsets.only(bottom: APPSTYLE_SpaceExtraSmall),
                        child: SvgPicture.asset(ASSETS_OFFDAY,height: 13,color: isSelected?APPSTYLE_BackgroundWhite: APPSTYLE_GuideRed),
                      )
                  ),
                  Visibility(
                    visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.offDay ) ,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("off-day_single".tr,style: getLabelSmallStyle(context).copyWith(
                          color: isSelected?APPSTYLE_BackgroundWhite: APPSTYLE_GuideRed
                      ),),
                    ),
                  ),

                  Visibility(
                      visible:  status==VALIDSUBSCRIPTIONDAY_STATUS.delivered  ,
                      child:  Padding(
                        padding: const EdgeInsets.only(bottom: APPSTYLE_SpaceExtraSmall),
                        child: SvgPicture.asset(ASSETS_FOODTRUCK,height: 13,color: isSelected?APPSTYLE_BackgroundWhite: APPSTYLE_WhatsappGreen),
                      )
                  ),
                  Visibility(
                    visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.delivered ) ,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("delivered_single".tr,style: getLabelSmallStyle(context).copyWith(
                          color: isSelected?APPSTYLE_BackgroundWhite: APPSTYLE_WhatsappGreen
                      ),),
                    ),
                  ),

                  Visibility(
                      visible: status==VALIDSUBSCRIPTIONDAY_STATUS.freezed   ,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: APPSTYLE_SpaceExtraSmall),
                        child: SvgPicture.asset(ASSETS_PAUSE,height: 13,color: isSelected?APPSTYLE_BackgroundWhite: APPSTYLE_GuideOrange),
                      )
                  ),
                  Visibility(
                    visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.freezed ) ,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("freezed_single".tr,style: getLabelSmallStyle(context).copyWith(
                          color:  isSelected?APPSTYLE_BackgroundWhite:APPSTYLE_GuideOrange
                      ),),
                    ),
                  ),
                  Visibility(
                      visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.mealSelected ) ,
                      child:  Padding(
                        padding: const EdgeInsets.only(bottom: APPSTYLE_SpaceExtraSmall),
                        child: SvgPicture.asset(ASSETS_FOODPLATE,height: 13,color:  isSelected?APPSTYLE_BackgroundWhite:APPSTYLE_WhatsappGreen),
                      )
                  ),
                  Visibility(
                    visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.mealSelected ) ,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("meal-selected_single".tr,style: getLabelSmallStyle(context).copyWith(
                          color:  isSelected?APPSTYLE_BackgroundWhite:APPSTYLE_WhatsappGreen
                      ),),
                    ),
                  ),
                  Visibility(
                      visible: status==VALIDSUBSCRIPTIONDAY_STATUS.mealNotSelected   ,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: APPSTYLE_SpaceExtraSmall),
                        child: SvgPicture.asset(ASSETS_SELECTHAND,height: 13,color:  isSelected?APPSTYLE_BackgroundWhite:APPSTYLE_PrimaryColor,),
                      )
                  ),
                  Visibility(
                    visible: (status==VALIDSUBSCRIPTIONDAY_STATUS.mealNotSelected ) ,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("meal-not-selected_single".tr,style: getLabelSmallStyle(context).copyWith(
                          color:  isSelected?APPSTYLE_BackgroundWhite:APPSTYLE_PrimaryColor
                      ),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
