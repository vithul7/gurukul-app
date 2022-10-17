import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'InternScreen.dart';
import 'MainPage.dart';
import 'InternModel.dart';

const yellow = const Color(0xffFFEB3B);
const darkGreen = const Color(0xff388E3C);
const lightGreen = const Color(0xffC8E6C9);
const black = const Color(0xff212121);
const green = const Color(0xff4CAf50);
const white = const Color(0xffFFFFFF);
const gray = const Color(0xff757575);
const lightGray = const Color(0xffBDBDBD);
const middleGreen = const Color(0xff4CBB17);

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController newEmailController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController newNameController = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreen,
      appBar: AppBar(
        title: Text('Create Account'),
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
                    nameTextField(),
                    SizedBox(height: 20),
                    emailTextField(),
                    SizedBox(height: 20),
                    passwordTextField(),
                    SizedBox(height: 20),
                    confirmPasswordTextField(),
                    SizedBox(height: 30),
                    createAccountButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextButton createAccountButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: lightGreen,
        fixedSize: const Size.fromWidth(200),
      ),
      child: Text('Create Account', style: TextStyle(fontSize: 20)),
      onPressed: () {
        signUp(newEmailController.text, newPasswordController.text);
      },
    );
  }

  TextFormField confirmPasswordTextField() {
    return TextFormField(
        validator: (value) {
          if (confirmPasswordController.text != newPasswordController.text) {
            return "Passwords must match";
          }
          return null;
        },
        obscureText: true,
        autofocus: false,
        keyboardType: TextInputType.text,
        controller: confirmPasswordController,
        onSaved: (value) {
          confirmPasswordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          errorStyle: TextStyle(
              color: black, fontSize: 15, fontWeight: FontWeight.bold),
          contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: lightGreen,
          filled: true,
          hintStyle: TextStyle(color: black),
        ));
  }

  TextFormField passwordTextField() {
    return TextFormField(
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return "Enter a password to sign up";
          } else if (!regex.hasMatch(value)) {
            return "Valid passwords contain atleast six characters";
          }
        },
        obscureText: true,
        autofocus: false,
        keyboardType: TextInputType.text,
        controller: newPasswordController,
        onSaved: (value) {
          newPasswordController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          errorStyle: TextStyle(
              color: black, fontSize: 15, fontWeight: FontWeight.bold),
          contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 15),
          hintText: "New Password",
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
        controller: newEmailController,
        onSaved: (value) {
          newEmailController.text = value!;
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

  TextFormField nameTextField() {
    return TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Please type your name";
          }
        },
        autofocus: false,
        keyboardType: TextInputType.text,
        controller: newNameController,
        onSaved: (value) {
          newNameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          errorStyle: TextStyle(
              color: black, fontSize: 15, fontWeight: FontWeight.bold),
          contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 15),
          hintText: "Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: lightGreen,
          filled: true,
          hintStyle: TextStyle(color: black),
        ));
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFireStore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFireStore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    InternModel userModel = InternModel();

    userModel.email = user!.email;
    userModel.userId = user.uid;
    userModel.name = newNameController.text;
    userModel.comments = [" ", " ", " "];
    userModel.classroom = "";
    userModel.years = "";

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Created account! ");
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => MainPage()), (route) => false);
  }
}
