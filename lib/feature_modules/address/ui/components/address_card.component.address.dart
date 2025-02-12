import 'package:dietsteps/feature_modules/address/models/shipping_address.model.address.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class AddressCardComponentShared extends StatelessWidget {
   Address shippingAddress;
  GestureTapCallback onDeleteSelected;
  GestureTapCallback onEditSelected;

  AddressCardComponentShared(
      {super.key,
      required this.shippingAddress,
      required this.onEditSelected,
      required this.onDeleteSelected});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: APPSTYLE_ShadowedContainerSmallDecoration.copyWith(
        color: APPSTYLE_BackgroundWhite,
        boxShadow: [
          const BoxShadow(
            color: APPSTYLE_Grey80Shadow24,
            offset: Offset(0, 2.0),
            blurRadius: APPSTYLE_BlurRadiusLarge,
          ),
        ],
      ),
      padding: APPSTYLE_MediumPaddingAll,
      margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
      width: screenwidth,
      child: Wrap(
        direction: Axis.vertical,
        children: [
          Container(
            width: screenwidth -
                ((APPSTYLE_SpaceMedium * 2) + (APPSTYLE_SpaceLarge * 2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: onDeleteSelected,
                    child: Icon(Ionicons.trash_bin_outline,color: APPSTYLE_GuideRed,)),

                addHorizontalSpace(APPSTYLE_SpaceSmall),
                InkWell(
                    onTap: onEditSelected,
                    child: Icon(Ionicons.create_outline)),
                Expanded(
                  child:shippingAddress.nickname.trim()!=''?
                  Text(shippingAddress.nickname,style: getHeadlineMediumStyle(context),textAlign:Localizations.localeOf(context)
                      .languageCode
                      .toString() ==
                      'ar'? TextAlign.start : TextAlign.end,):
                  Container(),
                ),
              ],
            ),
          ),
          addVerticalSpace(APPSTYLE_SpaceSmall),
          Container(
            width: screenwidth -
                ((APPSTYLE_SpaceMedium * 2) + (APPSTYLE_SpaceLarge * 2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                      "${Localizations.localeOf(context)
                          .languageCode
                          .toString() ==
                          'ar'?shippingAddress.areaNameArabic:shippingAddress.areaName}, "
                          " ${shippingAddress.street} ${'street'.tr}, "
                          "Block ${Localizations.localeOf(context)
                          .languageCode
                          .toString() ==
                          'ar'?shippingAddress.blockNameArabic:shippingAddress.blockName}, "
                          "${shippingAddress.jedha.trim()!='' ?('${shippingAddress.jedha} '):''}${shippingAddress.jedha.trim()!=''?('${'jedha'.tr},'):''}"
                          "${shippingAddress.houseNumber !=-1?'house_number'.tr:''} : ${shippingAddress.houseNumber!=-1 ?shippingAddress.houseNumber:''}"
                          "${shippingAddress.floorNumber !=-1?(', ${'floor_number'.tr} : '):''} ${shippingAddress.floorNumber!=-1 ?shippingAddress.floorNumber:''}"
                          "${shippingAddress.apartmentNo !=-1? (', ${'flat_number'.tr} : '):''} ${shippingAddress.apartmentNo!=-1 ?shippingAddress.apartmentNo:''}"
                          "${shippingAddress.comments.trim()!=''? (', ${'comments'.tr} : '):'' } ${shippingAddress.comments.trim()!=''?shippingAddress.comments:''}",

                      style: getBodyMediumStyle(context)
                          .copyWith(color: APPSTYLE_Grey40)),
                ),
                addHorizontalSpace(APPSTYLE_SpaceMedium),
                Container(
                    width: screenwidth * .15,
                    height: screenwidth * .15,
                    decoration: APPSTYLE_BorderedContainerSmallDecoration,
                    clipBehavior: Clip.hardEdge,
                    child: Center(
                        child: Image.asset(ASSETS_LOCATION,
                            width: screenwidth * .15)))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
