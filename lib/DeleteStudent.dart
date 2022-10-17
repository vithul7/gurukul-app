import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'InternScreen.dart';
import 'MainPage.dart';
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

class DeleteStudent extends StatefulWidget {
  final String studentId;
  DeleteStudent(this.studentId, {Key? key}) : super(key: key);



  @override
  _DeleteStudentState createState() => _DeleteStudentState();
}

class _DeleteStudentState extends State<DeleteStudent> {
  final _formKey = GlobalKey<FormState>();


  CollectionReference students = FirebaseFirestore.instance.collection('students');

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreen,
      appBar: AppBar(
        title: Text('Delete Student'),
        centerTitle: true,
        backgroundColor: middleGreen,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Expanded(
              child: Column(
                children: [
                  backToSearchButton(),
                  SizedBox(height: 12),
                  deleteButton(),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }

  TextButton backToSearchButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: lightGreen,
        fixedSize: const Size.fromWidth(200),
      ),
      child: Text('Back to Search', style: TextStyle(fontSize: 20)),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const StudentSearch()));
      },
    );
  }

  TextButton deleteButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: lightGreen,
        fixedSize: const Size.fromWidth(200),
      ),
      child: Text('Confirm Deletion', style: TextStyle(fontSize: 20)),
      onPressed: () async {
        students.doc(studentId).delete().then((value) => print("deleted"))
        .catchError((error) => print("couldn't delete"));

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StudentSearch()),
          );
        }
    );
  }






}
