
class PaymentData {
  final int subscriptionId;
  final String refId;
  final String orderId;
  final String paymentUrl;
  final String redirectUrl;
  final String paymentCheckUrl;

  PaymentData({
    required this.subscriptionId,
    required this.refId,
    required this.orderId,
    required this.paymentUrl,
    required this.redirectUrl,
    required this.paymentCheckUrl,
  });

  Map toJson() => {
        'refId': refId,
        'orderId': orderId,
        'paymentUrl': paymentUrl,
        'redirectUrl': redirectUrl,
      };
}

PaymentData mapPaymentData(dynamic payload) {

  int subscriptionId = -1;
   if (payload['subscription_details'] != null) {
    if (payload['subscription_details']['subscription_id'] != null) {
      subscriptionId = payload['subscription_details']['subscription_id'] ?? -1;
    }
  }

  String redirectUrl = "";
  String paymentUrl = "";

  if (payload['redirect_url'] != null) {
    if (payload['redirect_url'] != false) {
      redirectUrl = payload["redirect_url"] ?? "";
    }
  }

  if (payload['transaction_url'] != null) {
    if (payload['transaction_url'] != false) {
      paymentUrl = payload["transaction_url"] ?? "";
    }
  }

  return PaymentData(
    subscriptionId: subscriptionId,
    refId: payload["payment_reference"] ?? "",
    orderId: payload["order_reference"] ?? "",
    redirectUrl: redirectUrl,
    paymentUrl: paymentUrl,
    paymentCheckUrl: payload["payment_status_url"] ?? "",
  );
}
