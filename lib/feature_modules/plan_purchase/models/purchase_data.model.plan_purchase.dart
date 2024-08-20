
import 'package:intl/intl.dart';

class PurchaseData {
  final int planCategoryId;
  final int planId;
  final DateTime startDate;
  final String promoCode;
  final String mobile;

  PurchaseData({
    required this.planCategoryId,
    required this.planId,
    required this.startDate,
    required this.promoCode,
    required this.mobile,
  });

  Map toJson() => {
        'plan_choice_id':planId ,
        'plan_id': planCategoryId,
        'promo_code':promoCode,
        'mobile':mobile,
        'start_date': DateFormat("yyyy-MM-dd").format(startDate),
      };
}

