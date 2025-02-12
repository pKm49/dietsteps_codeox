
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_curve_shape.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsPage_Core extends StatelessWidget {
  const TermsPage_Core({super.key});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: APPSTYLE_PrimaryColor,
        scrolledUnderElevation:0.0,
        elevation: 0.0,
        title: Row(
          children: [
            CustomBackButton(isPrimaryMode:false),

          ],
        ),
        actions: [
          LanguagePreviewButtonComponentShared(textColor:APPSTYLE_BackgroundWhite),
          addHorizontalSpace(APPSTYLE_SpaceLarge)
        ],
      ) ,
      body: SafeArea(
        child: Column(
          children: [
            CustomCurveShapeComponent_Shared(
              color: APPSTYLE_PrimaryColor,
              title: "terms_n_conditions".tr ,
              subtitle: '',
            ),
            Expanded(
              child: ListView(
              children: [
                Padding(
                  padding: APPSTYLE_LargePaddingAll,
                  child: Text("terms".tr,style: getBodyMediumStyle(context)),
                )

              ],
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
