import 'dart:convert';

import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
class UpdateProfilePic extends StatelessWidget {

  GestureTapCallback onClick;
  String profilePictureUrl;
  Color borderColor;
  UpdateProfilePic({super.key, required this.onClick,required this.borderColor, required this.profilePictureUrl});

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onClick,
      child: Container(
        decoration: APPSTYLE_BorderedContainerDarkMediumDecoration.copyWith(
          borderRadius: BorderRadius.circular(1000),
          color: borderColor
        ),
        margin: EdgeInsets.symmetric(horizontal: APPSTYLE_SpaceMedium),
        padding: EdgeInsets.all(APPSTYLE_SpaceSmall),
        height: screenwidth * .3,
        width:  screenwidth * .3,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
          ),
          child: profilePictureUrl.contains("assets") ||  profilePictureUrl == ""?
          Image.asset(
            ASSETS_DEFAULTPROFILEPIC,
            height: APPSTYLE_FontSize24 * 1.9,
            width: APPSTYLE_FontSize24 * 1.9,
          ) : Image.network(
            profilePictureUrl ,
            height: APPSTYLE_FontSize24 * 1.9,
            width: APPSTYLE_FontSize24 * 1.9,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: APPSTYLE_FontSize24 * 1.9,
                width: APPSTYLE_FontSize24 * 1.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.memory(
                  base64Decode(profilePictureUrl),
                  height: APPSTYLE_FontSize24 * 1.9,
                  width: APPSTYLE_FontSize24 * 1.9,
                ),
              );
            },
            fit: BoxFit.cover,
          ),
        ),

      ),
    );
  }
}
