
class DiscountData {
  final double grandTotal;
  final double discount;
  final double total;
  final bool isValid;

  DiscountData({
    required this.grandTotal,
    required this.discount,
    required this.total,
    required this.isValid,
  });

  Map toJson() => {
        'grandTotal': grandTotal,
        'discount': discount,
        'total': total,
        'isValid': isValid,
      };
}

DiscountData mapDiscountData(dynamic payload,bool isValid) {
  return DiscountData(
    grandTotal: payload["grand_total"] ?? 0.0,
    discount: payload["discount"] ?? 0.0,
    total: payload["total"] ?? 0.0,
    isValid: isValid,
  );
}
