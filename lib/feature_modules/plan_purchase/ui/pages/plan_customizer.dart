import 'dart:math';

import 'package:dietsteps/feature_modules/plan_purchase/controllers/plan_purchase.controller.dart';
import 'package:dietsteps/feature_modules/plan_purchase/models/plan_category.model.plan_purchase.dart';
import 'package:dietsteps/feature_modules/plan_purchase/ui/pages/food_portion_customiser.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ionicons/ionicons.dart';

import '../../../../shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import '../../models/plan.model.plan_purchase.dart';

void showPlanCustomizationBottomSheet(BuildContext context, String planName,
    SubscriptionPlanCategory planCategory,
    {Map<String, dynamic>? savedState}) {
  final PlanPurchaseController controller = Get.find<PlanPurchaseController>();

  // Plan durations from API data (from choiceConfig)
  List<String> planDurations = planCategory.choiceConfig
      .map((config) => config.durationType.name.capitalize!)
      .toSet()
      .toList();

  if (planDurations.isEmpty) {
    planDurations = ['Monthly'];
  }

  // Make selectedPlanDuration reactive with .obs
  RxString selectedPlanDuration = planDurations.first.obs;
  RxInt selectedChoiceConfigId = (-1).obs;
  Map<int, RxInt> mealCounts = {};
  Map<int, RxInt> mealProteins = {};
  Map<int, RxInt> mealCarbs = {};
  Map<int, int> defaultProteins = {};
  Map<int, int> defaultCarbs = {};

  // FIRST: Initialize with default values
  for (var config in planCategory.customisableConfig) {
    mealCounts[config.categoryId] = config.count.obs;
    if (config.isCustomisable) {
      // First check if protein values are valid to prevent NaN
      int proteinValue;
      if (planCategory.protein > 0) {
        proteinValue = planCategory.protein;
      } else if (config.proteinHighLimit > config.proteinLowLimit) {
        proteinValue =
            ((config.proteinLowLimit + config.proteinHighLimit) / 2).round();
      } else {
        // Fallback if limits are invalid
        proteinValue =
            config.proteinLowLimit > 0 ? config.proteinLowLimit : 100;
      }

      // Then check if carb values are valid to prevent NaN
      int carbsValue;
      if (planCategory.carbs > 0) {
        carbsValue = planCategory.carbs;
      } else if (config.carbHighLimit > config.carbLowLimit) {
        carbsValue = ((config.carbLowLimit + config.carbHighLimit) / 2).round();
      } else {
        // Fallback if limits are invalid
        carbsValue = config.carbLowLimit > 0 ? config.carbLowLimit : 100;
      }

      mealProteins[config.categoryId] = proteinValue.obs;
      mealCarbs[config.categoryId] = carbsValue.obs;
      defaultProteins[config.categoryId] = proteinValue;
      defaultCarbs[config.categoryId] = carbsValue;
    }
  }

  // SECOND: Override with saved state if it exists
  if (savedState != null && savedState.isNotEmpty) {
    print("📋 Restoring saved state: $savedState");

    // Restore selectedChoiceConfigId if it exists
    if (savedState.containsKey('selectedChoiceConfigId')) {
      int savedId = int.parse(savedState['selectedChoiceConfigId'].toString());
      selectedChoiceConfigId.value = savedId;

      // Find the corresponding plan duration for the saved choice
      if (savedId != -1) {
        final savedChoice = planCategory.choiceConfig.firstWhere(
          (config) => config.id == savedId,
          orElse: () => ChoiceConfig(
            isCustomisable: false,
            id: -1,
            name: "",
            arabicName: "",
            daysCount: 0,
            durationType: DurationType.day,
            price: 0.0,
          ),
        );

        if (savedChoice.id != -1) {
          String durationType = savedChoice.durationType.name.capitalize!;
          if (planDurations.contains(durationType)) {
            selectedPlanDuration.value = durationType;
          }
        }
      }
    }

    // Restore meal counts if they exist in saved state
    if (savedState.containsKey('mealCounts')) {
      Map<dynamic, dynamic> savedMealCounts = savedState['mealCounts'];
      savedMealCounts.forEach((key, value) {
        int categoryId = int.parse(key.toString());
        int count = int.parse(value.toString());
        if (mealCounts.containsKey(categoryId)) {
          mealCounts[categoryId]!.value = count;
        }
      });
    }

    // Restore protein values if they exist
    if (savedState.containsKey('mealProteins')) {
      Map<dynamic, dynamic> savedProteins = savedState['mealProteins'];
      savedProteins.forEach((key, value) {
        int categoryId = int.parse(key.toString());
        int protein = int.parse(value.toString());
        if (mealProteins.containsKey(categoryId)) {
          mealProteins[categoryId]!.value = protein;
        }
      });
    }

    // Restore carb values if they exist
    if (savedState.containsKey('mealCarbs')) {
      Map<dynamic, dynamic> savedCarbs = savedState['mealCarbs'];
      savedCarbs.forEach((key, value) {
        int categoryId = int.parse(key.toString());
        int carbs = int.parse(value.toString());
        if (mealCarbs.containsKey(categoryId)) {
          mealCarbs[categoryId]!.value = carbs;
        }
      });
    }
  }

  // Helper function to save state before closing sheet
  void saveBottomSheetState() {
    // Convert Rx values to regular integers for storage
    Map<int, int> savedMealCounts = {};
    Map<int, int> savedMealProteins = {};
    Map<int, int> savedMealCarbs = {};

    mealCounts.forEach((key, value) {
      savedMealCounts[key] = value.value;
    });

    mealProteins.forEach((key, value) {
      savedMealProteins[key] = value.value;
    });

    mealCarbs.forEach((key, value) {
      savedMealCarbs[key] = value.value;
    });

    // Set flag and save last category
    controller.wasBottomSheetOpen.value = true;
    controller.lastSelectedPlanCategory.value = planName;

    // Store the complete state
    controller.bottomSheetState = {
      'selectedChoiceConfigId': selectedChoiceConfigId.value,
      'mealCounts': savedMealCounts,
      'mealProteins': savedMealProteins,
      'mealCarbs': savedMealCarbs,
    };

    print("💾 State saved: ${controller.bottomSheetState}");
  }

  // Helper functions for filtering and calculations
  List<ChoiceConfig> getFilteredChoiceConfigs(String durationType) {
    String normalizedType = durationType.toLowerCase();
    if (normalizedType == "monthly") normalizedType = "month";
    if (normalizedType == "weekly") normalizedType = "week";
    if (normalizedType == "daily") normalizedType = "day";
    return planCategory.choiceConfig
        .where((config) => config.durationType.name == normalizedType)
        .toList();
  }

  void setDefaultChoiceConfig() {
    var configs = getFilteredChoiceConfigs(selectedPlanDuration.value);
    if (configs.isNotEmpty) {
      selectedChoiceConfigId.value = configs.first.id;
    }
  }

  // No default selection
  // setDefaultChoiceConfig();

  String getLocalizedCategoryName(CustomisableConfig config) {
    return Get.locale?.languageCode == 'ar'
        ? config.categoryArabicName
        : config.categoryName;
  }

  ChoiceConfig getSelectedChoiceConfig() {
    if (selectedChoiceConfigId.value != -1) {
      // First try to find by ID (most reliable)
      var choiceById = planCategory.choiceConfig.firstWhere(
        (config) => config.id == selectedChoiceConfigId.value,
        orElse: () => ChoiceConfig(
          isCustomisable: false,
          id: -1,
          name: "",
          arabicName: "",
          daysCount: 0,
          durationType: DurationType.day,
          price: 0.0,
        ),
      );

      if (choiceById.id != -1) {
        print(
            "📌 Found choice config by ID: ${choiceById.id}, Name: ${choiceById.name}");
        return choiceById;
      }
    }

    // If not found by ID, try to find by duration type
    var choiceByDuration = planCategory.choiceConfig.firstWhere(
      (config) =>
          config.durationType.name.capitalize == selectedPlanDuration.value,
      orElse: () => planCategory.choiceConfig.isNotEmpty
          ? planCategory.choiceConfig.first
          : ChoiceConfig(
              isCustomisable: false,
              id: -1,
              name: "",
              arabicName: "",
              daysCount: 0,
              durationType: DurationType.day,
              price: 0.0,
            ),
    );

    print(
        "📌 Found choice config by duration: ${choiceByDuration.id}, Name: ${choiceByDuration.name}");
    return choiceByDuration;
  }

  double getBasePrice() {
    return getSelectedChoiceConfig().price;
  }

  double getMacroCustomizationCost() {
    double cost = 0.0;
    final selectedConfig = getSelectedChoiceConfig();
    final int daysCount = selectedConfig.daysCount;

    print("🔢 Calculating macro costs for $daysCount days");

    for (var config in planCategory.customisableConfig) {
      if (!config.isCustomisable) continue;

      int currentCount = mealCounts[config.categoryId]?.value ?? 0;
      if (currentCount == 0) continue;

      int currentProtein = mealProteins[config.categoryId]?.value ??
          defaultProteins[config.categoryId] ??
          0;
      int currentCarbs = mealCarbs[config.categoryId]?.value ??
          defaultCarbs[config.categoryId] ??
          0;

      int defaultProteinValue = defaultProteins[config.categoryId] ?? 0;
      int defaultCarbsValue = defaultCarbs[config.categoryId] ?? 0;

      int proteinStep = config.proteinStepValue > 0 ? config.proteinStepValue : 50;
      int carbStep = config.carbStepValue > 0 ? config.carbStepValue : 50;

      // --- Protein Price Calculation ---
      int proteinDeltaRaw = currentProtein - defaultProteinValue;
      int proteinDelta = 0;
      if (proteinDeltaRaw >= proteinStep) {
        proteinDelta = (proteinDeltaRaw / proteinStep).ceil();
      } else if (proteinDeltaRaw <= -proteinStep) {
        proteinDelta = (proteinDeltaRaw / proteinStep).floor();
      }
      double proteinPricePerStep = 7.0 * (proteinStep / 50.0);
      double proteinCost = proteinDelta * proteinPricePerStep;

      // --- Carbs Price Calculation ---
      int carbsDeltaRaw = currentCarbs - defaultCarbsValue;
      int carbsDelta = 0;
      if (carbsDeltaRaw >= carbStep) {
        carbsDelta = (carbsDeltaRaw / carbStep).ceil();
      } else if (carbsDeltaRaw <= -carbStep) {
        carbsDelta = (carbsDeltaRaw / carbStep).floor();
      }
      double carbsPricePerStep = 3.0 * (carbStep / 50.0);
      double carbsCost = carbsDelta * carbsPricePerStep;

      // Total cost for this meal type
      double mealMacroCost =
          (proteinCost + carbsCost) * currentCount * daysCount;
      cost += mealMacroCost;

      print("📊 Meal ${config.categoryName}: count=$currentCount, "
          "protein=$currentProtein g (default=$defaultProteinValue g, cost=$proteinCost SAR), "
          "carbs=$currentCarbs g (default=$defaultCarbsValue g, cost=$carbsCost SAR), "
          "total for this meal: $mealMacroCost SAR");
    }

    print("💰 Total macro customization cost: ${cost.toStringAsFixed(1)} SAR");
    return cost;
  }



  double getMealCountCustomizationCost() {
    double cost = 0.0;
    final selectedConfig = getSelectedChoiceConfig();
    final int daysCount = selectedConfig.daysCount;

    for (var config in planCategory.customisableConfig) {
      int currentCount = mealCounts[config.categoryId]?.value ?? 0;
      int countDifference = currentCount - config.count;
      if (countDifference != 0) {
        double adjustment =
            config.additionalPrice * countDifference * daysCount.toDouble();
        cost += adjustment;
      }
    }
    return cost;
  }

  double calculateTotal() {
    // Check if all meal counts are zero
    bool allMealsZero = true;
    for (var mealCount in mealCounts.values) {
      if (mealCount.value > 0) {
        allMealsZero = false;
        break;
      }
    }

    // Return 0 if all meal counts are zero
    if (allMealsZero) {
      return 0.0;
    }

    // Calculate the total
    double basePrice = getBasePrice();
    double mealCountAdjustment = getMealCountCustomizationCost();
    double macroAdjustment = getMacroCustomizationCost();

    double total = basePrice + mealCountAdjustment + macroAdjustment;

    // Ensure total is never negative
    return max(0.0, total);
  }

  void updateMacros(int categoryId, int protein, int carbs) {
    if (mealProteins.containsKey(categoryId)) {
      mealProteins[categoryId]!.value = protein;
    }
    if (mealCarbs.containsKey(categoryId)) {
      mealCarbs[categoryId]!.value = carbs;
    }
  }

  Widget _buildPriceRow(String label, double amount, bool isAdjustment) {
    return Builder(builder: (context) {
      // Special handling for meal adjustments when displaying
      String displayAmount;
      Color textColor;

      if (isAdjustment) {
        // Get the base price and calculate the potential total
        double basePrice = getBasePrice();
        double macroAdjustment = getMacroCustomizationCost();
        double mealCountAdjustment = getMealCountCustomizationCost();
        double rawTotal = basePrice + macroAdjustment + mealCountAdjustment;

        // If this is the meal adjustment row and the total would be negative
        if (label == "Meal Adjustments".tr && rawTotal <= 0 && amount < 0) {
          // Display adjustment exactly equal to negative base price
          displayAmount = "- ${basePrice.toStringAsFixed(1)} KWD";
          textColor = Colors.red;
        } else {
          // Normal display for adjustments
          displayAmount = (amount >= 0 ? "+ " : "- ") +
              "${amount.abs().toStringAsFixed(1)} KWD";
          textColor = amount >= 0 ? APPSTYLE_PrimaryColor : Colors.red;
        }
      } else {
        // Normal display for non-adjustments
        displayAmount = "${amount.toStringAsFixed(1)} KWDt";
        textColor = APPSTYLE_Black;
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: getBodyMediumStyle(context).copyWith(
              fontSize: 12,
              color: APPSTYLE_Grey60,
            ),
          ),
          Text(
            displayAmount,
            style: getBodyMediumStyle(context).copyWith(
              fontSize: 12,
              fontWeight: isAdjustment ? FontWeight.normal : FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      );
    });
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Obx(() => Container(
            height: MediaQuery.of(context).size.height *
                0.92, // Slightly reduced height
            decoration: BoxDecoration(
              color: APPSTYLE_BackgroundWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Drag handle for better UX
                  Container(
                    width: 40,
                    height: 4,
                    margin: EdgeInsets.only(top: 8, bottom: 4),
                    decoration: BoxDecoration(
                      color: APPSTYLE_Grey40,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // Header with close button and help button
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: APPSTYLE_SpaceMedium,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            // Save state before closing
                            saveBottomSheetState();
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: APPSTYLE_PrimaryColor,
                            ),
                            child: Icon(Icons.close,
                                color: Colors.white, size: 16),
                          ),
                        ),
                        Text(
                          planName,
                          style: getBodyMediumStyle(context).copyWith(
                            fontWeight: APPSTYLE_FontWeightBold,
                            fontSize: 18,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.phone_in_talk, size: 16),
                          label: Text(
                            'Need Help?'.tr,
                            style: getBodyMediumStyle(context).copyWith(
                              fontSize: 12,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            foregroundColor: APPSTYLE_Grey60,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 1, thickness: 1, color: APPSTYLE_Grey20),

                  // Plan duration selector (updated to use .value)
                  Padding(
                    padding: EdgeInsets.only(
                      left: APPSTYLE_SpaceMedium,
                      right: APPSTYLE_SpaceMedium,
                      top: 12,
                      bottom: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Plan Choice".tr,
                          style: getBodyMediumStyle(context).copyWith(
                            fontWeight: APPSTYLE_FontWeightBold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: APPSTYLE_PrimaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          child: DropdownButton<String>(
                            value:
                                selectedPlanDuration.value, // Use .value here
                            dropdownColor: APPSTYLE_PrimaryColor,
                            style: getBodyMediumStyle(context).copyWith(
                              color: Colors.white,
                              fontWeight: APPSTYLE_FontWeightBold,
                              fontSize: 12,
                            ),
                            icon: Icon(Icons.keyboard_arrow_down,
                                color: Colors.white, size: 16),
                            underline: SizedBox(),
                            isDense: true,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                selectedPlanDuration.value =
                                    newValue; // Use .value for reactive update
                                selectedChoiceConfigId.value =
                                    -1; // Reset choice when duration changes
                              }
                            },
                            items: planDurations
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Container for grid with a divider
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: APPSTYLE_SpaceMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                            height: 8, thickness: 0.5, color: APPSTYLE_Grey20),
                        SizedBox(height: 12),

                        // Layout for plan choices in a container with border
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border:
                                Border.all(color: APPSTYLE_Grey20, width: 0.5),
                          ),
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Choose Required Days".tr,
                                style: getBodyMediumStyle(context).copyWith(
                                  fontWeight: APPSTYLE_FontWeightBold,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 12),

                              // Square plan choices with fixed size - use .value for reactive update
                              _buildPlanChoiceSquares(
                                  context,
                                  getFilteredChoiceConfigs(
                                      selectedPlanDuration.value),
                                  selectedChoiceConfigId),
                            ],
                          ),
                        ),

                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                  // Improved meal customization section with accordion-style UI
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(top: 5),
                      children: [
                        // More compact list of meal customizations
                        ...planCategory.customisableConfig.map((config) {
                          bool showEdit = config.isCustomisable;
                          int? proteinValue = showEdit
                              ? mealProteins[config.categoryId]?.value
                              : null;
                          int? carbsValue = showEdit
                              ? mealCarbs[config.categoryId]?.value
                              : null;

                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: APPSTYLE_SpaceSmall, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 3,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Left side: meal info
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          getLocalizedCategoryName(config),
                                          style: getBodyMediumStyle(context)
                                              .copyWith(
                                            fontWeight: APPSTYLE_FontWeightBold,
                                            fontSize: 13,
                                          ),
                                        ),
                                        if (showEdit &&
                                            proteinValue != null &&
                                            carbsValue != null)
                                          Container(
                                            margin: EdgeInsets.only(top: 2),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                // Protein badge
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: APPSTYLE_PrimaryColor
                                                        .withOpacity(0.08),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        "${proteinValue}g",
                                                        style:
                                                            getBodyMediumStyle(
                                                                    context)
                                                                .copyWith(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        " ${"P".tr}",
                                                        style:
                                                            getBodyMediumStyle(
                                                                    context)
                                                                .copyWith(
                                                          fontSize: 10,
                                                          color:
                                                              APPSTYLE_Grey60,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                SizedBox(width: 4),

                                                // Carbs badge
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: APPSTYLE_PrimaryColor
                                                        .withOpacity(0.08),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        "${carbsValue}g",
                                                        style:
                                                            getBodyMediumStyle(
                                                                    context)
                                                                .copyWith(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        " ${"C".tr}",
                                                        style:
                                                            getBodyMediumStyle(
                                                                    context)
                                                                .copyWith(
                                                          fontSize: 10,
                                                          color:
                                                              APPSTYLE_Grey60,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                SizedBox(width: 4),

                                                // Edit button
                                                if (config.isCustomisable)
                                                  InkWell(
                                                    onTap: () {
                                                      int safeProtein =
                                                          proteinValue ?? 100;
                                                      int safeCarbs =
                                                          carbsValue ?? 100;
                                                      int minProtein =
                                                          config.proteinLowLimit >
                                                                  0
                                                              ? config
                                                                  .proteinLowLimit
                                                              : 50;
                                                      int maxProtein = config
                                                                  .proteinHighLimit >
                                                              minProtein
                                                          ? config
                                                              .proteinHighLimit
                                                          : minProtein + 50;
                                                      int minCarbs =
                                                          config.carbLowLimit >
                                                                  0
                                                              ? config
                                                                  .carbLowLimit
                                                              : 50;
                                                      int maxCarbs =
                                                          config.carbHighLimit >
                                                                  minCarbs
                                                              ? config
                                                                  .carbHighLimit
                                                              : minCarbs + 50;

                                                      showFoodPortionCustomizer(
                                                        context,
                                                        categoryName:
                                                            getLocalizedCategoryName(
                                                                config),
                                                        initialProtein:
                                                            safeProtein,
                                                        initialCarbs: safeCarbs,
                                                        minProtein: minProtein,
                                                        maxProtein: maxProtein,
                                                        stepProtein: config
                                                                    .proteinStepValue >
                                                                0
                                                            ? config
                                                                .proteinStepValue
                                                            : 5,
                                                        minCarbs: minCarbs,
                                                        maxCarbs: maxCarbs,
                                                        stepCarbs:
                                                            config.carbStepValue >
                                                                    0
                                                                ? config
                                                                    .carbStepValue
                                                                : 5,
                                                        onSave:
                                                            (protein, carbs) {
                                                          updateMacros(
                                                              config.categoryId,
                                                              protein,
                                                              carbs);
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 6,
                                                              vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            APPSTYLE_PrimaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                      ),
                                                      child: Text(
                                                        "Edit".tr,
                                                        style:
                                                            getBodyMediumStyle(
                                                                    context)
                                                                .copyWith(
                                                          fontSize: 10,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),

                                  // Right side: meal counter
                                  Container(
                                    height: 28, // Smaller height
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          color: APPSTYLE_Grey30, width: 0.5),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Minus button
                                        InkWell(
                                          onTap: () {
                                            if (mealCounts[config.categoryId]!
                                                    .value >
                                                0) {
                                              mealCounts[config.categoryId]!
                                                  .value--;
                                            }
                                          },
                                          child: Container(
                                            width: 28, // Smaller size
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(6),
                                                bottomLeft: Radius.circular(6),
                                              ),
                                              color: APPSTYLE_Grey10,
                                            ),
                                            child: Icon(Icons.remove,
                                                color: APPSTYLE_Grey60,
                                                size: 14),
                                          ),
                                        ),

                                        // Count display
                                        Container(
                                          width: 28, // Smaller size
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              left: BorderSide(
                                                  color: APPSTYLE_Grey30,
                                                  width: 0.5),
                                              right: BorderSide(
                                                  color: APPSTYLE_Grey30,
                                                  width: 0.5),
                                            ),
                                          ),
                                          child: Text(
                                            "${mealCounts[config.categoryId]!.value}",
                                            style: getBodyMediumStyle(context)
                                                .copyWith(
                                              fontWeight:
                                                  APPSTYLE_FontWeightBold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),

                                        // Plus button
                                        InkWell(
                                          onTap: () {
                                            mealCounts[config.categoryId]!
                                                .value++;
                                          },
                                          child: Container(
                                            width: 28, // Smaller size
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(6),
                                                bottomRight: Radius.circular(6),
                                              ),
                                              color: APPSTYLE_PrimaryColor,
                                            ),
                                            child: Icon(Icons.add,
                                                color: Colors.white, size: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),

                        SizedBox(height: 16),

                        // Price breakdown with cleaner styling
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: APPSTYLE_SpaceMedium),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Price Summary".tr,
                                style: getBodyMediumStyle(context).copyWith(
                                  fontWeight: APPSTYLE_FontWeightBold,
                                  fontSize: 14,
                                ),
                              ),
                              Divider(height: 16),
                              _buildPriceRow(
                                  "Base Plan".tr, getBasePrice(), false),
                              SizedBox(height: 4),
                              _buildPriceRow("Meal Adjustments".tr,
                                  getMealCountCustomizationCost(), true),
                              SizedBox(height: 4),
                              _buildPriceRow("Macro Adjustments".tr,
                                  getMacroCustomizationCost(), true),
                              SizedBox(height: 8),
                              Divider(),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total".tr,
                                    style: getBodyMediumStyle(context).copyWith(
                                      fontWeight: APPSTYLE_FontWeightBold,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        calculateTotal().toStringAsFixed(1),
                                        style: getHeadlineLargeStyle(context)
                                            .copyWith(
                                          color: APPSTYLE_PrimaryColor,
                                          fontWeight: APPSTYLE_FontWeightBold,
                                        ),
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "SAR",
                                        style: getBodyMediumStyle(context)
                                            .copyWith(
                                          color: APPSTYLE_PrimaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 2),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "including_tax".tr,
                                  style: getBodyMediumStyle(context).copyWith(
                                    fontSize: 9,
                                    color: APPSTYLE_Grey60,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 70), // Space for button
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      left: APPSTYLE_SpaceLarge,
                      right: APPSTYLE_SpaceLarge,
                      bottom: 30,
                      top: 0, // No top padding
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (selectedChoiceConfigId.value == -1) {
                            // Show error message if no plan choice is selected
                            showSnackbar(
                                context,
                                "Please select a plan duration (month/week/day) before continuing."
                                    .tr,
                                "error");
                            return;
                          }
                          final hasAnyMeal =
                              mealCounts.values.any((rx) => rx.value > 0);
                          if (!hasAnyMeal) {
                            showSnackbar(
                                context,
                                "Please select at least one meal (breakfast, main course, salad, snack, or soup) to continue."
                                    .tr,
                                "error");
                            return;
                          }
                          final selectedConfig = getSelectedChoiceConfig();

                          // Log the selected choice config ID before continuing
                          print(
                              "🔍 Selected choice config ID: ${selectedConfig.id}, Name: ${selectedConfig.name}");

                          // Save state before proceeding
                          saveBottomSheetState();

                          controller.currentCategory.value = planCategory;

                          // Create a subscription plan object directly from the selected choice config if no matching one is found
                          var matchingSubscription = controller.subscriptions
                              .firstWhere((sub) => sub.id == selectedConfig.id,
                                  orElse: () {
                            print(
                                "⚠️ No matching subscription found for ID ${selectedConfig.id}. Creating one from selected config.");

                            // Create a subscription plan directly from the choice config
                            return SubscriptionPlan(
                              id: selectedConfig.id,
                              price: selectedConfig.price,
                              name: selectedConfig.name,
                              arabicName: selectedConfig.arabicName,
                              durationTypeArabic:
                                  selectedConfig.durationType.name,
                              offerText: selectedConfig.daysCount.toString(),
                              strikePrice: 0.0,
                              days: selectedConfig.daysCount.toString(),
                              durationType: selectedConfig.durationType.name,
                              carbohydrates: planCategory.carbs.toDouble(),
                              protein: planCategory.protein.toDouble(),
                              dayAvailability: {
                                1: true,
                                2: true,
                                3: true,
                                4: true,
                                5: true,
                                6: true,
                                7: true
                              },
                              mealsConfig: planCategory.mealsConfig,
                              mealsConfigArabic: planCategory.mealsConfigArabic,
                            );
                          });

                          print(
                              "🔄 Using subscription: ID=${matchingSubscription.id}, Name=${matchingSubscription.name}");

                          controller.changeSubscription(matchingSubscription);
                          double customizationCost =
                              getMealCountCustomizationCost() +
                                  getMacroCustomizationCost();
                          if (customizationCost != 0) {
                            controller.total.value =
                                controller.total.value + customizationCost;
                          }

                          // Transfer customization selections to controller
                          for (var config in planCategory.customisableConfig) {
                            int categoryId = config.categoryId;
                            if (mealCounts.containsKey(categoryId)) {
                              controller.customMealCounts[categoryId] =
                                  mealCounts[categoryId]!.value;
                            }
                            if (config.isCustomisable) {
                              if (mealProteins.containsKey(categoryId)) {
                                controller.customMealProteins[categoryId] =
                                    mealProteins[categoryId]!.value;
                              }
                              if (mealCarbs.containsKey(categoryId)) {
                                controller.customMealCarbs[categoryId] =
                                    mealCarbs[categoryId]!.value;
                              }
                            }
                          }
                          controller.customizedPrice =
                              getMealCountCustomizationCost() +
                                  getMacroCustomizationCost();

                          Navigator.pop(context);
                          controller.planChoiceSelected();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: APPSTYLE_PrimaryColor,
                          padding: EdgeInsets.zero,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: (Localizations.localeOf(context)
                                            .languageCode ==
                                        'ar')
                                    ? 0
                                    : APPSTYLE_SpaceMedium,
                                right: (Localizations.localeOf(context)
                                            .languageCode ==
                                        'ar')
                                    ? APPSTYLE_SpaceMedium
                                    : 0,
                              ),
                              child: Text(
                                "continue".tr,
                                style: getHeadlineLargeStyle(context).copyWith(
                                  color: APPSTYLE_BackgroundOffWhite,
                                  fontWeight: APPSTYLE_FontWeightBold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: APPSTYLE_BackgroundOffWhite,
                              ),
                              width: 38,
                              height: 38,
                              child: Icon(
                                (Localizations.localeOf(context).languageCode ==
                                        'ar')
                                    ? Ionicons.arrow_back
                                    : Ionicons.arrow_forward,
                                color: APPSTYLE_PrimaryColor,
                                size: 18,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
    },
  );
  // Helper function to build price row
}

Widget _buildPlanChoiceSquares(BuildContext context, List<ChoiceConfig> configs,
    RxInt selectedChoiceConfigId) {
  // Create lists of configs for each row (3 per row)
  List<List<ChoiceConfig>> rows = [];
  for (var i = 0; i < configs.length; i += 3) {
    var end = (i + 3 <= configs.length) ? i + 3 : configs.length;
    rows.add(configs.sublist(i, end));
  }

  // Fixed size for squares
  final double squareSize = 90.0;
  final double spacing = 10.0;

  return Column(
    children: rows.map((rowConfigs) {
      return Column(
        children: [
          // Center the row contents
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...rowConfigs.map((config) {
                String name = Get.locale?.languageCode == 'ar' &&
                        config.arabicName.isNotEmpty
                    ? config.arabicName
                    : config.name;
                bool isSelected = selectedChoiceConfigId.value == config.id;

                // Extract number and description
                String displayNumber = "";
                String description = "";
                RegExp regExp = RegExp(r'(\d+)');
                var matches = regExp.firstMatch(name);
                if (matches != null) {
                  displayNumber = matches.group(1)!;
                  description = name.replaceFirst(displayNumber, '').trim();
                } else {
                  description = name;
                }

                return Padding(
                  padding: EdgeInsets.only(right: spacing),
                  child: GestureDetector(
                    onTap: () {
                      selectedChoiceConfigId.value = config.id;
                    },
                    child: Container(
                      width: squareSize,
                      height: squareSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: isSelected
                            ? APPSTYLE_PrimaryColor
                            : const Color(0xFFF9F1E7),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (displayNumber.isNotEmpty)
                                  Text(
                                    displayNumber,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Colors.white
                                          : APPSTYLE_Black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                if (description.isNotEmpty)
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    child: Text(
                                      description,
                                      style:
                                          getBodyMediumStyle(context).copyWith(
                                        color: isSelected
                                            ? Colors.white
                                            : APPSTYLE_Grey60,
                                        fontSize: 9,
                                        height: 1.0,
                                      ),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Positioned(
                              top: 4,
                              right: 4,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: APPSTYLE_PrimaryColor,
                                  size: 8,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
          // Add extra spacing after each row
          SizedBox(height: 12),
        ],
      );
    }).toList(),
  );
}
