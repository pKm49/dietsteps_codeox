import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomCurveShapeComponent_Shared extends StatelessWidget {

  const CustomCurveShapeComponent_Shared({super.key, required this.title, required this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipPath(
      clipper: CustomClipPath(),
      child: Container(
        decoration: BoxDecoration(color: color,boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 4,
            offset: Offset(4, 8),// changes position of shadow
          ),
        ],),
        height: size.height * 0.15,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50,left: APPSTYLE_SpaceLarge,right: APPSTYLE_SpaceLarge),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: getHeadlineLargeStyle(context).copyWith(
                  fontSize: APPSTYLE_FontSize24*1.1,
                  color: APPSTYLE_BackgroundWhite
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(0, size.height * 0.25);
    path_0.quadraticBezierTo(size.width * 0.2680000, size.height * 0.8165000,
        size.width * 0.5000000, size.height * 0.8000000);
    path_0.quadraticBezierTo(size.width * 0.7332500, size.height * 0.8065000,
        size.width, size.height * 0.25);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(0, 0);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
