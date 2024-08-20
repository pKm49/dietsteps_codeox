import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MealSelectionTitleLoader extends StatelessWidget {
  const MealSelectionTitleLoader({super.key});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Padding(
      padding: APPSTYLE_LargePaddingHorizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Shimmer.fromColors(
            baseColor: APPSTYLE_Grey20,
            highlightColor: APPSTYLE_Grey40,
            child: Container(
              decoration:
              APPSTYLE_BorderedContainerExtraSmallDecoration
                  .copyWith(color: APPSTYLE_Grey20),
              height: 30,
              width: screenwidth * .3,
            ),
          ),
          Shimmer.fromColors(
            baseColor: APPSTYLE_Grey20,
            highlightColor: APPSTYLE_Grey40,
            child: Container(
              decoration:
              APPSTYLE_BorderedContainerExtraSmallDecoration
                  .copyWith(color: APPSTYLE_Grey20),
              height: 30,
              width: screenwidth * .2,
            ),
          ),
        ],
      ),
    );
  }
}
