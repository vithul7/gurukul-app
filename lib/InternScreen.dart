import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gurukul_1/InternCommentView.dart';
import 'ExperiencedSuggestion.dart';
import 'OneYearSuggestion.dart';
import 'MainPage.dart';
import 'InternModel.dart';
import 'StudentSearch.dart';

const yellow = const Color(0xffFFEB3B);
const darkGreen = const Color(0xff388E3C);
const lightGreen = const Color(0xffC8E6C9);
const black = const Color(0xff212121);
const green = const Color(0xff4CAf50);
const white = const Color(0xffFFFFFF);
const gray = const Color(0xff757575);
const lightGray = const Color(0xffBDBDBD);
const middleGreen = const Color(0xff4CBB17);

class InternScreen extends StatefulWidget {
  const InternScreen({Key? key}) : super(key: key);

  @override
  _InternScreenState createState() => _InternScreenState();
}

class _InternScreenState extends State<InternScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  InternModel loggedInUser = InternModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = InternModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreen,
      appBar: AppBar(
        title: Text('${loggedInUser.name}'),
        centerTitle: true,
        backgroundColor: middleGreen,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 180),
              _searchButton(),
              SizedBox(height: 20),
              _commentButton(),
              SizedBox(height: 20),
              _logOutButton(),
            ],
          ),
        ),
      ),
    );
  }

  TextButton _logOutButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: white,
        backgroundColor: darkGreen,
        fixedSize: const Size.fromWidth(175),
      ),
      child: Text('Log out', style: TextStyle(fontSize: 20)),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
      },
    );
  }

  TextButton _searchButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: white,
        backgroundColor: darkGreen,
        fixedSize: const Size.fromWidth(175),
      ),
      child: Text('Search', style: TextStyle(fontSize: 20)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StudentSearch()),
        );
      },
    );
  }

  TextButton _commentButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: white,
        backgroundColor: darkGreen,
        fixedSize: const Size.fromWidth(175),
      ),
      child: Text('My Comments', style: TextStyle(fontSize: 20)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InternCommentView()),
        );
      },
    );
  }
}
