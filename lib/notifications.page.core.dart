
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/date_conversion.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class NotificationsPage_Core extends StatefulWidget {
  NotificationsPage_Core({super.key});

  @override
  State<NotificationsPage_Core> createState() => _NotificationsPage_CoreState();
}

class _NotificationsPage_CoreState extends State<NotificationsPage_Core> {
  final sharedController = Get.find<SharedController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedController.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                  'notifications'.tr,
                  style: getHeadlineLargeStyle(context)
                      .copyWith(fontWeight: APPSTYLE_FontWeightBold),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
        actions: [
          LanguagePreviewButtonComponentShared(
              textColor: APPSTYLE_PrimaryColor),
          addHorizontalSpace(APPSTYLE_SpaceLarge)
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => Container(
            child: Column(
              children: [
                Visibility(
                  visible:  sharedController.isNotificationsFetching.value,
                  child: Expanded(
                      child: ListView(
                    children: [
                      Container(
                        decoration:
                            APPSTYLE_ShadowedContainerSmallDecoration.copyWith(
                                color: APPSTYLE_BackgroundWhite),
                        padding: APPSTYLE_MediumPaddingAll,
                        margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                        width: screenwidth,
                        child: Wrap(
                          direction: Axis.vertical,
                          children: [
                            Shimmer.fromColors(
                              baseColor: APPSTYLE_Grey20,
                              highlightColor: APPSTYLE_Grey40,
                              child: Container(
                                  height: 50,
                                  width: screenwidth -
                                      ((APPSTYLE_SpaceMedium * 2) +
                                          (APPSTYLE_SpaceLarge * 2)),
                                decoration:
                                APPSTYLE_BorderedContainerExtraSmallDecoration
                                    .copyWith(
                                  border: null,
                                  color: APPSTYLE_Grey20,
                                  borderRadius: BorderRadius.circular(
                                      APPSTYLE_BlurRadiusSmall),
                                ),),
                            ),
                            addVerticalSpace(APPSTYLE_SpaceSmall),
                            Shimmer.fromColors(
                              baseColor: APPSTYLE_Grey20,
                              highlightColor: APPSTYLE_Grey40,
                              child: Container(
                                  height: 20,
                                  width: screenwidth * .3,
                                decoration:
                                APPSTYLE_BorderedContainerExtraSmallDecoration
                                    .copyWith(
                                  border: null,
                                  color: APPSTYLE_Grey20,
                                  borderRadius: BorderRadius.circular(
                                      APPSTYLE_BlurRadiusSmall),
                                ),),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
                ),

                Visibility(
                  visible: sharedController.notifications.isNotEmpty &&
                      !sharedController.isNotificationsFetching.value,
                  child: Expanded(
                      child: ListView.builder(
                          itemCount: sharedController.notifications.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration:
                              APPSTYLE_ShadowedContainerSmallDecoration.copyWith(
                                  color: APPSTYLE_BackgroundWhite),
                              padding: APPSTYLE_MediumPaddingAll,
                              margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                              width: screenwidth,
                              child: Wrap(
                                direction: Axis.vertical,
                                children: [

                                  Container(
                                    width: screenwidth -
                                        ((APPSTYLE_SpaceMedium * 2) +
                                            (APPSTYLE_SpaceLarge * 2)),
                                    child: Text(sharedController.notifications[index].message,
                                        style: getBodyMediumStyle(context)
                                            .copyWith(color:APPSTYLE_Grey80 )),
                                  ),
                                  addVerticalSpace(APPSTYLE_SpaceSmall),
                                  Container(
                                    width: screenwidth -
                                        ((APPSTYLE_SpaceMedium * 2) +
                                            (APPSTYLE_SpaceLarge * 2)),
                                    child: Text(getFormattedDate(sharedController.notifications[index].dateTime),
                                        style:getLabelLargeStyle (context).copyWith(
                                            color: APPSTYLE_Grey40,
                                            fontWeight: APPSTYLE_FontWeightLight)),
                                  ),
                                ],
                              ),
                            );
                          }),),
                ),

                Visibility(
                  visible: sharedController.notifications.isEmpty &&
                      !sharedController.isNotificationsFetching.value,
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
                              child: Icon(Icons.notifications_off_outlined,
                                  size: screenwidth * .15,
                                  color: APPSTYLE_Grey80),
                            ),
                          )
                        ],
                      ),
                      addVerticalSpace(APPSTYLE_SpaceLarge),
                      Text("no_notifications".tr,
                          style: getHeadlineMediumStyle(context)),
                    ],
                  )),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }


}
