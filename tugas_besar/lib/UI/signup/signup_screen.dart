import 'package:flutter/material.dart';
import 'package:tugas_besar/Models/errormsg.dart';
import 'package:tugas_besar/Models/signup_model.dart';
import 'package:tugas_besar/Service/apiService.dart';
import 'package:tugas_besar/UI/login/login_screen.dart';
import 'package:tugas_besar/UI/main/main.dart';
import 'package:tugas_besar/Widget/components/formError.dart';
import 'package:tugas_besar/Widget/components/rounded_button.dart';
import 'package:tugas_besar/constants.dart';
import 'package:iconsax/iconsax.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade600,
            ],
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Create your account to get your best shoes!",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ]),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: SignupForm(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();

  final ApiServices _dataService = ApiServices();
  final List<String> errors = [];
  late ErrorMSG res;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullnameController.dispose();
    _phonenumberController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value != null && value.length < 4) {
      return 'Enter a valid email (min 4 characters)';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value != null && value.length < 3) {
      return 'Password must be at least 3 characters';
    }
    return null;
  }

  String? _validateFullName(String? value) {
    if (value != null && value.isEmpty) {
      return 'Full Name cannot be empty';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value != null && value.length != 10) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                validator: _validateFullName,
                controller: _fullnameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color(0xFFe7edeb),
                    hintText: 'Enter Full Name',
                    labelText: 'Full Name',
                    prefixIcon: Icon(
                      Iconsax.user,
                      color: Colors.grey[600],
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                validator: _validateEmail,
                controller: _emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color(0xFFe7edeb),
                    hintText: 'Enter Email',
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.mail_outline_rounded,
                      color: Colors.grey[600],
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                obscureText: true,
                validator: _validatePassword,
                controller: _passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color(0xFFe7edeb),
                    hintText: 'Enter Password',
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Iconsax.lock,
                      color: Colors.grey[600],
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              // TextFormField(
              //   obscureText: true,
              //   onSaved: (newValue) => confirmPassword = newValue.toString(),
              //   onChanged: (value) {
              //     setState(() {
              //       confirmPassword = value;
              //     });
              //     if (value.isNotEmpty && errors.contains(kPassNullError)) {
              //       setState(() {
              //         errors.remove(kPassNullError);
              //       });
              //     } else if (password == confirmPassword &&
              //         !errors.contains(kMatchPassError)) {
              //       setState(() {
              //         errors.remove(kMatchPassError);
              //       });
              //     }
              //     return null;
              //   },
              //   validator: (value) {
              //     if (password != confirmPassword &&
              //         !errors.contains(kMatchPassError)) {
              //       setState(() {
              //         errors.add(kMatchPassError);
              //       });
              //     }
              //     return null;
              //   },
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //       borderSide: BorderSide.none,
              //     ),
              //     filled: true,
              //     fillColor: Color(0xFFe7edeb),
              //     hintText: "Confirm Password",
              //     prefixIcon: Icon(
              //       Iconsax.lock,
              //       color: Colors.grey[600],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                validator: _validatePhoneNumber,
                controller: _phonenumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  hintText: 'Enter Phone Number',
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  filled: true,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(child: FormError(errors: errors)),
              SizedBox(
                height: 15.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  final isValidForm =
                      _formKey.currentState?.validate() ?? false;

                  if (isValidForm) {
                    final SignUpInput postModel = SignUpInput(
                      fullname: _fullnameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                      phonenumber: _phonenumberController.text,
                    );

                    SignUpResponse? res;
                    try {
                      // Call the signup service
                      res = await _dataService.signup(postModel);
                    } catch (e) {}

                    if (res != null && res.status == 200) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                      displaySnackbar("Sign-up successful! Please sign in.");
                    } else {
                      // Check if res is not null before accessing its properties
                      displaySnackbar(res!.message);
                    }
                  }
                },
                child: const Text('Sign Up'),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Any have an account? ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Forgot your Password",
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  dynamic displaySnackbar(String msg) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}
