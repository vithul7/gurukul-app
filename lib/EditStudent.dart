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

class EditStudent extends StatefulWidget {
  final String studentId;
  EditStudent(this.studentId, {Key? key}) : super(key: key);

  @override
  _EditStudentState createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController classroomController = new TextEditingController();
  TextEditingController commentOneController = new TextEditingController();
  TextEditingController commentTwoController = new TextEditingController();
  TextEditingController commentThreeController = new TextEditingController();

  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreen,
      appBar: AppBar(
        title: Text('Edit Student'),
        centerTitle: true,
        backgroundColor: middleGreen,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  backToSearchButton(),
                  SizedBox(height: 12),
                  nameTextField(),
                  SizedBox(height: 12),
                  classroomTextField(),
                  SizedBox(height: 12),
                  commentOneTextField(),
                  SizedBox(height: 12),
                  commentTwoTextField(),
                  SizedBox(height: 12),
                  commentThreeTextField(),
                  SizedBox(height: 12),
                  editButton(),
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
        fixedSize: const Size.fromWidth(175),
      ),
      child: Text('Back to Search', style: TextStyle(fontSize: 20)),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const StudentSearch()));
      },
    );
  }

  TextButton editButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: lightGreen,
        fixedSize: const Size.fromWidth(200),
      ),
      child: Text('Edit Student', style: TextStyle(fontSize: 20)),
      onPressed: () async {
        // addStudent(nameController.text, classroomController.text, commentOneController.text, commentTwoController.text, commentThreeController.text,
        // commentFourController.text, commentFiveController.text);

        if (_formKey.currentState!.validate()) {
          if (nameController.text != "") {
            await students.doc(studentId).update({
              'name': nameController.text,
            }).then((value) => print('student added'));
          }
          if (classroomController.text != "") {
            await students.doc(studentId).update({
              'classroom': classroomController.text,
            }).then((value) => print('student added'));
          }
          if (commentOneController.text != "") {
            await students
                .doc(studentId)
                .update({'commentOne': commentOneController.text}).then(
                    (value) => print('student added'));
          }
          if (commentTwoController.text != "") {
            await students
                .doc(studentId)
                .update({'commentTwo': commentTwoController.text}).then(
                    (value) => print('student added'));
          }
          if (commentThreeController.text != "") {
            await students
                .doc(studentId)
                .update({'commentThree': commentThreeController.text}).then(
                    (value) => print('student added'));
          }

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StudentSearch()),
          );
        }
      },
    );
  }

  TextFormField classroomTextField() {
    return TextFormField(
        validator: (value) {
          return null;
        },
        autofocus: false,
        keyboardType: TextInputType.text,
        controller: classroomController,
        onSaved: (value) {
          classroomController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 15),
          hintText: "Classroom",
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
          return null;
        },
        autofocus: false,
        keyboardType: TextInputType.text,
        controller: nameController,
        onSaved: (value) {
          nameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 15),
          hintText: 'Name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: lightGreen,
          filled: true,
          hintStyle: TextStyle(color: black),
        ));
  }

  TextFormField commentOneTextField() {
    return TextFormField(
        autofocus: false,
        keyboardType: TextInputType.text,
        controller: commentOneController,
        onSaved: (value) {
          commentOneController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 15),
          hintText: "Comment",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: lightGreen,
          filled: true,
          hintStyle: TextStyle(color: black),
        ));
  }

  TextFormField commentTwoTextField() {
    return TextFormField(
        autofocus: false,
        keyboardType: TextInputType.text,
        controller: commentTwoController,
        onSaved: (value) {
          commentTwoController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 15),
          hintText: "Comment",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: lightGreen,
          filled: true,
          hintStyle: TextStyle(color: black),
        ));
  }

  TextFormField commentThreeTextField() {
    return TextFormField(
        autofocus: false,
        keyboardType: TextInputType.text,
        controller: commentThreeController,
        onSaved: (value) {
          commentThreeController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 15),
          hintText: "Comment",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: lightGreen,
          filled: true,
          hintStyle: TextStyle(color: black),
        ));
  }
}
