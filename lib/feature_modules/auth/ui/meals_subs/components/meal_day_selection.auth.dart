 
import 'package:dietsteps/feature_modules/my_subscription/services/meal_selection.helper.services.dart';
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

class MealDaySelectionComponent_Auth extends StatelessWidget {

  String day;
  int index;
  bool isSelected;

  MealDaySelectionComponent_Auth({super.key,
    required this.isSelected, 
    required this.index,
    required this.day});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    DateTime threeDaysBefore = DateTime.now().add(Duration(days: -3));

    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: isSelected
            ? APPSTYLE_PrimaryColor
            :  APPSTYLE_BackgroundOffWhite,
        borderRadius:
        BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
        border: Border.all(color: APPSTYLE_Grey60, width: .4),
      ),
      width: screenwidth * .14,
      padding: APPSTYLE_ExtraSmallPaddingAll.copyWith(
          top: APPSTYLE_SpaceSmall, bottom: APPSTYLE_SpaceSmall),
      margin: APPSTYLE_ExtraSmallPaddingHorizontal.copyWith(bottom: APPSTYLE_SpaceExtraSmall),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  day.toString(),
                  textAlign: TextAlign.center,
                  style: getLabelLargeStyle(context)
                      .copyWith(
                      color: isSelected?APPSTYLE_BackgroundWhite:
                       APPSTYLE_Grey60
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "0${index}",
                  textAlign: TextAlign.center,
                  style: getHeadlineLargeStyle(context)
                      .copyWith(
                      color: isSelected?APPSTYLE_BackgroundWhite:
                       APPSTYLE_Grey60
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
