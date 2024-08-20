import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
 import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SubscriptionPlanCardLoaderComponent_PlanPurchase extends StatelessWidget {
  bool isSelected;
  SubscriptionPlanCardLoaderComponent_PlanPurchase({super.key,required this.isSelected});

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;


    return Container(
      decoration:
      APPSTYLE_BorderedContainerSmallDecoration.copyWith(
          color: Colors.transparent,
          border: Border.all(
              color:isSelected? APPSTYLE_PrimaryColor:Colors.transparent, width: 2)),
      height: screenheight * .25,
      padding: APPSTYLE_ExtraSmallPaddingAll,
      margin: EdgeInsets.only(bottom: APPSTYLE_SpaceSmall,left: APPSTYLE_SpaceLarge,right: APPSTYLE_SpaceLarge),
      child: Container(
        decoration: APPSTYLE_BorderedContainerSmallDecoration
            .copyWith(
          color: APPSTYLE_Black,
          boxShadow: APPSTYLE_ContainerShadow
        ),
        padding: APPSTYLE_MediumPaddingAll,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Shimmer.fromColors(
                    baseColor: APPSTYLE_Grey20,
                    highlightColor: APPSTYLE_Grey40,
                    child: Container(
                      decoration:
                      APPSTYLE_BorderedContainerExtraSmallDecoration
                          .copyWith(color: APPSTYLE_Grey20),
                      width: screenwidth*.3,
                      height: 25,
                    )
                ),
                Shimmer.fromColors(
                    baseColor: APPSTYLE_Grey20,
                    highlightColor: APPSTYLE_Grey40,
                    child: Container(
                      decoration:
                      APPSTYLE_BorderedContainerExtraSmallDecoration
                          .copyWith(color: APPSTYLE_Grey20),
                      width: screenwidth*.2,
                      height: 25,
                    )
                ),
              ],
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.end,
              crossAxisAlignment:
              CrossAxisAlignment.end,
              children: [

                Shimmer.fromColors(
                    baseColor: APPSTYLE_Grey20,
                    highlightColor: APPSTYLE_Grey40,
                    child: Container(
                      decoration:
                      APPSTYLE_BorderedContainerExtraSmallDecoration
                          .copyWith(color: APPSTYLE_Grey20),
                      width: screenwidth*.2,
                      height: 35,
                    )
                ),
              ],
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                    baseColor: APPSTYLE_Grey20,
                    highlightColor: APPSTYLE_Grey40,
                    child: Container(
                      decoration:
                      APPSTYLE_BorderedContainerExtraSmallDecoration
                          .copyWith(color: APPSTYLE_Grey20),
                      width: screenwidth*.2,
                      height: 25,
                    )
                ),
                Shimmer.fromColors(
                    baseColor: APPSTYLE_Grey20,
                    highlightColor: APPSTYLE_Grey40,
                    child: Container(
                      decoration:
                      APPSTYLE_BorderedContainerExtraSmallDecoration
                          .copyWith(color: APPSTYLE_Grey20),
                      width: screenwidth*.2,
                      height: 25,
                    )
                ),

              ],
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                    baseColor: APPSTYLE_Grey20,
                    highlightColor: APPSTYLE_Grey40,
                    child: Container(
                      decoration:
                      APPSTYLE_BorderedContainerExtraSmallDecoration
                          .copyWith(color: APPSTYLE_Grey20),
                      width: screenwidth*.2,
                      height: 25,
                    )
                ),
                Shimmer.fromColors(
                    baseColor: APPSTYLE_Grey20,
                    highlightColor: APPSTYLE_Grey40,
                    child: Container(
                      decoration:
                      APPSTYLE_BorderedContainerExtraSmallDecoration
                          .copyWith(color: APPSTYLE_Grey20),
                      width: screenwidth*.2,
                      height: 25,
                    )
                ),

              ],
            ),
          ],
        ),

      ),
    );
  }

}
