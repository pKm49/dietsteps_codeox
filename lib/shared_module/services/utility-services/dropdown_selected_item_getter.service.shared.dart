
import 'package:dietsteps/shared_module/models/general_item.model.shared.dart';

getSelectedItem(int itemId, List<GeneralItem> items){

  if(itemId == -1 || items.isEmpty) {
    return null;
  }

  List<GeneralItem> selectedItem =  items.where((element) => element.id==itemId).toList();

  if(selectedItem.isEmpty ){
    return null;
  }

  return itemId;

}
