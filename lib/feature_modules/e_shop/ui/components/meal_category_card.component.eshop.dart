import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';

class MealCategoryCardComponentEshop extends StatelessWidget {

  bool isSelected;
  String label;
  GestureTapCallback onClick;

  MealCategoryCardComponentEshop({super.key, required this.isSelected,  required this.label, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onClick,
      child: Container(
        alignment: Alignment.center,
        height: 36,
        padding: EdgeInsets.symmetric(vertical: APPSTYLE_SpaceExtraSmall,horizontal: APPSTYLE_SpaceMedium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusMedium),
          color: isSelected ? APPSTYLE_PrimaryColor : APPSTYLE_PrimaryColorBg,

        ),
        child: Text(
          label,
          style: getLabelLargeStyle(context).copyWith(
            color:  APPSTYLE_BackgroundWhite ,
          ),
        ),
      ),
    );
  }
}
