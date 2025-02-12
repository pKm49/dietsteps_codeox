import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 


class DOBPicker extends StatefulWidget {
  final DateTime dob;    // <------------|
  final Function(DateTime dob) dobPicked;      // <------------|

  const DOBPicker({super.key, required this.dobPicked, required this.dob});

  @override
  State<DOBPicker> createState() => _DOBPickerState();
}

class _DOBPickerState extends State<DOBPicker> {

  DateTime selectedDOB = DateTime( DateTime.now().year-64);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.dob.isBefore(getMinimumDate())||widget.dob.isAfter(getMaximumDate())){
      selectedDOB = getMinimumDate();
    }else{
      selectedDOB  = widget.dob;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(APPSTYLE_BorderRadiusSmall))),
      contentPadding: APPSTYLE_SmallPaddingAll,
      content: StatefulBuilder(// You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter _setState) {
            return SizedBox(
              height: 250,
              child: Column(
                children: [
                  Expanded(
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: selectedDOB,
                      minimumDate: getMinimumDate(),
                      maximumDate: getMaximumDate(),
                      onDateTimeChanged: (DateTime newDateTime) {
                        setState(() {
                          selectedDOB = newDateTime;
                        });

                      },
                    ),
                  ),
                  addVerticalSpace(APPSTYLE_SpaceMedium),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        child: Text( 'submit'.tr,
                            style: getBodyMediumStyle(context).copyWith(color: APPSTYLE_BackgroundWhite),
                            textAlign: TextAlign.center),
                        onPressed: () {
                          widget.dobPicked(selectedDOB);

                          Navigator.pop(context);
                        }),
                  )
                ],
              ),
            );
          }),
    );
  }

  getMinimumDate() {
    DateTime currentDate = DateTime.now();
    return DateTime(currentDate.year-64);
  }

  getMaximumDate() {
    DateTime currentDate = DateTime.now();
    return DateTime(currentDate.year-14);
  }



}
