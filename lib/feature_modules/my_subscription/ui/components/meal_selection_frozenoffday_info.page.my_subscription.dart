import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class MealSelectionFrozenOffDayInfoPage_MySubscriptions extends StatelessWidget {
  bool isFrozen;
    MealSelectionFrozenOffDayInfoPage_MySubscriptions({super.key,required this.isFrozen});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Padding(
      padding: APPSTYLE_LargePaddingAll,
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
                  child: Icon(isFrozen?Ionicons.pause_circle_outline:Ionicons.close_circle_outline,
                      size: screenwidth * .15,
                      color: APPSTYLE_Grey80),
                ),
              )
            ],
          ),
          addVerticalSpace(APPSTYLE_SpaceLarge),
          Text(isFrozen?"freezed".tr:"off-day".tr,
              textAlign: TextAlign.center,
              style: getHeadlineMediumStyle(context)),
        ],
      ),
    );
  }
}
