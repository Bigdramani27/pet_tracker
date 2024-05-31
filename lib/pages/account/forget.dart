import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:kelpet/constants/colors.dart';
import 'package:kelpet/helpers/responsiveness.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  bool isLoading = false;

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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Trouble Logging in?',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: primary)),
                          Text('Enter your email and we’ll send you a link ',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: primary)),
                          Text('to reset your password and get back',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: primary)),
                                  Text('into your account.',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: primary)),
                        ],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        ResponsiveWidget.isSmallScreen(context)
                                            ? 85
                                            : 95,
                                    vertical: 20),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: email.text);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  email.clear();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                          "A link has been sent to your email ",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: notification,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      backgroundColor: snackbar,
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
                                        onPressed: () {},
                                      ),
                                    ),
                                  );
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'invalid-email') {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            const Text("Email is not valid",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: red,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                        backgroundColor: spot_red,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              100,
                                          left: !ResponsiveWidget.isSmallScreen(
                                                  context)
                                              ? 300
                                              : 30,
                                          right:
                                              !ResponsiveWidget.isSmallScreen(
                                                      context)
                                                  ? 300
                                                  : 30,
                                        ),
                                        action: SnackBarAction(
                                          label: 'X',
                                          textColor: secondary,
                                          onPressed: () {},
                                        ),
                                      ),
                                    );
                                  }
                                }
                              }
                            },
                            child: isLoading
                                ? const Row(
                                    children: [
                                      Text(
                                        "Please wait..",
                                        style: TextStyle(color: tab),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Text(
                                    'Send Reset Link',
                                    style: TextStyle(
                                      color: secondary,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: primary,
                              thickness: 2,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "OR",
                            style: TextStyle(color: primary, fontSize: 18),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Divider(
                              color: primary,
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            context.go("/register");
                          },
                          child: const Center(
                            child: Text(
                              "Create New Account",
                              style: TextStyle(color: primary, fontSize: 18),
                            ),
                          ),
                        ),
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
