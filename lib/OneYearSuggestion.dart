import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_1/InternCommentView.dart';
import 'AddStudent.dart';
import 'AdminScreen.dart';
import 'AdminSearch.dart';
import 'CommentNode.dart';
import 'CommentTree.dart';
import 'MainPage.dart';
import 'SecondCommentTree.dart';
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

class OneYearSuggestion extends StatefulWidget {
  const OneYearSuggestion({Key? key}) : super(key: key);

  @override
  _OneYearSuggestionState createState() => _OneYearSuggestionState();
}

class _OneYearSuggestionState extends State<OneYearSuggestion> {
  User? _user = FirebaseAuth.instance.currentUser;
  InternModel _loggedInUser = InternModel();
  CommentTree tree = CommentTree();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(_user!.uid)
        .get()
        .then((value) {
      this._loggedInUser = InternModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreen,
      appBar: AppBar(
        title: Text('Suggestion'),
        centerTitle: true,
        backgroundColor: middleGreen,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 130),
            backToSearchButton(),
            SizedBox(height: 40),
            _startButton(),
            SizedBox(height: 40),
            displaySuggestions(),
            SizedBox(height: 40),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _noButton(),
              _yesButton(),
            ]),
          ],
        ),
      ),
    );
  }

  TextButton backToSearchButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: white,
        backgroundColor: darkGreen,
        fixedSize: const Size.fromWidth(175),
      ),
      child: Text('Back to Search', style: TextStyle(fontSize: 20)),
      onPressed: () {
        setState(() {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => AdminSearch()), (route) => false);
        });
      },
    );
  }

  TextButton _noButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: white,
        backgroundColor: darkGreen,
        fixedSize: const Size.fromWidth(140),
      ),
      child: Text('No', style: TextStyle(fontSize: 20)),
      onPressed: () {
        setState(() {
          print("successfully traversed one to the left");
          if (tree.root!.getText()!.toString().endsWith("?")) {
            tree.root = tree.root?.left;
          }
        });
      },
    );
  }

  TextButton _yesButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: white,
        backgroundColor: darkGreen,
        fixedSize: const Size.fromWidth(140),
      ),
      child: Text('Yes', style: TextStyle(fontSize: 20)),
      onPressed: () {
        setState(() {
          if (tree.root!.getText()!.toString().endsWith("?")) {
            tree.root = tree.root?.right;
          }
        });
      },
    );
  }

  TextButton _startButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: white,
        backgroundColor: darkGreen,
        fixedSize: const Size.fromWidth(140),
      ),
      child: Text('Start/Reset', style: TextStyle(fontSize: 20)),
      onPressed: () {
        setState(() {
          tree.createTree();
        });
      },
    );
  }

  Text displaySuggestions() {
    return Text(
        tree.root?.getText() != null ? tree.root!.getText().toString() : "test",
        style: TextStyle(fontSize: 16));
  }
}
