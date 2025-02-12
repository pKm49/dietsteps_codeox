
import 'package:dietsteps/shared_module/models/general_item.model.shared.dart';

class QueryResponse {

    List<GeneralItem> categories = [];
    List<GeneralItem> ingredients = [];

  QueryResponse({
    required this.categories,
    required this.ingredients
  });

}


