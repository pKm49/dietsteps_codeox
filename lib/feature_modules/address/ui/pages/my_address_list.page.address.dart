 import 'package:dietsteps/feature_modules/address/controllers/address.controller.dart';
 import 'package:dietsteps/feature_modules/address/ui/components/address_card.component.address.dart';
 import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/valid_addressauthor_modes.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
 import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';

class MyAddressListPage_Address extends StatefulWidget {
  const MyAddressListPage_Address({super.key});

  @override
  State<MyAddressListPage_Address> createState() =>
      _MyAddressListPage_AddressState();
}

class _MyAddressListPage_AddressState
    extends State<MyAddressListPage_Address> {

   VALIDADDRESSAUTHOR_MODES addressAuthorMode = VALIDADDRESSAUTHOR_MODES.complete_registration;
   int selectedAddress = -1;

   final GlobalKey<FormState> addressAuditFormKey = GlobalKey<FormState>();
   final addressController = Get.find<AddressController>();

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressController.getCustomerAddressList();
  }

  @override
  Widget build(BuildContext context) {
     double screenwidth = MediaQuery.of(context).size.width;

    return Obx(
        ()=> Scaffold(
          resizeToAvoidBottomInset: true,
          appBar:AppBar(
            automaticallyImplyLeading: false,
            scrolledUnderElevation:0.0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0.0,
            title: Row(
              children: [
                CustomBackButton(isPrimaryMode:false),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'shipping_address'.tr,
                      style: getHeadlineLargeStyle(context).copyWith(
                          fontWeight: APPSTYLE_FontWeightBold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            actions: [
              Visibility(
                visible: addressController.customerAddressList.length<2,
                child: InkWell(
                  onTap: (){
                    addressController.changeAuditAddress(-1) ;
                  },
                  child: Container(
                      decoration: APPSTYLE_ShadowedContainerExtraSmallDecoration.copyWith(
                        color: APPSTYLE_Black,
                        boxShadow: [
                          const BoxShadow(
                            color: APPSTYLE_Grey80Shadow24,
                            offset: Offset(0, 1.0),
                            blurRadius: APPSTYLE_BlurRadiusLarge,
                          ),
                        ],
                      ),
                      padding: APPSTYLE_SmallPaddingAll,
                      child: Icon(Ionicons.add,color: APPSTYLE_BackgroundWhite,)),
                ),
              ),
              addHorizontalSpace(APPSTYLE_SpaceLarge)
            ],
          ) ,
          body: SafeArea(
            child: Obx(
                ()=> Container(
                child: Column(
                  children: [
                    Visibility(
                        visible: addressController.isAddressDeleting.value,
                        child:   Padding(
                          padding: APPSTYLE_MediumPaddingAll.copyWith(bottom: 0),
                          child: const LinearProgressIndicator(
                            color: APPSTYLE_PrimaryColor,
                          ),
                        )),
                    Visibility(
                      visible:   addressController.isCustomerAddressListFetching.value  ,
                      child: Expanded(
                          child: ListView(
                            children: [
                              Container(
                                  padding: APPSTYLE_MediumPaddingAll,
                                  margin: APPSTYLE_LargePaddingAll,
                                  decoration: APPSTYLE_ShadowedContainerMediumDecoration,
                                  child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Shimmer.fromColors(
                                              baseColor: APPSTYLE_Grey20,
                                              highlightColor: APPSTYLE_Grey40,
                                              child: Container(
                                                height: 30,
                                                width: screenwidth*.15,
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
                                        addVerticalSpace(APPSTYLE_SpaceSmall),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Shimmer.fromColors(
                                                baseColor: APPSTYLE_Grey20,
                                                highlightColor: APPSTYLE_Grey40,
                                                child: Container(
                                                  height: screenwidth*.15,
                                                  decoration:
                                                  APPSTYLE_BorderedContainerExtraSmallDecoration
                                                      .copyWith(
                                                    border: null,
                                                    color: APPSTYLE_Grey20,
                                                    borderRadius: BorderRadius.circular(
                                                        APPSTYLE_BlurRadiusSmall),
                                                  ),),
                                              ),
                                            ),
                                            addHorizontalSpace(APPSTYLE_SpaceSmall),
                                            Shimmer.fromColors(
                                              baseColor: APPSTYLE_Grey20,
                                              highlightColor: APPSTYLE_Grey40,
                                              child: Container(
                                                height: screenwidth*.15,
                                                width: screenwidth*.15,
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
                                      ]
                                  ))
                            ],
                          )),
                    ),
                    Visibility(
                      visible: addressController.customerAddressList.isNotEmpty &&
                          !addressController.isCustomerAddressListFetching.value ,
                      child: Expanded(
                        child: ListView.builder(
                            itemCount: addressController.customerAddressList.length,
                            itemBuilder: (context, index) {
                              return AddressCardComponentShared(
                                onDeleteSelected: () {
                                  showDeleteConfirmDialogue(context,addressController.customerAddressList[index].id);
                                },
                                onEditSelected: () {
                                  addressController.changeAuditAddress(addressController.customerAddressList[index].id) ;
                                },
                                shippingAddress:addressController.customerAddressList[index],
                              );
                            }),
                      ),
                    ),
                    Visibility(
                      visible: addressController.customerAddressList.isEmpty &&
                           !addressController.isCustomerAddressListFetching.value   ,
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
                                      child: Icon(Ionicons.location_sharp,
                                          size: screenwidth * .15,
                                          color: APPSTYLE_PrimaryColorBg),
                                    ),
                                  )
                                ],
                              ),
                              addVerticalSpace(APPSTYLE_SpaceLarge),
                              Text("no_address".tr,
                                  style: getHeadlineMediumStyle(context)),
                            ],
                          )),
                    )

                  ],
                ),
              ),
            ),
          )),
    );
  }

   void showDeleteConfirmDialogue(BuildContext context, int addressId ) async {

     final dialogTitleWidget = Text('address_delete_title'.tr,style: getHeadlineMediumStyle(context).copyWith(
         color: APPSTYLE_Grey80,fontWeight: APPSTYLE_FontWeightBold));
     final dialogTextWidget = Text(  'address_delete_content'.tr,style: getBodyMediumStyle(context),
     );

     final updateButtonTextWidget = Text('yes'.tr,style: TextStyle(color: APPSTYLE_PrimaryColor),);
     final updateButtonCancelTextWidget = Text('no'.tr,style: TextStyle(color: APPSTYLE_Black),);

     updateLogoutAction() async {

       addressController.deleteAddress(addressId);
       Navigator.pop(context);
     }

     updateAction() {
       Navigator.pop(context);
     }
     List<Widget> actions = [

       TextButton(
           onPressed:updateAction,
           style: APPSTYLE_TextButtonStylePrimary.copyWith(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
               EdgeInsets.symmetric(
                   horizontal: APPSTYLE_SpaceLarge,
                   vertical: APPSTYLE_SpaceSmall))),
           child:  updateButtonCancelTextWidget),

       TextButton(
           onPressed:updateLogoutAction,
           style: APPSTYLE_TextButtonStylePrimary.copyWith(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
               EdgeInsets.symmetric(
                   horizontal: APPSTYLE_SpaceLarge,
                   vertical: APPSTYLE_SpaceSmall))),
           child:  updateButtonTextWidget),
     ];

     await showDialog(
       context: context,
       barrierDismissible: false,
       builder: (BuildContext context) {
         return WillPopScope(
             child: AlertDialog(
               title: dialogTitleWidget,
               content: dialogTextWidget,
               actions: actions,
             ),
             onWillPop: () => Future.value(false));
       },
     );
   }

}
