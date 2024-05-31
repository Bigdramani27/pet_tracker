import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:kelpet/helpers/responsiveness.dart';

import '../../pages/account/register.dart';
import '../../pages/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isLoading = false;
  bool passwordVisible = true;
  bool remember = false;

  @override
  void initState() {
    super.initState();
    checkUserLoginStatus();
  }

  Future<void> checkUserLoginStatus() async {
    final user = FirebaseAuth.instance.currentUser?.uid;
    if (user != null) {
      context.go("/dashboard");
    } else {
      return;
    }
  }

  Future<String> signInWithEmailAndPasswords() async {
    String result = "";
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      result = "Login successful";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        result = "Email is not valid";
      } else if (e.code == 'invalid-credential') {
        result = "Incorrect Email or Password ";
      } else {
        result = e.code.toString();
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Card(
            elevation: 10,
            color: secondary,
            child: Form(
              key: _formKey,
              child: SizedBox(
                width: 420,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          !ResponsiveWidget.isSmallScreen(context) ? 48.0 : 30,
                      vertical: 33),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'KelPet',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color: primary),
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Text('Sign in',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: primary)),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Don\'t have an account?    ',
                              style: TextStyle(
                                  fontSize:
                                      !ResponsiveWidget.isSmallScreen(context)
                                          ? 16
                                          : 14,
                                  color: primary),
                            ),
                            TextSpan(
                              text: 'Register here!',
                              style: TextStyle(
                                  fontSize:
                                      !ResponsiveWidget.isSmallScreen(context)
                                          ? 16
                                          : 14,
                                  color: login),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Register()));
                                },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 35),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Email',
                              style: TextStyle(color: primary, fontSize: 12)),
                          TextFormField(
                            controller: email,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "Email is empty";
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: primary),
                            // Set text color to white
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        primary), //// Set underline color to white
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: primary),
                              ),
                              hintText: 'Enter your email address',
                              hintStyle: TextStyle(
                                  color: primary.withOpacity(0.7),
                                  fontSize: 14),
                              // Set hint text color to white with some opacity
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(right: 12.0),
                                child:
                                    Icon(Icons.email, color: primary, size: 16),
                              ), // Set icon color to white
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Password',
                              style: TextStyle(color: primary, fontSize: 12)),
                          TextFormField(
                            controller: password,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "Password is empty";
                              } else {
                                return null;
                              }
                            },
                            obscureText: passwordVisible,
                            style: const TextStyle(color: primary),
                            // Set text color to white
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        primary), //// Set underline color to white
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: primary),
                              ),
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(
                                  color: primary.withOpacity(0.7),
                                  fontSize: 14),
                              // Set hint text color to white with some opacity
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(right: 12.0),
                                child:
                                    Icon(Icons.lock, color: primary, size: 16),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: primary,
                                    size: 16),
                                onPressed: () {
                                  setState(
                                    () {
                                      passwordVisible = !passwordVisible;
                                    },
                                  );
                                },
                              ), 
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: (){
                            context.go("/forget_password");
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Forgot password ?',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: primary))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                padding:
                                    ResponsiveWidget.isLargeScreen(context) ||
                                            ResponsiveWidget.isMediumScreen(
                                                context) ||
                                            ResponsiveWidget.isCustomSize(
                                                context)
                                        ? EdgeInsets.symmetric(
                                            horizontal: 139, vertical: 20)
                                        : const EdgeInsets.symmetric(
                                            horizontal: 100, vertical: 20),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                String result =
                                    await signInWithEmailAndPasswords();
                                setState(() {
                                  isLoading = false;
                                });

                                if (result == "Login successful") {
                                  // Navigate to Dashboard on successful login
                                  context.go("/dashboard");
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(result,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: red,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      backgroundColor: spot_red,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.only(
                                        bottom:
                                            MediaQuery.of(context).size.height -
                                                100,
                                        left: !ResponsiveWidget.isSmallScreen(
                                                context)
                                            ? 300
                                            : 30,
                                        right: !ResponsiveWidget.isSmallScreen(
                                                context)
                                            ? 300
                                            : 30,
                                      ),
                                      action: SnackBarAction(
                                        label: 'X',
                                        textColor: secondary,
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.black,
                                    ),
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: secondary,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
