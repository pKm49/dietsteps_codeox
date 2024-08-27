
import 'package:dietsteps/feature_modules/plan_purchase/controllers/plan_purchase.controller.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/ui/components/confirm_dialogue.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
 import 'package:get/get.dart';

class PaymentGatewayWebView_Shared extends StatefulWidget {

  const PaymentGatewayWebView_Shared({Key? key }) : super(key: key);

  @override
  _PaymentGatewayWebView_SharedState createState() => _PaymentGatewayWebView_SharedState();
}

class _PaymentGatewayWebView_SharedState extends State<PaymentGatewayWebView_Shared> {

  late InAppWebViewController controller;

  String paymentCheckUrl="";
  String gatewayUrl="";
  String confirmationUrl="";
  bool isConfirmationReached = false;

  var getArguments = Get.arguments;
  final sharedController = Get.find<SharedController>();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setWebviewController();

  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return  WillPopScope(
        onWillPop: () async {
          return (await showDialog(
            context: context,
            builder: (_) => ConfirmDialogue(
                onClick: () async {
                  Navigator.of(context).pop(true);
                },
                titleKey: 'cancel_booking'.tr + " ?",
                subtitleKey: 'cancel_confirm'.tr),
          )
          ) ?? false;



        },
        child: Obx(
              ()=> Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: APPSTYLE_BackgroundWhite,
              appBar: AppBar(
                title: Text('complete_payment'.tr),
              ),
              body:  InAppWebView(
                initialUrlRequest: URLRequest(url:WebUri(gatewayUrl) ),
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                    )
                ),
                onReceivedServerTrustAuthRequest: (controller, challenge) async {
                  return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
                },
                onWebViewCreated: (InAppWebViewController controller) {
                  controller = controller;
                },
                onUpdateVisitedHistory: (InAppWebViewController controller, Uri? url, bool? flag) {

                  if(url.toString().contains("https://erp.dietstepskw.com/subscription/payment/status") ){
                    isConfirmationReached = true;
                    setState(() {

                    });
                    setBack(true);
                  }
                },
                onLoadStart: (InAppWebViewController controller, Uri? url) {

                },
                onLoadStop: (InAppWebViewController controller, Uri? url) async {

                  if(!url.toString().contains(paymentCheckUrl) ){
                    sharedController.changePaymentGatewayLoading(false);
                  }else{
                    isConfirmationReached = true;
                    setState(() {

                    });
                  }

                },
                onProgressChanged: (InAppWebViewController controller, int progress) {
                  if(!isConfirmationReached){
                    if(progress == 100){
                       sharedController.changePaymentGatewayLoading(false);
                    }else{
                       sharedController.changePaymentGatewayLoading(true);
                    }
                  }


                },
              ),

              //sharedController.paymentGatewayIsLoading.value ||
                  bottomSheet: (sharedController.paymentGatewayIsLoading.value || isConfirmationReached)? Container(
                  width: screenwidth,
                  height: screenheight,
                  color: APPSTYLE_Grey80,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: APPSTYLE_BackgroundWhite,
                    ),
                  ),
                ):Container(width: screenwidth,height: 1,)),
        ),
      );

  }

  void setWebviewController() {
    gatewayUrl = getArguments[0];
    confirmationUrl = getArguments[1];
    paymentCheckUrl = getArguments[2];
    isConfirmationReached = false;
    setState(() {

    });
    // controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {

    //         setState(() {
    //           isLoading = false;
    //         });
    //       },
    //       onWebResourceError: (WebResourceError error) {

    //       },
    //       onNavigationRequest: (NavigationRequest request) {

    //          if (request.url
    //             .contains(confirmationUrl)) {
    //           Future.delayed(const Duration(seconds: 1), () {
    //             //asynchronous delay
    //             // Get.until((route) => Get.currentRoute == '/OrderComplete');
    //             Get.back(result: true);
    //
    //           });
    //         }else{
    //           Get.back(result: false);
    //
    //         }
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   );
    // controller.loadRequest(Uri.parse(gatewayUrl));


  }



  Future<void> setBack(bool status) async {

    sharedController.changePaymentGatewayLoading(false);
    setState(() {
    });

    await Future.delayed(const Duration(seconds: 1));
    sharedController.paymentGatewayGoback(status);

  }
}
