//DIGUNAKAN UNTUK FORM LOGIN
class SignUpInput {
  final String fullname;
  final String email;
  final String password;
  final String confirmpassword;
  final String phonenumber;
  SignUpInput({
    required this.fullname,
    required this.email,
    required this.password,
    required this.confirmpassword,
    required this.phonenumber,
  });
  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "email": email,
        "password": password,
        "confirmpassword": confirmpassword,
        "phonenumber": phonenumber,
      };
}

//DIGUNAKAN UNTUK RESPONSE
class SignUpResponse {
  // final String? token;
  final String message;
  final int status;

  SignUpResponse({
    // this.token,
    required this.message,
    required this.status,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    print('JSON Data: $json');
    return SignUpResponse(
      // token: json["token"],
      message: json["message"],
      status: json["status"],
    );
  }
}
