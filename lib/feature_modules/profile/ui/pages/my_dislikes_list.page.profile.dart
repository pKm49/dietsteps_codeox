import 'package:dietsteps/feature_modules/profile/controllers/profile.controller.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

class MyDislikesListPage_Profile extends StatefulWidget {
  const MyDislikesListPage_Profile({super.key});

  @override
  State<MyDislikesListPage_Profile> createState() =>
      _MyDislikesListPage_ProfileState();
}

class _MyDislikesListPage_ProfileState
    extends State<MyDislikesListPage_Profile> {
  final profileController = Get.find<ProfileController>();
  TextEditingController searchController = TextEditingController();
  var getArguments = Get.arguments;
  bool isRegisterComplete = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    profileController.getIngredients();
    profileController.getDislikes();

    searchController.addListener(() {
      profileController
          .updateIngredientsListByQuery(searchController.text.trim());
    });

    isRegisterComplete = getArguments[0];
    profileController.updateAllergyDislikePurpose(isRegisterComplete);


  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
          title: Row(
            children: [
              CustomBackButton(isPrimaryMode: false),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'dislike_qtn'.tr,
                    style: getHeadlineLargeStyle(context)
                        .copyWith(fontWeight: APPSTYLE_FontWeightBold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Obx(
            () => Container(
                height: screenheight,
                child: Column(
                  children: [
                    addVerticalSpace(APPSTYLE_SpaceSmall),
                    Visibility(
                        visible:   profileController.isIngredientsFetching.value ||
                              profileController.isDislikesFetching.value,
                        child: Padding(
                      padding: APPSTYLE_LargePaddingHorizontal,
                      child: Shimmer.fromColors(
                        baseColor: APPSTYLE_Grey20,
                        highlightColor: APPSTYLE_Grey40,
                        child: Container(
                          height: 50,
                          width: screenwidth  ,
                          decoration:
                              APPSTYLE_BorderedContainerExtraSmallDecoration
                                  .copyWith(
                            border: null,
                            color: APPSTYLE_Grey20,
                          ),
                        ),
                      ),
                    )),
                    Visibility(
                      visible: !profileController.isIngredientsFetching.value &&
                          !profileController.isDislikesFetching.value,
                      child: Padding(
                        padding: APPSTYLE_LargePaddingHorizontal,
                        child: TextFormField(
                            controller: searchController,
                            decoration: InputDecoration(
                              icon: Icon(Ionicons.search),
                                labelText: 'search_ingredients'.tr)),
                      ),
                    ),
                    addVerticalSpace(APPSTYLE_SpaceMedium),
                    Visibility(
                      visible:  profileController.isIngredientsFetching.value ||
                           profileController.isDislikesFetching.value,
                      child: Expanded(
                        child: Padding(
                          padding: APPSTYLE_LargePaddingHorizontal.copyWith(top: APPSTYLE_SpaceMedium),
                          child: ListView.builder(
                            itemCount: 20,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: APPSTYLE_SpaceMedium),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: APPSTYLE_Grey20,
                                      highlightColor: APPSTYLE_Grey40,
                                      child: Container(
                                        height: 25,
                                        width: screenwidth*.4  ,
                                        decoration:
                                        APPSTYLE_BorderedContainerExtraSmallDecoration
                                            .copyWith(
                                          border: null,
                                          color: APPSTYLE_Grey20,
                                        ),
                                      ),
                                    ),
                                    Shimmer.fromColors(
                                      baseColor: APPSTYLE_Grey20,
                                      highlightColor: APPSTYLE_Grey40,
                                      child: Container(
                                        height: 25,
                                        width: 25  ,
                                        decoration:
                                        APPSTYLE_BorderedContainerExtraSmallDecoration
                                            .copyWith(
                                          border: null,
                                          color: APPSTYLE_Grey20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible:   !profileController.isIngredientsFetching.value &&
                          !profileController.isDislikesFetching.value,
                      child: Expanded(
                        child: Padding(
                          padding: APPSTYLE_LargePaddingHorizontal,
                          child: ListView.builder(
                            itemCount: profileController.ingredientsToShow.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      Localizations.localeOf(context)
                                          .languageCode
                                          .toString() ==
                                          'ar'
                                          ? profileController
                                          .ingredientsToShow[index].arabicName
                                          : profileController
                                          .ingredientsToShow[index].name,
                                      style: getBodyMediumStyle(context)),
                                  Checkbox(
                                      checkColor: APPSTYLE_BackgroundOffWhite,
                                      activeColor: APPSTYLE_PrimaryColor,
                                      value: profileController.dislikes
                                          .map((element) => element.id)
                                          .toList()
                                          .contains(profileController
                                          .ingredientsToShow[index].id),
                                      onChanged: (value) {
                                        profileController.updateIngredientValues(
                                            profileController
                                                .ingredientsToShow[index]);
                                      }),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    addVerticalSpace(APPSTYLE_SpaceMedium),

                    Visibility(
                      visible:  !profileController.isIngredientsFetching.value &&
                          !profileController.isDislikesFetching.value,
                      child: Container(
                        width: screenwidth - (APPSTYLE_SpaceLarge * 2),
                        height: 130,
                        padding: APPSTYLE_SmallPaddingAll,
                        decoration:
                            APPSTYLE_ShadowedContainerSmallDecoration.copyWith(
                                color: APPSTYLE_Grey20),
                        child: SingleChildScrollView(
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              for (var i = 0;
                                  i < profileController.dislikes.length;
                                  i++)
                                InkWell(
                                  onTap: () {
                                    profileController.updateIngredientValues(
                                        profileController.dislikes[i]);
                                  },
                                  child: Container(
                                    decoration:
                                        APPSTYLE_BorderedContainerSmallDecoration,
                                    margin: EdgeInsets.only(
                                        right: APPSTYLE_SpaceSmall,
                                        bottom: APPSTYLE_SpaceSmall),
                                    padding: APPSTYLE_ExtraSmallPaddingAll.copyWith(
                                        right: APPSTYLE_SpaceSmall,
                                        left: APPSTYLE_SpaceSmall),
                                    child: Wrap(
                                      children: [
                                        Text(
                                            Localizations.localeOf(context)
                                                        .languageCode
                                                        .toString() ==
                                                    'ar'
                                                ? profileController
                                                    .dislikes[i].arabicName
                                                : profileController
                                                    .dislikes[i].name,
                                            style: getLabelLargeStyle(context)),
                                        addHorizontalSpace(APPSTYLE_SpaceSmall),
                                        Icon(Ionicons.close,
                                            size: APPSTYLE_FontSize14)
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                    addVerticalSpace(APPSTYLE_SpaceMedium),
                    Visibility(
                      visible:  !profileController.isIngredientsFetching.value &&
                          !profileController.isDislikesFetching.value,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: APPSTYLE_SpaceLarge,
                            vertical: APPSTYLE_SpaceSmall),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if(!profileController.isDislikesUpdating.value){
                                profileController.updateDislikes(profileController.isAllregyDislikeForRegisterComplete.value);
                              }
                            },
                            style: getElevatedButtonStyle(context),
                            child: profileController.isDislikesUpdating.value
                                ? LoadingAnimationWidget.staggeredDotsWave(
                              color: APPSTYLE_BackgroundWhite,
                              size: 24,
                            ):  Text("update".tr,
                                style: getHeadlineMediumStyle(context).copyWith(
                                    color: APPSTYLE_BackgroundWhite,
                                    fontWeight: APPSTYLE_FontWeightBold),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
