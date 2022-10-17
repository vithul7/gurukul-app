import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'AdminScreen.dart';
import 'InternScreen.dart';
import 'MainPage.dart';

const yellow = const Color(0xffFFEB3B);
const darkGreen = const Color(0xff388E3C);
const lightGreen = const Color(0xffC8E6C9);
const black = const Color(0xff212121);
const green = const Color(0xff4CAf50);
const white = const Color(0xffFFFFFF);
const gray = const Color(0xff757575);
const lightGray = const Color(0xffBDBDBD);
const middleGreen = const Color(0xff4CBB17);

class ExistingUser extends StatefulWidget {
  const ExistingUser({Key? key}) : super(key: key);

  @override
  _ExistingUserState createState() => _ExistingUserState();
}

class _ExistingUserState extends State<ExistingUser> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController adminController = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreen,
      appBar: AppBar(
        title: Text('Existing User'),
        centerTitle: true,
        backgroundColor: middleGreen,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      child: Image.asset('images/gurukul.png'),
                    ),
                    SizedBox(height: 50),
                    emailTextField(),
                    SizedBox(height: 15),
                    passwordTextField(),
                    SizedBox(height: 15),
                    adminTextField(),
                    SizedBox(height: 30),
                    logInButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextButton logInButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: lightGreen,
        fixedSize: const Size.fromWidth(200),
      ),
      child: Text('Log in!', style: TextStyle(fontSize: 20)),
      onPressed: () {
        signIn(emailController.text, passwordController.text);
      },
    );
  }

  TextFormField passwordTextField() {
    return TextFormField(
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return "Enter a password to log-in";
          } else if (!regex.hasMatch(value)) {
            return "Valid passwords contain atleast six characters";
          }
        },
        obscureText: true,
        autofocus: false,
        keyboardType: TextInputType.text,
        controller: passwordController,
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          errorStyle: TextStyle(
              color: black, fontSize: 15, fontWeight: FontWeight.bold),
          contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: lightGreen,
          filled: true,
          hintStyle: TextStyle(color: black),
        ));
  }

  TextFormField adminTextField() {
    return TextFormField(
        validator: (value) {
          if (value! != "" && value != "@d8320") {
            return "Leave the field blank or enter a valid code.";
          }
          return null;
        },
        autofocus: false,
        keyboardType: TextInputType.text,
        controller: adminController,
        obscureText: true,
        onSaved: (value) {
          adminController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          errorStyle: TextStyle(
              color: black, fontSize: 15, fontWeight: FontWeight.bold),
          contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 15),
          hintText: "If admin, enter code",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: lightGreen,
          filled: true,
          hintStyle: TextStyle(color: black),
        ));
  }

  TextFormField emailTextField() {
    return TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Please type your email";
          } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return "Enter an valid email";
          }
          return null;
        },
        autofocus: false,
        keyboardType: TextInputType.text,
        controller: emailController,
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          errorStyle: TextStyle(
              color: black, fontSize: 15, fontWeight: FontWeight.bold),
          contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: lightGreen,
          filled: true,
          hintStyle: TextStyle(color: black),
        ));
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      if (adminController.text == '@d8320') {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => AdminScreen()))
                })
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } else {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => InternScreen()))
                })
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      }
    }
  }
}
