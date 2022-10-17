import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_1/InternCommentView.dart';
import 'InternScreen.dart';
import 'MainPage.dart';
import 'InternModel.dart';
import 'StudentSearch.dart';

//make sure you can update just one comment
const yellow = const Color(0xffFFEB3B);
const darkGreen = const Color(0xff388E3C);
const lightGreen = const Color(0xffC8E6C9);
const black = const Color(0xff212121);
const green = const Color(0xff4CAf50);
const white = const Color(0xffFFFFFF);
const gray = const Color(0xff757575);
const lightGray = const Color(0xffBDBDBD);
const middleGreen = const Color(0xff4CBB17);

class InternCommentView extends StatefulWidget {
  const InternCommentView({Key? key}) : super(key: key);

  @override
  _InternCommentViewState createState() => _InternCommentViewState();
}

class _InternCommentViewState extends State<InternCommentView> {

  User? _user = FirebaseAuth.instance.currentUser;
  InternModel _loggedInUser = InternModel();
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
        title: Text('${_loggedInUser.name}'),
        centerTitle: true,
        backgroundColor: middleGreen,
      ),
      body:
        // padding: EdgeInsets.only(top: 225),
        SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    internScreenButton(),
                  ]),
                  SizedBox(height: 200),
                  Text('Classroom: ${_loggedInUser.classroom}',
                      style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  SizedBox(height: 5),
                  Text('${_loggedInUser.comments![0]}', style: TextStyle(fontSize: 15)),
                  SizedBox(height: 5),
                  Text('${_loggedInUser.comments![1]}', style: TextStyle(fontSize: 15)),
                  SizedBox(height: 5),
                  Text('${_loggedInUser.comments![2]}', style: TextStyle(fontSize: 15)),

                ],
              ),
        ),

    );
  }

  TextButton internScreenButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: white,
        backgroundColor: darkGreen,
        fixedSize: const Size.fromWidth(175),
      ),
      child: Text('Intern Screen', style: TextStyle(fontSize: 20)),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const InternScreen()));
      },
    );
  }





}
