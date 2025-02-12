import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/models/general_item.model.shared.dart';
import 'package:flutter/material.dart';
  
class DropDownSelector extends StatefulWidget {
  var selected;
  List<GeneralItem> items = [];
  final titleText;
  final hintText;
  final isBold;

  final Function(String) valueChanged;

  DropDownSelector({Key? key, required this.items,this.hintText,this.isBold, this.titleText, required this.valueChanged, this.selected}) : super(key: key);

  @override
  _DropDownSelectorState createState() => _DropDownSelectorState();
}

class _DropDownSelectorState extends State<DropDownSelector> {

  @override
  Widget build(BuildContext context) {

    double screenheight = ((MediaQuery.of(context).size.height * .9) - 60.0);
    double screenwidth = MediaQuery.of(context).size.width;

    return DropdownButton<String>(
      value:  widget.selected != null?widget.selected.toString():null,
      iconSize:APPSTYLE_FontSize16,
      isExpanded: true,
      elevation: 16,
      hint:Text(widget.hintText??"",textAlign: TextAlign.start) ,
      borderRadius:  BorderRadius.all(const Radius.circular(APPSTYLE_BorderRadiusMedium)),
      style: TextStyle(                  fontSize: screenwidth*.035,
          color:APPSTYLE_Grey60),
      underline: Container(
        height: 1,
        color: Colors.transparent,
      ),
      onChanged: (String? Value) {
        setState(() {
          widget.selected = Value;
          widget.valueChanged(Value!);
        });
      },
      items: widget.items.map((GeneralItem value) {
        return DropdownMenuItem<String>(
          value: value.id.toString(),
          child: Text(Localizations.localeOf(context)
              .languageCode
              .toString() ==
              'ar'?value.arabicName:value.name,textAlign: TextAlign.center,
            style: TextStyle(color: APPSTYLE_Grey60),),
        );
      }).toList(),
    );

  }
}
