class SendOTPCredential {

  final String mobile;
  final bool isResetPassword;

  SendOTPCredential({
    required this.mobile,
    required this.isResetPassword,
  });

  Map toJson() => {
    'mobile': mobile,
    'reset_password': isResetPassword,
  };
}
