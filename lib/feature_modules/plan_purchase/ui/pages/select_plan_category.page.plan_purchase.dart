import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dietsteps/feature_modules/plan_purchase/controllers/plan_purchase.controller.dart';
import 'package:dietsteps/feature_modules/plan_purchase/ui/components/subscriptionplan_categorycard.component.plan_purchase.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
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

class SelectPlanCategoryPage_PlanPurchase extends StatefulWidget {
  const SelectPlanCategoryPage_PlanPurchase({super.key});

  @override
  State<SelectPlanCategoryPage_PlanPurchase> createState() =>
      _SelectPlanCategoryPage_PlanPurchaseState();
}

class _SelectPlanCategoryPage_PlanPurchaseState
    extends State<SelectPlanCategoryPage_PlanPurchase> {
  final CarouselController _controllerLoaded = CarouselController();
  final CarouselController _controller = CarouselController();
  final planPurchaseController = Get.find<PlanPurchaseController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    planPurchaseController.getSubscriptionCategories();
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
                  Text(
                    'which_plan_q'.tr,
                    style: getHeadlineLargeStyle(context)
                        .copyWith(fontWeight: APPSTYLE_FontWeightBold),
                    textAlign: TextAlign.start,
                  ),
                  Visibility(
                    visible:  planPurchaseController.isCategoriesFetching.value ,
                    child: Expanded(
                      child: Center(
                        child: CarouselSlider(
                            carouselController: _controllerLoaded,
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              aspectRatio: .9,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              autoPlay: false,
                              viewportFraction: 0.7,
                              onPageChanged: (index, reason) {},
                            ),
                            items: [
                              Shimmer.fromColors(
                                baseColor: APPSTYLE_Grey20,
                                highlightColor: APPSTYLE_Grey40,
                                child: Container(
                                  decoration:
                                  APPSTYLE_BorderedContainerExtraSmallDecoration
                                      .copyWith(color: APPSTYLE_Grey20),
                                )
                              ),
                              Shimmer.fromColors(
                                  baseColor: APPSTYLE_Grey20,
                                  highlightColor: APPSTYLE_Grey40,
                                  child: Container(
                                    decoration:
                                    APPSTYLE_BorderedContainerExtraSmallDecoration
                                        .copyWith(color: APPSTYLE_Grey20),
                                  )
                              ),
                              Shimmer.fromColors(
                                  baseColor: APPSTYLE_Grey20,
                                  highlightColor: APPSTYLE_Grey40,
                                  child: Container(
                                    decoration:
                                    APPSTYLE_BorderedContainerExtraSmallDecoration
                                        .copyWith(color: APPSTYLE_Grey20),
                                  )
                              ),

                            ]),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: planPurchaseController.subscriptionCategories.isEmpty &&
                        !planPurchaseController.isCategoriesFetching.value ,
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
                                    color: APPSTYLE_Grey20,
                                  ),
                                  width: screenwidth * .3,
                                  height: screenwidth * .3,
                                  child: Center(
                                    child: Icon(Ionicons.cash_outline,
                                        size: screenwidth * .15,
                                        color: APPSTYLE_PrimaryColorBg),
                                  ),
                                )
                              ],
                            ),
                            addVerticalSpace(APPSTYLE_SpaceLarge),
                            Text("no_plans_found".tr,
                                style: getHeadlineMediumStyle(context)),
                          ],
                        )),
                  ),
                  Visibility(
                    visible: !planPurchaseController.isCategoriesFetching.value &&
                        planPurchaseController.subscriptionCategories.isNotEmpty,
                    child: Expanded(
                      child: Center(
                        child: CarouselSlider(
                            carouselController: _controller,
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              aspectRatio: .9,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              autoPlay: false,
                              viewportFraction: 0.7,
                              onPageChanged: (index, reason) {
                                planPurchaseController.changeCategory(planPurchaseController.subscriptionCategories[index]);
                              },
                            ),

                            items:planPurchaseController.subscriptionCategories.map((element) =>
                                Container(
                                  decoration:
                                  APPSTYLE_BorderedContainerSmallDecoration.copyWith(
                                      color: Colors.transparent,
                                      border: Border.all(
                                          color:
                                          planPurchaseController.currentCategory.value.id ==element.id?
                                          APPSTYLE_PrimaryColor:Colors.transparent, width: 2)),
                                  height: screenheight * .28,
                                  width: screenwidth,
                                  padding:  EdgeInsets.all(APPSTYLE_SpaceExtraSmall*.5),
                                  child: SubscriptionPlanCategoryCardComponent_PlanPurchase(
                                    onClick:(){
                                      planPurchaseController.changeCategory(element);
                                      Get.toNamed(AppRouteNames.planPurchaseSubscriptionPlansListRoute);
                                    },
                                    subscriptionPlanCategory:element,
                                  ),
                                ),
                            ).toList() ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible:  !planPurchaseController.isCategoriesFetching.value ,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: APPSTYLE_SpaceLarge,vertical: APPSTYLE_SpaceSmall),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if(!planPurchaseController.isCategoriesFetching.value){
                              if(planPurchaseController.subscriptionCategories.isNotEmpty){
                                if(planPurchaseController.currentCategory.value.id == -1){
                                  planPurchaseController.changeCategory(planPurchaseController.subscriptionCategories[0]);
                                }
                                Get.toNamed(AppRouteNames.planPurchaseSubscriptionPlansListRoute);
                              }else{
                                planPurchaseController.getSubscriptionCategories();
                              }
                            }
                          },
                          style: getElevatedButtonStyle(context),
                          child: Text(planPurchaseController.subscriptionCategories.isNotEmpty?
                          "continue".tr:"reload".tr,
                              style: getHeadlineMediumStyle(context).copyWith(
                                  color: APPSTYLE_BackgroundWhite,
                                  fontWeight: APPSTYLE_FontWeightBold),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
