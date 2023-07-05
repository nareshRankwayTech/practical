import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:practical/module/auth/signup.view.dart';
import 'package:practical/module/main/home_page.dart';
import 'package:practical/widgets/custom_text_form.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _userPassController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _userController.dispose();
    _userPassController.dispose();
  }

  String? _userEmailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    var reg = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (!reg.hasMatch(value)) {
      return 'Please check your email';
    }
    return null;
  }

  String? _userPasswordValidator(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    var passNonNullValue = value ?? "";
    if (passNonNullValue.isEmpty) {
      return ("Please enter password");
    } else if (passNonNullValue.length < 6) {
      return ("password Must be more than 5 characters");
    } else if (!regex.hasMatch(passNonNullValue)) {
      return ("password should contain upper,lower,digit and Special character ");
    }
    return null;
  }

  _loginRequest() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _userController.text.trim(),
          password: _userPassController.text.trim());

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomePage()),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(error.message ?? "")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30, right: 40, left: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: Colors.green),
            ),
            const SizedBox(
              height: 15,
            ),
            Form(
              key: _loginKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    validator: _userEmailValidator,
                    controller: _userController,
                    prefixIcon: Icons.email,
                    hintText: "Enter Email",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    validator: _userPasswordValidator,
                    controller: _userPassController,
                    prefixIcon: Icons.lock,
                    obscureText: true,
                    hintText: "Enter Your Password",
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_loginKey.currentState!.validate()) {
                    _loginRequest();
                  }
                },
                child: Text(
                  "Login",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
                )),
            const SizedBox(
              height: 10,
            ),
            FittedBox(
                child: RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(color: Colors.blueGrey),
                        children: [
                  const TextSpan(text: "Don't have an account? "),
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            )),
                      text: "SignUp",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(color: Colors.green))
                ])))
          ],
        ),
      ),
    ));
  }
}
