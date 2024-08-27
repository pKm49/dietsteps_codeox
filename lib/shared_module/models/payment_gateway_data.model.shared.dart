
class PaymentCompletionData {
  
  final String orderReference;
  final String paymentReference;
  final String transactionUrl;
  final String redirectUrl;
  final String paymentStatusUrl;
  final int planId;
  final int subscriptionId;
  final String planName;
  final String planNameArabic;
  final String startDate;
  final String endDate;
  final double total;
  final double couponDiscount;
  final double grandTotal;

  PaymentCompletionData(
      {
        required this.orderReference,
        required this.paymentReference,
        required this.transactionUrl,
        required this.redirectUrl,
        required this.paymentStatusUrl,
        required this.planId,
        required this.subscriptionId,
        required this.planName,
        required this.planNameArabic,
        required this.startDate,
        required this.endDate,
        required this.total,
        required this.couponDiscount,
        required this.grandTotal
      });
}

PaymentCompletionData mapPaymentCompletionData(dynamic payload) {
  return PaymentCompletionData(
      orderReference: (payload["order_reference"] != null && payload["order_reference"] != false) ?payload["order_reference"]:"",
      paymentReference: (payload["payment_reference"] != null && payload["payment_reference"] != false) ?payload["payment_reference"]:"",
      transactionUrl: (payload["transaction_url"] != null && payload["transaction_url"] != false) ?payload["transaction_url"]:"",
      redirectUrl: (payload["redirect_url"] != null && payload["redirect_url"] != false) ?payload["redirect_url"]:"",
      paymentStatusUrl: (payload["payment_status_url"] != null && payload["payment_status_url"] != false) ?payload["payment_status_url"]:"",
      planName: (payload["plan_name"] != null && payload["plan_name"] != false) ?payload["plan_name"]:"",
      planNameArabic: (payload["plan_arabic_name"] != null && payload["plan_arabic_name"] != false) ?payload["plan_arabic_name"]:"",
      startDate: (payload["start_date"] != null && payload["start_date"] != false) ?payload["start_date"]:"",
      endDate: (payload["end_date"] != null && payload["end_date"] != false) ?payload["end_date"]:"",
      subscriptionId: payload["subscription_id"] ?? -1,
      planId: payload["plan_id"] ?? -1,
      total: payload["total"] ?? 0.0,
      couponDiscount: payload["coupon_discount"] ?? 0.0,
      grandTotal: payload["grand_total"] ?? 0.0
  );
}
