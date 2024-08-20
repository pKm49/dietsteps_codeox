import 'dart:ui';

import 'package:dietsteps/feature_modules/plan_purchase/models/plan_category.model.plan_purchase.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SubscriptionPlanCategoryCardComponent_PlanPurchase extends StatelessWidget {
  SubscriptionPlanCategory subscriptionPlanCategory;
  GestureTapCallback onClick;

  SubscriptionPlanCategoryCardComponent_PlanPurchase({super.key, required this.onClick,required this.subscriptionPlanCategory});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: APPSTYLE_SmallPaddingAll,
      decoration:
      APPSTYLE_ShadowedContainerSmallDecoration
          .copyWith(
          boxShadow:[
            const BoxShadow(
              color: APPSTYLE_Grey60,
              offset: Offset(0, 4.0),
              blurRadius: APPSTYLE_BlurRadiusSmall,
            ),
          ],
        image: DecorationImage(
          image:getImage(subscriptionPlanCategory.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: APPSTYLE_SmallPaddingAll,
        decoration:   BoxDecoration(
            borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusSmall),
            gradient: const LinearGradient(
              colors: [Colors.transparent, Color(0xff000000)],
              stops: [0, 0.99],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(0.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: APPSTYLE_SmallPaddingAll,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Localizations.localeOf(context)
                                  .languageCode
                                  .toString() ==
                                  'ar'?subscriptionPlanCategory.arabicName
                                  :subscriptionPlanCategory.name,
                                style: getHeadlineMediumStyle(context).copyWith(
                                    color: APPSTYLE_BackgroundWhite,fontWeight: APPSTYLE_FontWeightBold
                                ),),
                              addVerticalSpace(APPSTYLE_SpaceExtraSmall),
                              Text(Localizations.localeOf(context)
                                  .languageCode
                                  .toString() ==
                                  'ar'?subscriptionPlanCategory.arabicDescription
                                  :subscriptionPlanCategory.description,
                                style: getLabelSmallStyle(context).copyWith(
                                    color: APPSTYLE_BackgroundWhite
                                ),)
                            ],
                          ),
                        ),
                        addHorizontalSpace(APPSTYLE_SpaceSmall),
                        InkWell(
                          onTap: onClick,
                          child: Icon(Localizations.localeOf(context)
                              .languageCode
                              .toString() ==
                              'ar'? Ionicons.arrow_back_circle:Ionicons.arrow_forward_circle,color: APPSTYLE_BackgroundWhite),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(

                child:Align(
                  alignment: Alignment.bottomCenter,

                  child: ListView.builder(
                    shrinkWrap: true,
                      itemCount: Localizations.localeOf(context)
                          .languageCode
                          .toString() ==
                          'ar'?subscriptionPlanCategory.mealsConfigArabic.length
                          :subscriptionPlanCategory.mealsConfig.length,
                      itemBuilder: (context, index) {
                        return  Text(Localizations.localeOf(context)
                            .languageCode
                            .toString() ==
                            'ar'?subscriptionPlanCategory.mealsConfigArabic[index]
                            :subscriptionPlanCategory.mealsConfig[index],
                          style: getBodyMediumStyle(context).copyWith(
                              color: APPSTYLE_BackgroundWhite,
                              fontWeight: APPSTYLE_FontWeightBold
                          ),);
                      }),
                ))
          ],
        ),
      ),
    );
  }

  getImage(String imageUrl) {
    return imageUrl == ASSETS_WELCOME_LOGIN_BG?
    AssetImage(ASSETS_WELCOME_LOGIN_BG)
        :NetworkImage(imageUrl);
  }
}
