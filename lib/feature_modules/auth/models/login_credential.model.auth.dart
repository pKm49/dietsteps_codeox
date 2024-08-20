class LoginCredential {

  final String mobile;
  final String password;

  LoginCredential({
    required this.mobile,
    required this.password,

  });

  Map toJson() => {
    'mobile': mobile,
    'password': password,
  };
}
