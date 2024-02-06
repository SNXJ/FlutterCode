class LoginRequest {
   String? password;
   String? userName;

  LoginRequest({ this.password, this.userName});

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'userName': userName,
    };
  }
}
