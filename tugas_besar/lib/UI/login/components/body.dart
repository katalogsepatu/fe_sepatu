import 'package:flutter/material.dart';
import 'package:tugas_besar/Models/errormsg.dart';
import 'package:tugas_besar/Models/login_model.dart';
import 'package:tugas_besar/Service/apiService.dart';
import 'package:tugas_besar/Service/auth_manager.dart';
import 'package:tugas_besar/UI/home/homeScreen.dart';
import 'package:tugas_besar/UI/main/main.dart';
import 'package:tugas_besar/UI/signup/signup_screen.dart';
import 'package:tugas_besar/Widget/components/formError.dart';
import 'package:tugas_besar/Widget/components/rounded_button.dart';
import 'package:tugas_besar/constants.dart';
import 'package:iconsax/iconsax.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
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
                        "Login",
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
                        "Login to Enjoy your Shopping",
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
                child: LoginForm(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final ApiServices _dataService = ApiServices();
  final List<String> errors = [];
  late ErrorMSG res;
  bool isImageEnlarged = false;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    bool isLoggedIn = await AuthManager.isLoggedIn();
    if (isLoggedIn) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
      return 'Masukkan minimal 3 karakter';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
              controller: _emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xFFe7edeb),
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.mail_outline_rounded,
                    color: Colors.grey[600],
                  )),
            ),
            SizedBox(
              height: 25.0,
            ),
            TextFormField(
              obscureText: true,
              controller: _passwordController,
              validator: _validatePassword,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xFFe7edeb),
                  hintText: "Password",
                  prefixIcon: Icon(
                    Iconsax.lock,
                    color: Colors.grey[600],
                  )),
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
                final isValidForm = _formKey.currentState!.validate();
                if (isValidForm) {
                  final postModel = LoginInput(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  LoginResponse? res = await _dataService.login(postModel);
                  if (res!.status == 200) {
                    await AuthManager.login(
                        _emailController.text, res.token.toString());

                    // Navigasi ke halaman HomePage
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                      (route) => false,
                    );

                    // Menampilkan pesan sukses
                    displaySnackbar("Sign-in successful!");
                  } else {
                    displaySnackbar(res.message);
                  }
                }
              },
              child: const Text('Sign In'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Don't have an account? ",
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
                          return SignupScreen();
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
    );
  }

  dynamic displaySnackbar(String msg) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}
