 
import 'dart:ffi';
import 'dart:ui';
 
import 'package:dietsteps/feature_modules/e_shop/controllers/controller.eshop.dart';
import 'package:dietsteps/feature_modules/e_shop/models/cart.model.eshop.dart';
import 'package:dietsteps/feature_modules/e_shop/ui/components/meal_category_card.component.eshop.dart';
import 'package:dietsteps/feature_modules/e_shop/ui/components/meal_category_card_loader.component.eshop.dart';
import 'package:dietsteps/feature_modules/e_shop/ui/components/meal_itemcard.component.eshop.dart';
import 'package:dietsteps/feature_modules/e_shop/ui/components/meal_itemsloader.component.eshop.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/form_validator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sticky_headers/sticky_headers.dart';

class MealsListPage_Eshop extends StatefulWidget {
  const MealsListPage_Eshop({super.key});

  @override
  State<MealsListPage_Eshop> createState() =>
      _MealsListPage_EshopState();
}

class _MealsListPage_EshopState
    extends State<MealsListPage_Eshop> {
  final eshopController = Get.find<EshopController>();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eshopController.getMealCategories();
    itemPositionsListener.itemPositions.addListener(() =>
        eshopController.changeCategoryByIndex(itemPositionsListener.itemPositions.value.first.index)
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
          ()=> Scaffold(
            bottomSheet:eshopController.cart.value.orderLine.isNotEmpty?  Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: APPSTYLE_SpaceLarge,vertical: APPSTYLE_SpaceSmall),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    openLoginRegisterModal(screenwidth);
                  },
                  style: getElevatedButtonStyle(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(
                        '${eshopController.cart.value.total} KD',
                        style: getHeadlineMediumStyle(context).copyWith(
                            color: APPSTYLE_BackgroundWhite,
                            fontWeight: APPSTYLE_FontWeightBold),
                      ),),
                      Text(
                        "checkout".tr,
                        style: getHeadlineMediumStyle(context).copyWith(
                            color: APPSTYLE_BackgroundWhite,
                            fontWeight: APPSTYLE_FontWeightBold),
                      ),
                      addHorizontalSpace(APPSTYLE_SpaceSmall),
                      const Icon(Ionicons.chevron_forward,color: APPSTYLE_BackgroundWhite )
                    ],
                  ),
                ),
              ),
            ):null,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: APPSTYLE_BackgroundWhite,
            scrolledUnderElevation: 0.0,
            elevation: 0.0,
            title: Row(
              children: [
                CustomBackButton(isPrimaryMode:false),

                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'eshop'.tr,
                      style: getHeadlineLargeStyle(context).copyWith(
                          fontWeight: APPSTYLE_FontWeightBold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
          InkWell(
            onTap: (){
              Get.toNamed(AppRouteNames.eshopCartRoute);
            },
            child: Badge(
            backgroundColor:
            eshopController.cart.value.orderLine.isNotEmpty
              ? APPSTYLE_PrimaryColor
              : Colors.transparent,
                child: const Icon(Ionicons.cart_outline, size: APPSTYLE_FontSize24)),
          ),
              addHorizontalSpace(APPSTYLE_SpaceLarge)
            ],
          ),
          body: SafeArea(
            child:  Container(
                height: screenheight,
                child: Column(
                  children: [
                    addVerticalSpace(APPSTYLE_SpaceLarge ),
                    Visibility(
                        visible: eshopController.isAddingToOrRemoveFromCart.value,
                        child:Padding(
                        padding: EdgeInsets.only(bottom: APPSTYLE_SpaceSmall),
                          child: LinearProgressIndicator(),

                    )),

                    Visibility(
                      visible: eshopController.isCategoriesFetching.value,
                      child: Container(
                        height: 36,
                        width: screenwidth,
                        alignment: Alignment.center,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            addHorizontalSpace(APPSTYLE_SpaceMedium),
                            MealCategoryCardLoaderComponentEshop(),
                            addHorizontalSpace(APPSTYLE_SpaceMedium),
                            MealCategoryCardLoaderComponentEshop(),
                            addHorizontalSpace(APPSTYLE_SpaceMedium),
                            MealCategoryCardLoaderComponentEshop(),
                            addHorizontalSpace(APPSTYLE_SpaceMedium),
                            MealCategoryCardLoaderComponentEshop(),
                            addHorizontalSpace(APPSTYLE_SpaceMedium),
                          ],
                        ),
                      ),
                    ),



                    Visibility(
                      visible: !eshopController.isCategoriesFetching.value && eshopController.mealCategorySingleItems.isNotEmpty,
                      child: Container(
                        height: 36,
                        width: screenwidth,
                        alignment: Alignment.center,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            addHorizontalSpace(APPSTYLE_SpaceMedium),
                            for (var i = 0; i < eshopController.mealCategorySingleItems.length; i++)
                              Container(
                                margin: EdgeInsets.only(right: APPSTYLE_SpaceSmall),
                                child: MealCategoryCardComponentEshop(
                                    label:Localizations.localeOf(context)
                                        .languageCode
                                        .toString() ==
                                        'ar'?eshopController.mealCategorySingleItems[i].arabicName:
                                    eshopController.mealCategorySingleItems[i].name,
                                    isSelected: eshopController.currentMealCategoryId.value == eshopController.mealCategorySingleItems[i].id,
                                    onClick: () {
                                        eshopController.setCategory(eshopController.mealCategorySingleItems[i].id);
                                    }),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: eshopController.mealCategories.isEmpty &&
                          !eshopController.isMealsLoading.value ,
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
                    addVerticalSpace(APPSTYLE_SpaceMedium),
                    Visibility(
                      visible: eshopController.isMealsLoading.value ,
                      child: Expanded(
                        child: MealItemsLoader_Eshop(),
                      ),
                    ),

                    Visibility(
                        visible: eshopController.mealCategories.isNotEmpty &&
                            !eshopController.isMealsLoading.value ,
                        child: Expanded(child: ScrollablePositionedList.builder(
                          itemCount: eshopController
                              .mealCategories.length,
                          itemScrollController:
                          eshopController.itemScrollController,
                            itemPositionsListener:itemPositionsListener,
                          itemBuilder: (BuildContext context, int index) {
                            return StickyHeader(
                              header: Container(
                                color: APPSTYLE_PrimaryColorBgLight,
                                padding: APPSTYLE_LargePaddingHorizontal.copyWith(
                                    top: APPSTYLE_SpaceMedium,
                                    bottom: APPSTYLE_SpaceMedium),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            Localizations.localeOf(context)
                                                .languageCode
                                                .toString() ==
                                                'ar'
                                                ? eshopController
                                                .mealCategories
                                                .value
                                            [index]
                                                .arabicName
                                                : eshopController
                                                .mealCategories
                                            [index]
                                                .name,
                                            style: getHeadlineMediumStyle(context)
                                                .copyWith(
                                                fontSize: APPSTYLE_FontSize20,
                                                fontWeight:
                                                APPSTYLE_FontWeightBold)),
                                        Container(
                                          width: 30,
                                          height: 2,
                                          color: APPSTYLE_Grey80,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              content: Padding(
                                padding: APPSTYLE_LargePaddingHorizontal.copyWith(
                                    top: APPSTYLE_SpaceMedium),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: eshopController
                                      .mealCategories [index]
                                      .meals
                                      .length,
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 0,
                                      crossAxisSpacing: APPSTYLE_SpaceMedium,
                                      mainAxisExtent: screenheight * 0.35),
                                  itemBuilder: (context, indx) {
                                    return MealItemCardComponent_Eshop(
                                        isSelectable: true,
                                        selectedCount:getItemCount(eshopController
                                            .mealCategories[index].meals[indx].id),
                                        mealItem:
                                        eshopController.mealCategories[index]
                                            .meals [indx],
                                        onAdded: (int count){
                                          print("count");
                                          print(count);
                                          eshopController.updateCartItem(
                                              OrderLine(mealId: eshopController.mealCategories[index].meals[indx].id,
                                                  imageUrl: eshopController.mealCategories[index].meals[indx].imageUrl,
                                                  mealName: eshopController.mealCategories[index].meals[indx].name,
                                                  mealNameArabic: eshopController.mealCategories[index].meals[indx].arabicName,
                                                  quantity: count,
                                                  price: eshopController.mealCategories[index].meals[indx].price),
                                              count,count>0);
                                        });
                                  },
                                ),
                              ),
                            );
                          },
                        )))
                  ],
                ),
              ),

          )),
    );
  }

  getItemCount(int id) {
    if(eshopController.cart.value.orderLine.where((element) => element.mealId==id).toList().isNotEmpty){
      return eshopController.cart.value.orderLine.where((element) => element.mealId==id).toList()[0].quantity;
    }
    return 0;
  }


  openLoginRegisterModal(screenwidth){
    Get.bottomSheet(
      Obx(
            ()=> Container(
          width: screenwidth,
          height: 200,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(APPSTYLE_BorderRadiusSmall),
              topRight: Radius.circular(APPSTYLE_BorderRadiusSmall),
            ),
          ),
          padding: APPSTYLE_LargePaddingAll,
          child:  Column(
            children: [
              Text("enter_mobile".tr,style: getHeadlineLargeStyle(context)),
              addVerticalSpace(APPSTYLE_SpaceExtraSmall),
              const Divider(),
              Expanded(child: Container()),
              Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                            controller:
                            eshopController.mobileTextEditingController.value,
                            validator: (value) => checkIfMobileNumberValid(value),
                            keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                            decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.never,

                                hintText: 'enter_mobile_number'.tr
                            )),
                      )),
                  addHorizontalSpace(APPSTYLE_SpaceMedium),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(

                            child: eshopController.isUserExistanceChecking.value  || eshopController.isUserExistanceChecking.value
                                ? LoadingAnimationWidget.staggeredDotsWave(
                              color: APPSTYLE_BackgroundWhite,
                              size: 24,
                            ):  Icon(Ionicons.chevron_forward,color: APPSTYLE_BackgroundWhite),
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (eshopController.mobileTextEditingController.value.text!='' &&
                                  !eshopController.isUserExistanceChecking.value) {
                                eshopController.checkIfUserExists();
                              }
                            },
                          )
                      )),

                ],
              ),
              addVerticalSpace(APPSTYLE_SpaceMedium),

            ],
          ),
        ),
      ),
    );
  }
}
