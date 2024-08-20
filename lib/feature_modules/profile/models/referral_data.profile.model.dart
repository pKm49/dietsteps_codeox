
class ReferralData {

  final String refferalCode;
  final String refferalEarnings;


  ReferralData({
    required this.refferalCode,
    required this.refferalEarnings,
  });


}

ReferralData mapReferralData(dynamic payload) {
  print("mapReferralData");
  print(payload);
  return ReferralData(
    refferalCode: payload["referral_code"] !=null?payload["referral_code"].toString(): "",
      refferalEarnings: payload["referral_earnings"] !=null?payload["referral_earnings"].toString(): "" 
  );
}
