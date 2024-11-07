import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MealCategoryCardLoaderComponentEshop extends StatelessWidget {

  MealCategoryCardLoaderComponentEshop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 36,
      padding: EdgeInsets.symmetric(vertical: APPSTYLE_SpaceSmall,horizontal: APPSTYLE_SpaceLarge),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusMedium),
        color:  APPSTYLE_BackgroundWhite,

      ),
      child:Shimmer.fromColors(
        baseColor: APPSTYLE_BackgroundWhite,
        highlightColor: APPSTYLE_Grey20,
        child: Container(
            width: 120,
            height: 20,
            color: APPSTYLE_Grey20
        ),
      )  ,
    );
  }
}
