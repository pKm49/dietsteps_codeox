
import 'package:dietsteps/feature_modules/auth/controllers/meals.controller.auth.dart';
import 'package:dietsteps/feature_modules/e_shop/controllers/controller.eshop.dart';
import 'package:dietsteps/feature_modules/my_subscription/services/meal_selection.helper.services.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class MealsDetailsPage_Eshop extends StatefulWidget {
  const MealsDetailsPage_Eshop({super.key});

  @override
  State<MealsDetailsPage_Eshop> createState() => _MealsDetailsPage_EshopState();
}

class _MealsDetailsPage_EshopState extends State<MealsDetailsPage_Eshop> {

  final mealsController = Get.find<EshopController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mealsController.currentMeal.value.id==-1){
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(mealsController.currentMeal.value.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: APPSTYLE_LargePaddingHorizontal.copyWith(
                            top: APPSTYLE_SpaceLarge * 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomBackButton( ),
                          ],
                        ),
                      ),
                      Container(
                        width: screenwidth,
                        padding: APPSTYLE_MediumPaddingVertical,
                        decoration: BoxDecoration(
                          border: Border.all(color: APPSTYLE_BackgroundWhite, width: 0),
                          color: APPSTYLE_BackgroundWhite,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(APPSTYLE_BorderRadiusLarge),
                              topRight: Radius.circular(APPSTYLE_BorderRadiusLarge)),
                        ),

                      )
                    ],
                  ),
                )),
            Expanded(
                flex: 4,
                child: Container(
                  width: screenwidth,
                  color: APPSTYLE_BackgroundWhite,
                  child: ListView(
                    children: [
                      Padding(
                        padding: APPSTYLE_LargePaddingHorizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Localizations.localeOf(
                                      context)
                                      .languageCode
                                      .toString() ==
                                      'ar'
                                      ?
                                  mealsController.currentMeal.value.arabicName:
                                  mealsController.currentMeal.value.name,
                                    style: getHeadlineLargeStyle(context)
                                        .copyWith(color: APPSTYLE_Grey80),
                                  ),
                                  addVerticalSpace(APPSTYLE_SpaceSmall),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Icon(Ionicons.flame_outline,
                                                  color: APPSTYLE_GuideRed,
                                                  size: APPSTYLE_FontSize16),
                                              addHorizontalSpace(APPSTYLE_SpaceExtraSmall),
                                              Text(
                                                '${mealsController.currentMeal.value.calories} ${'calories'.tr}',
                                                style: getLabelLargeStyle(context)
                                                    .copyWith(color: APPSTYLE_Grey60),
                                              )
                                            ],
                                          )),
                                      Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Icon(Ionicons.star,
                                                  color: APPSTYLE_GuideYellow,
                                                  size: APPSTYLE_FontSize16),
                                              addHorizontalSpace(APPSTYLE_SpaceExtraSmall),
                                              Text(
                                                '${mealsController.currentMeal.value.rating} (${mealsController.currentMeal.value.rating_count}) ',
                                                style: getLabelLargeStyle(context)
                                                    .copyWith(color: APPSTYLE_Grey60),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      addVerticalSpace(APPSTYLE_SpaceLarge),
                      Padding(
                        padding: APPSTYLE_LargePaddingHorizontal,
                        child: Row(
                          children: [
                            Expanded(
                              child:Container(
                                decoration: BoxDecoration(
                                    color: APPSTYLE_PrimaryColorBg,
                                    borderRadius:
                                    BorderRadius.circular(APPSTYLE_BorderRadiusLarge)),
                                margin: EdgeInsets.only(right: APPSTYLE_SpaceMedium),
                                padding: APPSTYLE_ExtraSmallPaddingAll.copyWith(
                                    left: APPSTYLE_SpaceSmall, right: APPSTYLE_SpaceSmall),
                                child: Text('${mealsController.currentMeal.value.carbs} ${'carbs'.tr}',
                                  style: getLabelLargeStyle(context)
                                      .copyWith(color: APPSTYLE_BackgroundWhite),
                                ),
                              ),),
                            Expanded(
                              child:Container(
                                decoration: BoxDecoration(
                                    color: APPSTYLE_PrimaryColorBg,
                                    borderRadius:
                                    BorderRadius.circular(APPSTYLE_BorderRadiusLarge)),
                                margin: EdgeInsets.only(right: APPSTYLE_SpaceMedium),
                                padding: APPSTYLE_ExtraSmallPaddingAll.copyWith(
                                    left: APPSTYLE_SpaceSmall, right: APPSTYLE_SpaceSmall),
                                child: Text('${mealsController.currentMeal.value.protein} ${'protein'.tr}',
                                  style: getLabelLargeStyle(context)
                                      .copyWith(color: APPSTYLE_BackgroundWhite),
                                ),
                              ),),
                            Expanded(
                              child:Container(
                                decoration: BoxDecoration(
                                    color: APPSTYLE_PrimaryColorBg,
                                    borderRadius:
                                    BorderRadius.circular(APPSTYLE_BorderRadiusLarge)),
                                padding: APPSTYLE_ExtraSmallPaddingAll.copyWith(
                                    left: APPSTYLE_SpaceSmall, right: APPSTYLE_SpaceSmall),
                                child: Text('${mealsController.currentMeal.value.fat} ${'fat'.tr}',
                                  style: getLabelLargeStyle(context)
                                      .copyWith(color: APPSTYLE_BackgroundWhite),
                                ),
                              ),),
                          ],
                        ),
                      ),
                      Visibility(
                        visible:

                        Localizations.localeOf(
                            context)
                            .languageCode
                            .toString() ==
                            'ar'
                            ?
                        mealsController.currentMeal.value.arabicDescription !='':
                        mealsController.currentMeal.value.description !='',
                        child: Padding(
                          padding: APPSTYLE_LargePaddingHorizontal.copyWith(top: APPSTYLE_SpaceLarge),
                          child: Text(

                            Localizations.localeOf(
                                context)
                                .languageCode
                                .toString() ==
                                'ar'
                                ?
                            mealsController.currentMeal.value.arabicDescription:
                            mealsController.currentMeal.value.description,
                            style: getBodyMediumStyle(context).copyWith(
                                color: APPSTYLE_Grey40 ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: mealsController.currentMeal.value.ingredients.isNotEmpty,
                        child: Padding(
                          padding: APPSTYLE_LargePaddingHorizontal.copyWith(top: APPSTYLE_SpaceLarge),
                          child: Text(
                            'ingredients'.tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: APPSTYLE_Grey60, fontWeight: APPSTYLE_FontWeightBold),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: mealsController.currentMeal.value.ingredients.isNotEmpty,
                        child:  Padding(
                          padding:APPSTYLE_LargePaddingHorizontal.copyWith(top: APPSTYLE_SpaceLarge),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                for(var i=0;i<mealsController.currentMeal.value.ingredients.length;i++)

                                  Padding(
                                    padding: const EdgeInsets.only(bottom: APPSTYLE_SpaceMedium),
                                    child: Row(

                                      children: [
                                        Container(
                                          decoration: APPSTYLE_BorderedContainerExtraSmallDecoration.copyWith(
                                            color:APPSTYLE_PrimaryColorBg,
                                            borderRadius: BorderRadius.circular(1000),
                                            image: DecorationImage(image: getProductImage(mealsController.currentMeal.value.ingredients[i].imageUrl),fit: BoxFit.cover),
                                          ),
                                          width: 40,height: 40,
                                          clipBehavior: Clip.hardEdge, ),
                                        addHorizontalSpace(APPSTYLE_SpaceMedium),
                                        Expanded(child: Text(
                                          Localizations.localeOf(
                                              context)
                                              .languageCode
                                              .toString() ==
                                              'ar'
                                              ?
                                          mealsController.currentMeal.value.ingredients[i].arabicName:
                                          mealsController.currentMeal.value.ingredients[i].name,
                                          style: getBodyMediumStyle(context),
                                        ))

                                      ],
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                      addVerticalSpace(APPSTYLE_SpaceLarge*2),

                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
