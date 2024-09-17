import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/valid_phoneverification_modes.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/form_validator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OtpVerificationMobileInputPage_Shared extends StatefulWidget {
  const OtpVerificationMobileInputPage_Shared({super.key});

  @override
  State<OtpVerificationMobileInputPage_Shared> createState() => _OtpVerificationMobileInputPage_SharedState();
}

class _OtpVerificationMobileInputPage_SharedState extends State<OtpVerificationMobileInputPage_Shared> {

  var getArguments = Get.arguments;
  final sharedController = Get.find<SharedController>();
  VALIDPHONEVERIFICATION_MODES phoneVerificationMode = VALIDPHONEVERIFICATION_MODES.register;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneVerificationMode = getArguments[0]??VALIDPHONEVERIFICATION_MODES.register;

  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: APPSTYLE_BackgroundWhite,
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        title: Row(
          children: [
            CustomBackButton(isPrimaryMode:false),
          ],
        ),
        actions: [
          LanguagePreviewButtonComponentShared(textColor:APPSTYLE_PrimaryColor),
          addHorizontalSpace(APPSTYLE_SpaceLarge)
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: Obx(
        ()=> Container(
          width: screenwidth,
          height: screenheight,
          padding: APPSTYLE_LargePaddingAll.copyWith(top: 0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Image.asset(ASSETS_MOBILEVERIFICATION, width: screenwidth*.8),
                       ],
                     ),
                    addVerticalSpace(APPSTYLE_SpaceLarge ),
                    Text(phoneVerificationMode== VALIDPHONEVERIFICATION_MODES.reset_password?"forgot_password_q".tr:"verify_your_number".tr,
                        textAlign: TextAlign.center,
                        style: getHeadlineLargeStyle(context).copyWith(
                            fontSize: APPSTYLE_FontSize24*1.5 )),
                    addVerticalSpace(APPSTYLE_SpaceLarge),
                    Text(phoneVerificationMode== VALIDPHONEVERIFICATION_MODES.reset_password ?"forgot_password_info".tr:"enter_mobile".tr,
                        textAlign: TextAlign.center,
                        style: getHeadlineMediumStyle(context).copyWith()),
                    addVerticalSpace(APPSTYLE_SpaceLarge*2),
                    TextFormField(
                      controller: sharedController.mobileTextEditingController.value,
                        validator: (value) => checkIfMobileNumberValid(value),
                        keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                        decoration: InputDecoration(
                            labelText: 'mobile_number'.tr ,
                            hintText: 'enter_mobile_number'.tr
                        )),
                     addVerticalSpace(APPSTYLE_SpaceLarge ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 0,vertical: APPSTYLE_SpaceSmall),
                child:  SizedBox(
                    width:  double.infinity,
                    child: ElevatedButton(
                        child: sharedController.isOtpSending.value?
                        LoadingAnimationWidget.staggeredDotsWave(
                          color: APPSTYLE_BackgroundWhite,
                          size: 20,
                        )
                        :Text('send_otp'.tr,
                            style: getHeadlineMediumStyle(context).copyWith(
                                color: APPSTYLE_BackgroundWhite,fontWeight: APPSTYLE_FontWeightBold),
                            textAlign: TextAlign.center),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          sharedController.sendOtp(phoneVerificationMode==VALIDPHONEVERIFICATION_MODES.reset_password,true);
                        })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
