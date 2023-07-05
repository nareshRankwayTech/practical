import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:practical/module/main/home_page.dart';
import 'package:practical/widgets/custom_text_form.dart';

// import '../firebase/auth_method.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _sigUpKey = GlobalKey<FormState>();

  String? _nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Your Name';
    }
    return null;
  }

  String? _userNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Your UserName';
    }
    return null;
  }

  String? _emailValidator(String? value) {
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

  String? _passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "Please enter your password";
    }

    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _signupRequest() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (Route<dynamic> route) => false);
      });
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
              "Sign Up",
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
              key: _sigUpKey,
              child: Column(
                children: [
                  CustomTextField(
                    validator: _emailValidator,
                    controller: _emailController,
                    prefixIcon: Icons.email,
                    hintText: "Enter Your Email address",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    validator: _passwordValidator,
                    controller: _passwordController,
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
                  if (_sigUpKey.currentState!.validate()) {
                    _signupRequest();
                  }
                },
                child: Text(
                  "SignUp",
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
                  const TextSpan(text: "Already have an account?"),
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pop(context),
                      text: " Login",
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
