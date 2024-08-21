
import 'package:dietsteps/feature_modules/plan_purchase/controllers/plan_purchase.controller.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/ui/components/confirm_dialogue.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
 import 'package:get/get.dart';

class PaymentGatewayWebView_PlanPurchase extends StatefulWidget {

  const PaymentGatewayWebView_PlanPurchase({Key? key }) : super(key: key);

  @override
  _PaymentGatewayWebView_PlanPurchaseState createState() => _PaymentGatewayWebView_PlanPurchaseState();
}

class _PaymentGatewayWebView_PlanPurchaseState extends State<PaymentGatewayWebView_PlanPurchase> {

  late InAppWebViewController controller;

  String paymentCheckUrl="";
  String gatewayUrl="";
  String confirmationUrl="";
  bool isConfirmationReached = false;

  var getArguments = Get.arguments;
  final subscriptionsController = Get.find<PlanPurchaseController>();



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

                  if(url.toString().contains("http://68.183.247.240:8069/subscription/payment/status") ){
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
                    subscriptionsController.changePaymentGatewayLoading(false);
                  }else{
                    isConfirmationReached = true;
                    setState(() {

                    });
                  }

                },
                onProgressChanged: (InAppWebViewController controller, int progress) {
                  if(!isConfirmationReached){
                    if(progress == 100){
                       subscriptionsController.changePaymentGatewayLoading(false);
                    }else{
                       subscriptionsController.changePaymentGatewayLoading(true);
                    }
                  }


                },
              ),

              //sharedController.paymentGatewayIsLoading.value ||
                  bottomSheet: (subscriptionsController.paymentGatewayIsLoading.value || isConfirmationReached)? Container(
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

    subscriptionsController.changePaymentGatewayLoading(false);
    setState(() {
    });

    await Future.delayed(const Duration(seconds: 1));
    subscriptionsController.paymentGatewayGoback(status);

  }
}
