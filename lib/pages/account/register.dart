import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kelpet/helpers/responsiveness.dart';

import '../../constants/colors.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool passwordVisible = true;
  bool cpasswordVisible = true;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final fname = TextEditingController();
  final lname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirm_password = TextEditingController();

  Future<String> createUserWithEmailAndPasswords() async {
    String result = "";
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      result = "Account Successfully created!";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        result = "Email is not valid";
      } else if (e.code == 'email-already-in-use') {
        result = "Email already in use ";
      } else if (e.code == 'weak-password') {
        result =
            "Password is not strong. Password must be at least 8 characters";
      } else {
        result = e.code.toString();
      }
    }
    return result;
  }

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
                width: 429,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                          },
                          child: const Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.arrowLeft,
                                color: primary,
                                size: 14,
                              ),
                              Text(
                                ' Back to Login Page',
                                style: TextStyle(color: primary, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: !ResponsiveWidget.isSmallScreen(context)
                              ? 50.0
                              : 20,
                          right: !ResponsiveWidget.isSmallScreen(context)
                              ? 50
                              : 20,
                          bottom: 10,
                          top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Kevin',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                  color: primary),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                child: const Text('First Name',
                                    style:
                                        TextStyle(color: active, fontSize: 12)),
                              ),
                              TextFormField(
                                controller: fname,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return "First name is empty";
                                  } else {
                                    return null;
                                  }
                                },
                                style: const TextStyle(color: primary),
                                textInputAction: TextInputAction.next,
                                // Set text color to white
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            primary), //// Set underline color to white
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: primary),
                                  ),
                                  hintText: 'Enter your first name',
                                  hintStyle:
                                      TextStyle(color: primary, fontSize: 14),
                                  // Set hint text color to white with some opacity
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(right: 12.0),
                                    child: Icon(FontAwesomeIcons.user,
                                        color: primary, size: 16),
                                  ), // Set icon color to white
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Last Name',
                                  style:
                                      TextStyle(color: active, fontSize: 12)),
                              TextFormField(
                                controller: lname,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return "Last name is empty";
                                  } else {
                                    return null;
                                  }
                                },
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(color: primary),
                                // Set text color to white
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            primary), //// Set underline color to white
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: primary),
                                  ),
                                  hintText: 'Enter your Last Name',
                                  hintStyle:
                                      TextStyle(color: primary, fontSize: 14),
                                  // Set hint text color to white with some opacity
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(right: 12.0),
                                    child: Icon(FontAwesomeIcons.user,
                                        color: primary, size: 16),
                                  ), // Set icon color to white
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Email',
                                  style:
                                      TextStyle(color: active, fontSize: 12)),
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
                                textInputAction: TextInputAction.next,
                                // Set text color to white
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            primary), //// Set underline color to white
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: primary),
                                  ),
                                  hintText: 'Enter your email address',
                                  hintStyle:
                                      TextStyle(color: primary, fontSize: 14),
                                  // Set hint text color to white with some opacity
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(right: 12.0),
                                    child: Icon(Icons.email,
                                        color: primary, size: 16),
                                  ), // Set icon color to white
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Password',
                                  style:
                                      TextStyle(color: active, fontSize: 12)),
                              TextFormField(
                                controller: password,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return "Password is empty";
                                  } else {
                                    return null;
                                  }
                                },
                                textInputAction: TextInputAction.done,
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
                                  hintStyle: const TextStyle(
                                      color: primary, fontSize: 14),
                                  // Set hint text color to white with some opacity
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(right: 12.0),
                                    child: Icon(Icons.lock,
                                        color: primary, size: 16),
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
                                  ), // Set icon color to white
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Confirm Password',
                                  style:
                                      TextStyle(color: active, fontSize: 12)),
                              TextFormField(
                                controller: confirm_password,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return "Confirm Password is empty";
                                  } else {
                                    return null;
                                  }
                                },
                                textInputAction: TextInputAction.done,
                                obscureText: cpasswordVisible,
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
                                  hintText: 'Enter your confirm password',
                                  hintStyle: const TextStyle(
                                      color: primary, fontSize: 14),
                                  // Set hint text color to white with some opacity
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(right: 12.0),
                                    child: Icon(Icons.lock,
                                        color: primary, size: 16),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        cpasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: primary,
                                        size: 16),
                                    onPressed: () {
                                      setState(
                                        () {
                                          cpasswordVisible = !cpasswordVisible;
                                        },
                                      );
                                    },
                                  ), // Set icon color to white
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primary,
                                    padding:
                                        ResponsiveWidget.isLargeScreen(
                                                    context) ||
                                                ResponsiveWidget.isMediumScreen(
                                                    context) ||
                                                ResponsiveWidget.isCustomSize(
                                                    context)
                                            ? const EdgeInsets.symmetric(
                                                horizontal: 97, vertical: 20)
                                            : const EdgeInsets.symmetric(
                                                horizontal: 69, vertical: 20),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (password.text !=
                                        confirm_password.text) {
                                      if (ResponsiveWidget.isSmallScreen(
                                          context)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                "Passwords do not match",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: red,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                            backgroundColor: spot_red,
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.only(
                                                bottom:  MediaQuery.of(context).size.height -
                                                 500,
                                                right: 30,
                                                left: 30),
                                            action: SnackBarAction(
                                              label: 'X',
                                              textColor: secondary,
                                              onPressed: () {
                                                // Some code to undo the change.
                                              },
                                            ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                "Passwords do not match",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: red,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                            backgroundColor: spot_red,
                                            behavior: SnackBarBehavior.floating,
                                            margin: const EdgeInsets.only(
                                                bottom: 650,
                                                right: 450,
                                                left: 450),
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

                                      return; // Don't proceed further
                                    }
                                    setState(() {
                                      isLoading = true;
                                    });
                                    String result =
                                        await createUserWithEmailAndPasswords();
                                    setState(() {
                                      isLoading = false;
                                    });

                                    if (result ==
                                        "Account Successfully created!") {
                                      var user = FirebaseAuth
                                          .instance.currentUser!.uid;
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(user)
                                          .set({
                                        "first_name": fname.text,
                                        "last_name": lname.text,
                                        "email": email.text,
                                        "time": FieldValue.serverTimestamp(),
                                      }, SetOptions(merge: true));
                                      await FirebaseAuth.instance.signOut();
                                      // Navigate to another page on successful login
                                      if (ResponsiveWidget.isSmallScreen(
                                          context)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(result,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: notification,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                            backgroundColor: snackbar,
                                            behavior: SnackBarBehavior.floating,
                                            margin:  EdgeInsets.only(
                                                bottom: MediaQuery.of(context).size.height -
                                                 500,
                                                right: 30,
                                                left: 30),
                                            action: SnackBarAction(
                                              label: 'X',
                                              textColor: secondary,
                                              onPressed: () {
                                                // Some code to undo the change.
                                              },
                                            ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(result,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: notification,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                            backgroundColor: snackbar,
                                            behavior: SnackBarBehavior.floating,
                                            margin: const EdgeInsets.only(
                                                bottom: 650,
                                                right: 450,
                                                left: 450),
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

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Login()), // Replace YourNextPage with the actual page you want to navigate to
                                      );
                                    } else {
                                      if (ResponsiveWidget.isSmallScreen(
                                          context)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(result,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: red,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                            backgroundColor: spot_red,
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.only(
                                                bottom:MediaQuery.of(context).size.height -
                                                 500,
                                                left: 50,
                                                right: 50),
                                            action: SnackBarAction(
                                              label: 'X',
                                              textColor: secondary,
                                              onPressed: () {
                                                // Some code to undo the change.
                                              },
                                            ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(result,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: red,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                            backgroundColor: spot_red,
                                            behavior: SnackBarBehavior.floating,
                                            margin: const EdgeInsets.only(
                                                bottom: 650,
                                                right: 450,
                                                left: 450),
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
                                        'Create Account',
                                        style: TextStyle(
                                          color: secondary,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ), //SizedBox
          ),
        ),
      ),
    );
  }
}
