 
import 'dart:ffi';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dietsteps/feature_modules/auth/controllers/meals.controller.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/meals_subs/components/meal_category_card.component.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/meals_subs/components/meal_category_card_loader.component.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/meals_subs/components/meal_itemcard.component.auth.dart';
import 'package:dietsteps/feature_modules/auth/ui/meals_subs/components/meal_itemsloader.component.auth.dart';
import 'package:dietsteps/feature_modules/plan_purchase/controllers/plan_purchase.controller.dart';
import 'package:dietsteps/feature_modules/plan_purchase/ui/components/subscriptionplan_categorycard.component.plan_purchase.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';

class MealsListPage_Auth extends StatefulWidget {
  const MealsListPage_Auth({super.key});

  @override
  State<MealsListPage_Auth> createState() =>
      _MealsListPage_AuthState();
}

class _MealsListPage_AuthState
    extends State<MealsListPage_Auth> {
  final mealsController = Get.find<MealsController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mealsController.getMealCategories();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: APPSTYLE_BackgroundWhite,
          scrolledUnderElevation: 0.0,
          elevation: 0.0,
          title: Row(
            children: [
              CustomBackButton(isPrimaryMode: false),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'view_meals'.tr,
                    style: getHeadlineLargeStyle(context).copyWith(
                        fontWeight: APPSTYLE_FontWeightBold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            LanguagePreviewButtonComponentShared(textColor:APPSTYLE_PrimaryColor),
            addHorizontalSpace(APPSTYLE_SpaceLarge)
          ],
        ),
        body: SafeArea(
          child: Obx(
                ()=> Container(
              height: screenheight,
              child: Column(
                children: [
                  addVerticalSpace(APPSTYLE_SpaceLarge ),
                  Visibility(
                    visible: mealsController.isCategoriesFetching.value,
                    child: Container(
                      height: 36,
                      width: screenwidth,
                      alignment: Alignment.center,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          addHorizontalSpace(APPSTYLE_SpaceMedium),
                          MealCategoryCardLoaderComponent(),
                          addHorizontalSpace(APPSTYLE_SpaceMedium),
                          MealCategoryCardLoaderComponent(),
                          addHorizontalSpace(APPSTYLE_SpaceMedium),
                          MealCategoryCardLoaderComponent(),
                          addHorizontalSpace(APPSTYLE_SpaceMedium),
                          MealCategoryCardLoaderComponent(),
                          addHorizontalSpace(APPSTYLE_SpaceMedium),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !mealsController.isCategoriesFetching.value && mealsController.mealCategories.isNotEmpty,
                    child: Container(
                      height: 36,
                      width: screenwidth,
                      alignment: Alignment.center,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          addHorizontalSpace(APPSTYLE_SpaceMedium),
                          for (var i = 0; i < mealsController.mealCategories.length; i++)
                            Container(
                              margin: EdgeInsets.only(right: APPSTYLE_SpaceSmall),
                              child: MealCategoryCardComponent(
                                  label:Localizations.localeOf(context)
                                      .languageCode
                                      .toString() ==
                                      'ar'?mealsController.mealCategories[i].arabicName:
                                  mealsController.mealCategories[i].name,
                                  isSelected: mealsController.currentMealCategoryId.value == mealsController.mealCategories[i].id,
                                  onClick: () {
                                    mealsController.getMealsByCategory(mealsController.mealCategories[i].id);
                                  }),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: mealsController.meals.isEmpty &&
                        !mealsController.isMealsLoading.value ,
                    child: Expanded(
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
                                    color: APPSTYLE_Grey40,
                                  ),
                                  width: screenwidth * .4,
                                  height: screenwidth * .4,
                                  child: Center(
                                    child:  Image.asset(ASSETS_MEALS,width: screenwidth*.3),
                                  ),
                                )
                              ],
                            ),
                            addVerticalSpace(APPSTYLE_SpaceLarge),
                            Text("no_meals_found".tr,
                                style: getHeadlineMediumStyle(context)),
                          ],
                        )),
                  ),
                  Visibility(
                    visible: mealsController.isMealsLoading.value ,
                    child: Expanded(
                      child: MealItemsLoader(),
                    ),
                  ),

                  Visibility(
                      visible: mealsController.meals.isNotEmpty &&
                          !mealsController.isMealsLoading.value ,
                      child: Expanded(child: Padding(
                        padding:APPSTYLE_LargePaddingAll,
                        child: GridView.builder(
                                            shrinkWrap: true,
                                            itemCount: mealsController
                          .meals
                          .length,
                                            gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: APPSTYLE_SpaceSmall,
                          mainAxisExtent: screenheight * 0.35),
                                            itemBuilder: (context, indx) {
                        return MealItemCardComponent_Auth(
                            isSelectable: false,
                            selectedCount:0,
                            subscriptoinDailyMealItem:
                            mealsController
                                .meals [indx],
                            onAdded: (int count){
                                mealsController.viewMeal( mealsController
                                    .meals[indx]);
                            });

                                            },
                                          ),
                      )))
                ],
              ),
            ),
          ),
        ));
  }
}
