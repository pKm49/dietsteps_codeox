import 'package:dietsteps/feature_modules/address/controllers/address.controller.dart';
import 'package:dietsteps/feature_modules/address/models/shipping_address.model.address.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/valid_addressauthor_modes.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/models/general_item.model.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/dropdown_selected_item_getter.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/form_validator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:dietsteps/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:dietsteps/shared_module/ui/components/dropdown_selector.component.shared.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuditAddressPage_Address extends StatefulWidget {
  const AuditAddressPage_Address({super.key});

  @override
  State<AuditAddressPage_Address> createState() =>
      _AuditAddressPage_AddressState();
}

class _AuditAddressPage_AddressState extends State<AuditAddressPage_Address> {
  VALIDADDRESSAUTHOR_MODES addressAuthorMode =
      VALIDADDRESSAUTHOR_MODES.complete_registration;
  var getArguments = Get.arguments;
  final GlobalKey<FormState> addressAuditFormKey = GlobalKey<FormState>();
  final addressController = Get.find<AddressController>();
  var mobile = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressAuthorMode =
        getArguments[0] ?? VALIDADDRESSAUTHOR_MODES.complete_registration;
    mobile = getArguments[1];

    addressController.setFromRoute(addressAuthorMode);
    addressController.getAreas();
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
          title: Row(
            children: [
              CustomBackButton(isPrimaryMode: false),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'enter_your_address'.tr,
                    style: getHeadlineLargeStyle(context)
                        .copyWith(fontWeight: APPSTYLE_FontWeightBold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Obx(
            () => Container(
              height: screenheight,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: APPSTYLE_LargePaddingAll.copyWith(
                          bottom: 0.0, top: 0.0),
                      child: Form(
                        key: addressAuditFormKey,
                        child: ListView(
                          children: [
                            addVerticalSpace(APPSTYLE_SpaceLarge),
                            Container(
                              height: 90,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 90,
                                      padding: const EdgeInsets.only(
                                          left: APPSTYLE_SpaceMedium,
                                          right: APPSTYLE_SpaceMedium,
                                          top: APPSTYLE_SpaceMedium),
                                      decoration:
                                          APPSTYLE_BorderedContainerDarkSmallDecoration
                                              .copyWith(
                                                  border: Border.all(
                                                      color: APPSTYLE_Grey60,
                                                      width: .2)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'area'.tr,
                                                style: TextStyle(height: .5),
                                              ),
                                              Transform.translate(
                                                offset: const Offset(0.0, -7.0),
                                                child: Text(
                                                  '*',
                                                  style: TextStyle(
                                                      color: APPSTYLE_GuideRed),
                                                ),
                                              )
                                            ],
                                          ),
                                          Visibility(
                                              visible: addressController
                                                  .isAreasFetching.value,
                                              child: LinearProgressIndicator(
                                                color: APPSTYLE_PrimaryColor,
                                              )),
                                          Visibility(
                                            visible: !addressController
                                                .isAreasFetching.value,
                                            child: DropDownSelector(
                                              titleText: 'area'.tr,
                                              selected: getSelectedItem(
                                                  addressController
                                                      .areaId.value,
                                                  addressController.areas),
                                              items: addressController.areas,
                                              hintText: 'select_area'.tr,
                                              valueChanged: (newAreaId) {
                                                addressController.getBlocks(
                                                    int.parse(newAreaId));
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            addVerticalSpace(APPSTYLE_SpaceMedium),
                            Container(
                              height: 90,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 90,
                                      padding: const EdgeInsets.only(
                                          left: APPSTYLE_SpaceMedium,
                                          right: APPSTYLE_SpaceMedium,
                                          top: APPSTYLE_SpaceMedium),
                                      decoration:
                                          APPSTYLE_BorderedContainerDarkSmallDecoration
                                              .copyWith(
                                                  border: Border.all(
                                                      color: APPSTYLE_Grey60,
                                                      width: .2)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'block'.tr,
                                                style: TextStyle(height: .5),
                                              ),
                                              Transform.translate(
                                                offset: const Offset(0.0, -7.0),
                                                child: Text(
                                                  '*',
                                                  style: TextStyle(
                                                      color: APPSTYLE_GuideRed),
                                                ),
                                              )
                                            ],
                                          ),
                                          Visibility(
                                              visible: addressController
                                                  .isBlocksFetching.value,
                                              child: LinearProgressIndicator(
                                                color: APPSTYLE_PrimaryColor,
                                              )),
                                          Visibility(
                                            visible: !addressController
                                                .isBlocksFetching.value,
                                            child: DropDownSelector(
                                              titleText: 'block'.tr,
                                              selected: getSelectedItem(
                                                  addressController
                                                      .blockId.value,
                                                  addressController.blocks),
                                              items: addressController.blocks,
                                              hintText: 'select_block'.tr,
                                              valueChanged: (newBlockId) {
                                                addressController.changeBlock(
                                                    int.parse(newBlockId));
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(visible: addressController.blockId.value !=-1 && getDeliveryTime(
                                addressController
                                    .blockId.value,
                                addressController.blocks) !="",
                              child: Padding(
                                padding: const EdgeInsets.only(top: APPSTYLE_SpaceLarge),
                                child: Row(

                                  children: [

                                    Text('delivery_time'.tr,
                                        style: getHeadlineMediumStyle(context)),
                                  Text(getDeliveryTime(
                                      addressController
                                          .blockId.value,
                                      addressController.blocks),
                                  style: getHeadlineMediumStyle(context))
                                ],),
                              ),
                            ),
                            addVerticalSpace(APPSTYLE_SpaceMedium),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: addressController
                                        .streetTextEditingController.value,
                                    validator: (password) =>
                                        checkIfNameFormValid(password,"street"),
                                    decoration: InputDecoration(
                                      hintText: 'enter_street'.tr,
                                      label: Row(
                                        children: [
                                          Text('street'.tr),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              "*",
                                              style: TextStyle(
                                                  color: APPSTYLE_GuideRed),
                                            ),
                                          )
                                        ],
                                      ),
                                      isDense: true,
                                    ),
                                  ),
                                ),
                                addHorizontalSpace(APPSTYLE_SpaceMedium),
                                Expanded(
                                  child: TextFormField(
                                    controller: addressController
                                        .jedhaTextEditingController.value,
                                    decoration: InputDecoration(
                                      hintText: 'enter_jeddah'.tr,
                                      label: Text('jeddah'.tr),
                                      isDense: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            addVerticalSpace(APPSTYLE_SpaceMedium),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: addressController
                                  .houseNumberTextEditingController.value,
                              validator: (password) =>
                                  checkIfNameFormValid(password,"house_number"),
                              decoration: InputDecoration(
                                hintText: 'enter_housenum'.tr,
                                label: Row(
                                  children: [
                                    Text('house_number'.tr),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "*",
                                        style:
                                            TextStyle(color: APPSTYLE_GuideRed),
                                      ),
                                    )
                                  ],
                                ),
                                isDense: true,
                              ),
                            ),
                            addVerticalSpace(APPSTYLE_SpaceMedium),
                            TextFormField(
                              keyboardType: TextInputType.number,

                              controller: addressController
                                  .floorNumberTextEditingController.value ,
                              decoration: InputDecoration(
                                hintText: 'enter_floornum'.tr,
                                label: Text('floor_number'.tr),
                                isDense: true,
                              ),
                            ),
                            addVerticalSpace(APPSTYLE_SpaceMedium),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: addressController
                                  .apartmentNumberTextEditingController.value,
                              decoration: InputDecoration(
                                hintText: 'enter_flatnum'.tr,
                                label: Text('flat_number'.tr),
                                isDense: true,
                              ),
                            ),
                            addVerticalSpace(APPSTYLE_SpaceMedium),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              validator: (password) =>
                                  checkIfNameFormValid(password,"address_nickname"),
                              controller: addressController
                                  .nicknameTextEditingController.value,
                              decoration: InputDecoration(
                                hintText: 'enter_address_nickname'.tr,
                                label: Text('address_nickname'.tr),
                                isDense: true,
                              ),
                            ),
                            addVerticalSpace(APPSTYLE_SpaceMedium),
                            TextFormField(
                              controller: addressController
                                  .commentsTextEditingController.value,
                              decoration: InputDecoration(
                                hintText: 'enter_comments'.tr,
                                label: Text('comments'.tr),
                                isDense: true,
                              ),
                            ),
                            addVerticalSpace(APPSTYLE_SpaceLarge),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: APPSTYLE_SpaceLarge,
                        vertical: APPSTYLE_SpaceSmall),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (addressAuditFormKey.currentState!.validate()) {
                            handleSubmitClick();
                          }
                        },
                        style: getElevatedButtonStyle(context),
                        child:addressController.isAddressAuditing.value
                            ? LoadingAnimationWidget.staggeredDotsWave(
                          color: APPSTYLE_BackgroundWhite,
                          size: 24,
                        ):   Text("continue".tr,
                            style: getHeadlineMediumStyle(context).copyWith(
                                color: APPSTYLE_BackgroundWhite,
                                fontWeight: APPSTYLE_FontWeightBold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void handleSubmitClick() {
    if (addressController.areaId.value == -1 ||
        addressController.blockId.value == -1 ||
        addressController.streetTextEditingController.value.text =="" ||
        addressController.nicknameTextEditingController.value.text =="" ||
        addressController.houseNumberTextEditingController.value.text =="") {
      if (addressController.areaId.value == -1) {
        showSnackbar(Get.context!, "select_area".tr, "error");
      } else if (addressController.blockId.value == -1) {
        showSnackbar(Get.context!, "select_block".tr, "error");
      }else{
        showSnackbar(Get.context!, "check_input_and_try_again".tr, "error");
      }
    } else {
      if (addressAuthorMode == VALIDADDRESSAUTHOR_MODES.complete_registration) {
        Get.toNamed(AppRouteNames.registerAboutMeRoute, arguments: [
          Address(
              id: -1,
              name: "Default",
              areaId: addressController.areaId.value,
              areaName: "",
              areaNameArabic: "",
              blockId: addressController.blockId.value,
              blockName: "",
              blockNameArabic: "",
              nickname: addressController.nicknameTextEditingController.value.text,
              jedha: addressController.jedhaTextEditingController.value.text,
              comments:
                  addressController.commentsTextEditingController.value.text,
              street: addressController.streetTextEditingController.value.text,
              houseNumber:
                  int.parse(addressController.houseNumberTextEditingController.value.text.toString().trim()),
            floorNumber:addressController.floorNumberTextEditingController.value.text.toString().trim()==""?-1:
            int.parse(addressController.floorNumberTextEditingController.value.text.toString().trim()),
            apartmentNo:addressController.apartmentNumberTextEditingController.value.text.toString().trim()==""?-1:
            int.parse(addressController.apartmentNumberTextEditingController.value.text.toString().trim()),
          ),
          mobile
        ]);
      } else {
        if(!addressController.isAddressAuditing.value){
          addressController.auditAddress();
        }
      }
    }
  }

  String getDeliveryTime(int value, RxList<GeneralItem> blocks) {
    List<GeneralItem> tBlocks = blocks.where((p0) => p0.id==value).toList();
    if(tBlocks.isNotEmpty){
      print(tBlocks[0].name);
      print(tBlocks[0].arabicName);
      print(tBlocks[0].deliveryTime);
      return tBlocks[0].deliveryTime;
    }
    return "";
  }
}
