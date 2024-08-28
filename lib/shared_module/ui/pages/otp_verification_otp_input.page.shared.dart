 
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/valid_addressauthor_modes.constants.shared.dart';
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
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationOtpInputPage_Shared extends StatefulWidget {
  const OtpVerificationOtpInputPage_Shared({super.key});

  @override
  State<OtpVerificationOtpInputPage_Shared> createState() => _OtpVerificationOtpInputPage_SharedState();
}

class _OtpVerificationOtpInputPage_SharedState extends State<OtpVerificationOtpInputPage_Shared> {

  var getArguments = Get.arguments;
  final sharedController = Get.find<SharedController>();
  VALIDPHONEVERIFICATION_MODES phoneVerificationMode = VALIDPHONEVERIFICATION_MODES.register;
  String otp = "111111";

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
      body:  Obx(
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
                        Image.asset(ASSETS_OTPMESSAGE, width: screenwidth*.6),
                      ],
                    ),
                    addVerticalSpace(APPSTYLE_SpaceLarge*3 ),
                    Text("verification_code".tr,
                        textAlign: TextAlign.center,
                        style: getHeadlineLargeStyle(context).copyWith(
                            fontSize: APPSTYLE_FontSize24*1.5 )),
                    addVerticalSpace(APPSTYLE_SpaceLarge),
                    Text("enter_otp".tr.replaceAll("mobile", "+965 ${sharedController.mobileTextEditingController.value.text}"),
                        textAlign: TextAlign.center,
                        style: getHeadlineMediumStyle(context).copyWith()),
                    addVerticalSpace(APPSTYLE_SpaceLarge*2),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: PinCodeTextField(
                            backgroundColor: APPSTYLE_BackgroundWhite,
                            keyboardType: TextInputType.number,
                            appContext: context,
                            length: 6,
                            obscureText: false,
                            pinTheme: PinTheme(
                              inactiveColor: APPSTYLE_Grey40,
                              activeFillColor: APPSTYLE_Grey20,
                              selectedColor: APPSTYLE_Black,
                              selectedFillColor: APPSTYLE_Grey40,
                              inactiveFillColor: APPSTYLE_Grey20,

                              activeColor: APPSTYLE_PrimaryColor,
                              shape: PinCodeFieldShape.underline,
                              borderRadius: BorderRadius.circular(0),
                              errorBorderColor: APPSTYLE_GuideRed,
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                            onCompleted: (pin) {
                              setState(() {

                                otp = pin;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpace(APPSTYLE_SpaceLarge ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("didnt_receive_otp".tr,style: getBodyMediumStyle(context),),
                        addHorizontalSpace(APPSTYLE_SpaceSmall),
                        TextButton(onPressed: (){
                          sharedController.sendOtp(phoneVerificationMode==VALIDPHONEVERIFICATION_MODES.reset_password,true);
                        }, child:  Text("resend".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              decoration: TextDecoration.underline,
                              fontWeight: APPSTYLE_FontWeightBold),))
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 0,vertical: APPSTYLE_SpaceSmall),
                child:   SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        child:   sharedController.isOtpVerifying.value || sharedController.isOtpSending.value?
                        LoadingAnimationWidget.staggeredDotsWave(
                          color: APPSTYLE_BackgroundWhite,
                          size: 20,
                        )
                            : Text('verify_otp'.tr,
                            style: getHeadlineMediumStyle(context).copyWith(
                                color: APPSTYLE_BackgroundWhite,fontWeight: APPSTYLE_FontWeightBold),
                            textAlign: TextAlign.center),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          sharedController.verifyOtp(otp.toString(),phoneVerificationMode==VALIDPHONEVERIFICATION_MODES.reset_password);
                        })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
