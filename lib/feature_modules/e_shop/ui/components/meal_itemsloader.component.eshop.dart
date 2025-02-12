import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MealItemsLoader_Eshop extends StatelessWidget {
  const MealItemsLoader_Eshop({super.key});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Padding(
      padding: APPSTYLE_LargePaddingHorizontal.copyWith(top: APPSTYLE_SpaceMedium),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 6,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            crossAxisSpacing: APPSTYLE_SpaceMedium,
            mainAxisExtent: screenheight * 0.3),
        itemBuilder: (context, indx) {
          return  Container(
            height: screenheight * .4,
            padding: APPSTYLE_MediumPaddingAll,
            color: APPSTYLE_Grey20,
            margin: EdgeInsets.only(bottom: APPSTYLE_SpaceMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Shimmer.fromColors(
                  baseColor: APPSTYLE_Grey20,
                  highlightColor: APPSTYLE_Grey40,
                  child: Container(
                      decoration:
                      APPSTYLE_BorderedContainerDarkMediumDecoration
                          .copyWith(
                          borderRadius:
                          BorderRadius.circular(
                              APPSTYLE_BorderRadiusSmall),
                          color:
                          APPSTYLE_BackgroundWhite,
                          border: Border.all(
                              color:
                              APPSTYLE_PrimaryColorBg,
                              width: 3)),
                      padding: APPSTYLE_SmallPaddingAll,
                      width: screenwidth * .3,
                      height: screenwidth * .3,
                      clipBehavior: Clip.hardEdge),
                ),
                addVerticalSpace(APPSTYLE_SpaceSmall),
                Shimmer.fromColors(
                  baseColor: APPSTYLE_Grey20,
                  highlightColor: APPSTYLE_Grey40,
                  child: Container(
                    decoration:
                    APPSTYLE_ShadowedContainerExtraSmallDecoration
                        .copyWith(
                        borderRadius:
                        BorderRadius.circular(
                            APPSTYLE_BlurRadiusSmall),
                        color: APPSTYLE_Grey20),
                    height: 20,
                    width: screenwidth * .25,
                  ),
                ),
                addVerticalSpace(APPSTYLE_SpaceSmall),
                Shimmer.fromColors(
                  baseColor: APPSTYLE_Grey20,
                  highlightColor: APPSTYLE_Grey40,
                  child: Container(
                    decoration:
                    APPSTYLE_ShadowedContainerExtraSmallDecoration
                        .copyWith(
                        borderRadius:
                        BorderRadius.circular(
                            APPSTYLE_BlurRadiusSmall),
                        color: APPSTYLE_Grey20),
                    height: 20,
                    width: screenwidth * .25,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
