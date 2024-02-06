//DIGUNAKAN UNTUK GET ALL DATA
class UserModel {
  final String id;
  final String fullname;
  final String email;
  final String password;
  final String confirmPassword;
  final String phonenumber;

  UserModel({
    required this.id,
    required this.fullname,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phonenumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        fullname: json["fullname"],
        email: json["email"],
        password: json["password"],
        confirmPassword: json["confirmPassword"],
        phonenumber: json["phonenumber"],
      );
  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullname": fullname,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "phonenumber": phonenumber,
      };
}

//DIGUNAKAN UNTUK FORM LOGIN
class LoginInput {
  final String email;
  final String password;
  LoginInput({
    required this.email,
    required this.password,
  });
  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

//DIGUNAKAN UNTUK RESPONSE
class LoginResponse {
  final String? token;
  final String message;
  final int status;
  LoginResponse({
    this.token,
    required this.message,
    required this.status,
  });
  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json["data"]["token"],
        message: json["message"],
        status: json["status"],
      );
}

//DIGUNAKAN UNTUK FORM SIGN UP
class SignUpInput {
  final String fullname;
  final String email;
  final String password;
  final String phonenumber;
  SignUpInput({
    required this.fullname,
    required this.email,
    required this.password,
    required this.phonenumber,
  });
  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "email": email,
        "password": password,
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
