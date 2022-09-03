// ignore_for_file: avoid_print, unnecessary_null_comparison, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myform/screens/signUp.dart';

import 'homepage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showspinner = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  // ******* dispose 3**********
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showspinner,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 130),
                child: Text(
                  "Hello",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
                ),
              ),
              const Text(
                "Sign in to your accunt",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
                child: Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 225, 221, 221),
                      blurRadius: 25,
                      // offset: Offset(-1, -1)
                    )
                  ]),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //*********** */ For Email
                          Container(
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 195, 193, 193),
                                  blurRadius: 25)
                            ]),
                            child: TextFormField(
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.emailAddress,
                              controller: emailcontroller,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(30)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      )),
                                  hintText: "Email",
                                  // labelText: "Email",
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  )),
                              onSaved: (value) {
                                emailcontroller.text = value!;
                              },
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Email";
                                }

                                if (RegExp(
                                        "^[a-zA-Z0-9+_,-]+@[a-zA-Z0-9,-]+,[a-z]")
                                    .hasMatch(value)) {
                                  return " Please enter valid email";
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 10),
                            child: Container(
                              decoration: const BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 195, 193, 193),
                                    blurRadius: 25)
                              ]),
                              child: TextFormField(
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.text,
                                controller: passwordcontroller,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        )),
                                    hintText: "Password",
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Colors.black,
                                    )),

                                onSaved: (value) {
                                  passwordcontroller.text = value!;
                                },
                                // *************
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  RegExp regExp = RegExp(r'^.{6,}$');
                                  if (value!.isEmpty) {
                                    return "Password is required";
                                  }

                                  if (!regExp.hasMatch(value)) {
                                    return " Enter password password (6 character)";
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              //********************For forget Password

              const Padding(
                padding: EdgeInsets.only(left: 140, bottom: 90),
                child: Text(
                  "forget your password?",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      decoration: TextDecoration.underline),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    signIn(emailcontroller.text, passwordcontroller.text);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      // elevation: 20,
                      // shadowColor: Colors.grey,
                      // side: const BorderSide(color: Colors.green, width: 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 100, left: 70),
                    child: Text(
                      "Dont have an account?",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ));
                      },
                      child: const Text(
                        "Create",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  //login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successfully"),
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => const Homepage())))
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
