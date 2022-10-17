import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'InternScreen.dart';
import 'MainPage.dart';
import 'StudentSearch.dart';

//make error font bigger
//make it not red
//make the app bar font different color
//maybe do forgot password? probably not
//maybe have it remember user

const yellow = const Color(0xffFFEB3B);
const darkGreen = const Color(0xff388E3C);
const lightGreen = const Color(0xffC8E6C9);
const black = const Color(0xff212121);
const green = const Color(0xff4CAf50);
const white = const Color(0xffFFFFFF);
const gray = const Color(0xff757575);
const lightGray = const Color(0xffBDBDBD);
const middleGreen = const Color(0xff4CBB17);

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController classroomController = new TextEditingController();
  TextEditingController commentOneController = new TextEditingController();
  TextEditingController commentTwoController = new TextEditingController();
  TextEditingController commentThreeController = new TextEditingController();
  TextEditingController commentFourController = new TextEditingController();
  TextEditingController commentFiveController = new TextEditingController();
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreen,
      appBar: AppBar(
        title: Text('Add Student'),
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
                  addButton(),
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

  TextButton addButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: lightGreen,
        fixedSize: const Size.fromWidth(200),
      ),
      child: Text('Add Student', style: TextStyle(fontSize: 20)),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          await students.add({
            'name': nameController.text,
            'classroom': classroomController.text,
            'commentOne': commentOneController.text,
            'commentTwo': commentTwoController.text,
            'commentThree': commentThreeController.text,
          }).then((value) => print('student added'));
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
          if (value!.isEmpty) {
            return "Enter a classroom";
          }
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
          errorStyle: TextStyle(
              color: black, fontSize: 15, fontWeight: FontWeight.bold),
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
          if (value!.isEmpty) {
            return "Please enter a student name";
          }
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
