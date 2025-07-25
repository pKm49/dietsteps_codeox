import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../shared_module/constants/style_params.constants.shared.dart';
import '../../../../shared_module/constants/widget_styles.constants.shared.dart';
import '../../../../shared_module/services/utility-services/widget_generator.service.shared.dart';
import '../../../../shared_module/services/utility-services/widget_properties_generator.service.shared.dart';

void showFoodPortionCustomizer(
  BuildContext context, {
  // Initial values
  required int initialProtein,
  required int initialCarbs,
  // Min/Max/Step values from API
  required int minProtein,
  required int maxProtein,
  required int stepProtein,
  required int minCarbs,
  required int maxCarbs,
  required int stepCarbs,
  // Category information for display
  required String categoryName,
  // Callback for when values are saved
  required Function(int protein, int carbs) onSave,
}) {
  // Use RxDouble to enable smoother animations with Obx widget
  final Rx<double> carbsValue = initialCarbs.toDouble().obs;
  final Rx<double> proteinValue = initialProtein.toDouble().obs;

  // Calculate divisions for sliders based on step values
  final proteinDivisions = ((maxProtein - minProtein) / stepProtein).round();
  final carbsDivisions = ((maxCarbs - minCarbs) / stepCarbs).round();

  // Responsive plate dimensions - adjust based on screen size
  final screenWidth = MediaQuery.of(context).size.width;
  final isSmallScreen = screenWidth < 360;
  final plateSize = min(screenWidth * 0.6, 240.0);
  final plateContentRadius = plateSize * 0.42;

  // Colors for better visual appeal
  final proteinColor = Colors.brown[500]!;
  final carbsColor = APPSTYLE_PrimaryColor;

  // Predefined quick selection values - updated to use multiples of 50 when possible
  final proteinPresets = _generatePresets(minProtein, maxProtein, 50);
  final carbsPresets = _generatePresets(minCarbs, maxCarbs, 50);

  // Animation controller for plate visual transitions
  final plateAnimationDuration = const Duration(milliseconds: 300);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: EdgeInsets.symmetric(
            horizontal: min(16, screenWidth * 0.04), vertical: 24),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          constraints: BoxConstraints(
            maxHeight:
                MediaQuery.of(context).size.height * 0.85, // Prevent overflow
          ),
          padding: EdgeInsets.all(isSmallScreen ? 12 : 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Obx(() {
            // Calculate food sizes with animation
            final proteinScale = _calculateScale(proteinValue.value,
                minProtein.toDouble(), maxProtein.toDouble());
            final carbsScale = _calculateScale(
                carbsValue.value, minCarbs.toDouble(), maxCarbs.toDouble());

            return SingleChildScrollView(
              // Make the entire content scrollable
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header with category name and close button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new, size: 18),
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        splashRadius: 20,
                      ),
                      Expanded(
                        child: Text(
                          categoryName,
                          style: getHeadlineLargeStyle(context).copyWith(
                            fontWeight: APPSTYLE_FontWeightBold,
                            fontSize: min(
                                getHeadlineLargeStyle(context).fontSize ?? 18.0,
                                screenWidth * 0.05),
                          ),
                          textAlign: TextAlign.center,
                          overflow:
                              TextOverflow.ellipsis, // Prevent text overflow
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(width: 24), // Balancing space
                    ],
                  ),

                  addVerticalSpace(isSmallScreen ? 12 : 16),

                  // Current macros pill
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 16 : 24),
                    padding: EdgeInsets.symmetric(
                        vertical: isSmallScreen ? 8 : 10,
                        horizontal: isSmallScreen ? 12 : 16),
                    decoration: BoxDecoration(
                      color: APPSTYLE_PrimaryColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                          color: APPSTYLE_PrimaryColor.withOpacity(0.2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.fitness_center,
                                size: isSmallScreen ? 14 : 16,
                                color: proteinColor),
                            SizedBox(width: 4),
                            Text(
                              "${proteinValue.value.toInt()}g ${"protein".tr}",
                              style: getBodyMediumStyle(context).copyWith(
                                fontWeight: FontWeight.w600,
                                color: proteinColor,
                                fontSize: isSmallScreen ? 12 : null,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            width: 1,
                            height: 20,
                            color: APPSTYLE_Grey30,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.grain,
                                size: isSmallScreen ? 14 : 16,
                                color: carbsColor),
                            SizedBox(width: 4),
                            Text(
                              "${carbsValue.value.toInt()}g ${"carbs".tr}",
                              style: getBodyMediumStyle(context).copyWith(
                                fontWeight: FontWeight.w600,
                                color: carbsColor,
                                fontSize: isSmallScreen ? 12 : null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  addVerticalSpace(isSmallScreen ? 12 : 16),

                  // Food visualization with plate and food images
                  Center(
                    child: Container(
                      height: plateSize,
                      width: plateSize,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Base plate with shadow for better depth
                          Container(
                            width: plateSize,
                            height: plateSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'assets/images/plate.png',
                              width: plateSize,
                              height: plateSize,
                              fit: BoxFit.contain,
                            ),
                          ),

                          // Container to keep food items within plate boundaries
                          ClipOval(
                            child: SizedBox(
                              width: plateSize *
                                  0.75, // Restrict to 75% of plate size
                              height: plateSize * 0.75,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Protein portion (chicken) with animation
                                  AnimatedPositioned(
                                    duration: plateAnimationDuration,
                                    curve: Curves.easeInOut,
                                    left:
                                        plateSize * 0.18, // Position from left
                                    child: AnimatedOpacity(
                                      duration: plateAnimationDuration,
                                      opacity: (minProtein == 0 &&
                                              proteinValue.value == 0)
                                          ? 0.0
                                          : 1.0,
                                      child: AnimatedContainer(
                                        duration: plateAnimationDuration,
                                        width:
                                            plateContentRadius * proteinScale,
                                        height:
                                            plateContentRadius * proteinScale,
                                        child: Transform.rotate(
                                          angle: 20 *
                                              (3.14159 /
                                                  180), // 20 degrees in radians
                                          child: Image.asset(
                                            'assets/images/chicken.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Carbs portion (rice) with animation
                                  AnimatedPositioned(
                                    duration: plateAnimationDuration,
                                    curve: Curves.easeInOut,
                                    right:
                                        plateSize * 0.18, // Position from right
                                    bottom: plateSize * 0.0001 -
                                        ((carbsScale - 0.2) *
                                            plateContentRadius *
                                            0.5),
                                    child: AnimatedOpacity(
                                      duration: plateAnimationDuration,
                                      opacity: (minCarbs == 0 &&
                                              carbsValue.value == 0)
                                          ? 0.0
                                          : 1.0,
                                      child: AnimatedContainer(
                                        duration: plateAnimationDuration,
                                        width: plateContentRadius * carbsScale +
                                            (isSmallScreen ? 50 : 70),
                                        height:
                                            plateContentRadius * carbsScale +
                                                (isSmallScreen ? 50 : 70),
                                        child: Image.asset(
                                          'assets/images/rice.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  addVerticalSpace(isSmallScreen ? 16 : 24),

                  // Carbs controls with improved design
                  _buildNutrientControlSection(
                    context: context,
                    title: "carbs".tr,
                    value: carbsValue,
                    min: minCarbs,
                    max: maxCarbs,
                    step: stepCarbs,
                    divisions: carbsDivisions,
                    iconPath: 'assets/images/rice.png',
                    color: carbsColor,
                    presetValues: carbsPresets,
                    isSmallScreen: isSmallScreen,
                  ),

                  addVerticalSpace(isSmallScreen ? 12 : 16),

                  // Protein controls with improved design
                  _buildNutrientControlSection(
                    context: context,
                    title: "protein".tr,
                    value: proteinValue,
                    min: minProtein,
                    max: maxProtein,
                    step: stepProtein,
                    divisions: proteinDivisions,
                    iconPath: 'assets/images/chicken.png',
                    color: proteinColor,
                    presetValues: proteinPresets,
                    isSmallScreen: isSmallScreen,
                  ),

                  addVerticalSpace(isSmallScreen ? 16 : 24),

                  // Action buttons with modern design
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: APPSTYLE_Grey10,
                            padding: EdgeInsets.symmetric(
                                vertical: isSmallScreen ? 12 : 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "cancel".tr,
                            style: getBodyMediumStyle(context).copyWith(
                              color: APPSTYLE_Grey80,
                              fontWeight: FontWeight.w500,
                              fontSize: isSmallScreen ? 13 : null,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: APPSTYLE_PrimaryColor,
                            padding: EdgeInsets.symmetric(
                                vertical: isSmallScreen ? 12 : 14),
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            // Add haptic feedback
                            HapticFeedback.mediumImpact();

                            // Call the onSave callback with the selected values
                            onSave(proteinValue.value.toInt(),
                                carbsValue.value.toInt());
                            Navigator.pop(context);
                          },
                          child: Text(
                            "apply".tr,
                            style: getBodyMediumStyle(context).copyWith(
                              color: Colors.white,
                              fontWeight: APPSTYLE_FontWeightBold,
                              fontSize: isSmallScreen ? 13 : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      );
    },
  );
}

// Helper widget to build each nutrient control section - updated for small screens
Widget _buildNutrientControlSection({
  required BuildContext context,
  required String title,
  required Rx<double> value,
  required int min,
  required int max,
  required int step,
  required int divisions,
  required String iconPath,
  required Color color,
  required List<int> presetValues,
  required bool isSmallScreen,
}) {
  // For very small screens, limit the number of presets shown
  List<int> displayPresets = presetValues;
  if (isSmallScreen && presetValues.length > 4) {
    // Keep min, max, and 2 middle values if we have too many presets for small screens
    displayPresets = [
      presetValues.first,
      presetValues[(presetValues.length / 3).round()],
      presetValues[(presetValues.length * 2 / 3).round()],
      presetValues.last,
    ];
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Title row with icon and current value
      Row(
        children: [
          Container(
            width: isSmallScreen ? 28 : 32,
            height: isSmallScreen ? 28 : 32,
            padding: EdgeInsets.all(isSmallScreen ? 4 : 5),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(iconPath, fit: BoxFit.contain),
          ),
          SizedBox(width: 8),
          Text(
            title,
            style: getBodyMediumStyle(context).copyWith(
              fontWeight: APPSTYLE_FontWeightBold,
              fontSize: isSmallScreen ? 13 : null,
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 8 : 10,
                vertical: isSmallScreen ? 3 : 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withOpacity(0.3), width: 1),
            ),
            child: Obx(() => Text(
                  "${value.value.toInt()} g",
                  style: getBodyMediumStyle(context).copyWith(
                    fontWeight: APPSTYLE_FontWeightBold,
                    color: color,
                    fontSize: isSmallScreen ? 12 : null,
                  ),
                )),
          ),
        ],
      ),

      SizedBox(height: isSmallScreen ? 6 : 8),

      // Quick select buttons
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          children: [
            ...displayPresets
                .map(
                  (preset) => Padding(
                    padding: EdgeInsets.only(right: isSmallScreen ? 6 : 8),
                    child: Obx(
                      () => OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: value.value.toInt() == preset
                              ? color.withOpacity(0.1)
                              : Colors.transparent,
                          side: BorderSide(
                            color: value.value.toInt() == preset
                                ? color
                                : APPSTYLE_Grey30,
                            width: value.value.toInt() == preset ? 1.5 : 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: Size(0, isSmallScreen ? 24 : 28),
                          padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 8 : 12),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          value.value = preset.toDouble();
                          // Add haptic feedback
                          HapticFeedback.selectionClick();
                        },
                        child: Text(
                          "$preset g",
                          style: getBodyMediumStyle(context).copyWith(
                            color: value.value.toInt() == preset
                                ? color
                                : APPSTYLE_Grey60,
                            fontWeight: value.value.toInt() == preset
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: isSmallScreen ? 11 : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),

      SizedBox(height: isSmallScreen ? 6 : 8),

      // Improved slider
      SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: color,
          inactiveTrackColor: APPSTYLE_Grey20,
          thumbColor: Colors.white,
          overlayColor: color.withOpacity(0.2),
          trackHeight: isSmallScreen ? 4 : 6,
          thumbShape: _CustomSliderThumbShape(
              color: color, size: isSmallScreen ? 18 : 20),
          overlayShape:
              RoundSliderOverlayShape(overlayRadius: isSmallScreen ? 16 : 20),
          tickMarkShape: SliderTickMarkShape.noTickMark,
          showValueIndicator: ShowValueIndicator.always,
        ),
        child: Obx(
          () => Slider(
            value: value.value,
            min: min.toDouble(),
            max: max.toDouble(),
            divisions: divisions,
            label: "${value.value.toInt()}g",
            onChanged: (newValue) {
              // Round to the nearest step value
              value.value = (newValue / step).round() * step.toDouble();
            },
          ),
        ),
      ),

      // Min and max labels
      Padding(
        padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$min g",
              style: getBodyMediumStyle(context).copyWith(
                color: APPSTYLE_Grey60,
                fontSize: isSmallScreen ? 11 : null,
              ),
            ),
            Text(
              "$max g",
              style: getBodyMediumStyle(context).copyWith(
                color: APPSTYLE_Grey60,
                fontSize: isSmallScreen ? 11 : null,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// Custom slider thumb for better UX - updated for small screens
class _CustomSliderThumbShape extends SliderComponentShape {
  final Color color;
  final double size;

  _CustomSliderThumbShape({required this.color, this.size = 20});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(size, size);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    // Outer circle
    final Paint outerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, size / 2, outerPaint);

    // Inner white circle
    final Paint innerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, size / 3, innerPaint);
  }
}

// Helper function to calculate size based on gram value with min/max range
double _calculateScale(double value, double min, double max) {
  const minSizeRatio = 0.5;
  const maxSizeRatio = 1.0;

  if (value <= min) return minSizeRatio;

  // Normalize the value to a 0-1 range
  double normalizedValue = (value - min) / (max - min);

  // Scale to the appropriate range
  return minSizeRatio + normalizedValue * (maxSizeRatio - minSizeRatio);
}

// Helper function to generate presets in multiples of 50 when possible
List<int> _generatePresets(int min, int max, int preferredStep) {
  // Always include min and max
  List<int> presets = [min];

  // Calculate range
  int range = max - min;

  // If range is small, don't try to add intermediate values
  if (range <= preferredStep) {
    presets.add(max);
    return presets;
  }

  // If the range is large enough for multiple full steps of preferredStep
  if (range >= preferredStep * 2) {
    // Try to add values at exact multiples of preferredStep (50)
    int current = min;
    while (current + preferredStep < max) {
      current += preferredStep;
      presets.add(current);
    }
  } else {
    // For smaller ranges, aim for approximately 4 evenly spaced values
    // Always keep the min, add 2 intermediate points, and the max
    int step =
        (range / 3).round(); // Divide the range into 3 segments for 4 points

    // Round step to the nearest multiple of 5 for cleaner numbers
    step = (step / 5).round() * 5;

    if (step > 0) {
      presets.add(min + step);
      presets.add(min + step * 2);
    }
  }

  // Always add the max if it's not already in the list
  if (presets.last != max) {
    presets.add(max);
  }

  return presets;
}
