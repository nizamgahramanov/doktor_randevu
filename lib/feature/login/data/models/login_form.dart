class LoginForm {
  String email;
  String password;


  LoginForm({
    required this.email,
    required this.password,
  });


  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
