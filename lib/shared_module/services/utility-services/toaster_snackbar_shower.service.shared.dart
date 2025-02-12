import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

showSnackbar( BuildContext context, String text, String type){
  double screenwidth = MediaQuery.of(context).size.width;

  if(text==""){
    if(type =="error"){
      Get.rawSnackbar(  message: "something_wrong".tr,
          snackPosition: SnackPosition.TOP,
          borderRadius: APPSTYLE_BorderRadiusSmall,
          maxWidth:screenwidth*.9,
          backgroundColor: APPSTYLE_GuideRed );
    }
  }else{
    Get.rawSnackbar(  message: text,
        snackPosition: SnackPosition.TOP,
        maxWidth:screenwidth*.9,
        borderRadius: APPSTYLE_BorderRadiusSmall,
        backgroundColor: type =='error'?APPSTYLE_GuideRed:APPSTYLE_WhatsappGreen );
  }


//   SnackBar snackBar = SnackBar(
//     content: Text(text),
//     backgroundColor: type =='error'?APPSTYLE_GuideRed:APPSTYLE_GuideGreen,
//   );
//
// // Find the ScaffoldMessenger in the widget tree
// // and use it to show a SnackBar.
//   ScaffoldMessenger.of(context).showSnackBar( snackBar);
}

showToaster( BuildContext context ,Color color,String text){

  FToast fToast = FToast();
  fToast.init(context);
  double screenwidth = MediaQuery.of(context).size.width;

  Widget toast = Container(
    width: screenwidth - (APPSTYLE_SpaceMedium * 2),
    height: 60,
    padding: const EdgeInsets.all(APPSTYLE_SpaceSmall),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: color,
    ),
    clipBehavior: Clip.hardEdge,
    child: Center(child: Text(text,maxLines: 2,style: TextStyle(color: APPSTYLE_BackgroundWhite))),
  );


  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 2),
  );
  // Fluttertoast.showToast(
  //     msg: text,
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: ToastGravity.CENTER,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: Colors.green,
  //     textColor: Colors.white,
  //     fontSize: 16.0
  // );
}