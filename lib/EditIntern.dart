import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'AdminScreen.dart';
import 'AdminSearch.dart';
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

class EditIntern extends StatefulWidget {
  final String userId;

  EditIntern(this.userId, {Key? key}) : super(key: key);

  @override
  _EditInternState createState() => _EditInternState();
}

class _EditInternState extends State<EditIntern> {
  final _formKey = GlobalKey<FormState>();
  List comments = [];

  TextEditingController nameController = new TextEditingController();
  TextEditingController classroomController = new TextEditingController();
  TextEditingController commentOneController = new TextEditingController();
  TextEditingController commentTwoController = new TextEditingController();
  TextEditingController commentThreeController = new TextEditingController();
  TextEditingController yearsController = new TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreen,
      appBar: AppBar(
        title: Text('Edit Intern'),
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
                  yearsTextField(),
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
            MaterialPageRoute(builder: (context) => const AdminSearch()));
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
      child: Text('Edit Intern', style: TextStyle(fontSize: 20)),
      onPressed: () async {
        // addStudent(nameController.text, classroomController.text, commentOneController.text, commentTwoController.text, commentThreeController.text,
        // commentFourController.text, commentFiveController.text);
        FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            comments = documentSnapshot['comments'];
          }
        });

        if (_formKey.currentState!.validate()) {
          if (nameController.text != "") {
            await users.doc(userId).update({
              'name': nameController.text,
            }).then((value) => print('name edited'));
          }
          if (classroomController.text != "") {
            await users.doc(userId).update({
              'classroom': classroomController.text,
            }).then((value) => print('classroom edited'));
          }

          if (yearsController.text != "") {
            await users.doc(userId).update({
              'years': yearsController.text,
            }).then((value) => print('years edited'));
          }

          if (commentOneController.text != "") {
            comments[0] = commentOneController.text;
          }
          if (commentTwoController.text != "") {
            comments[1] = commentTwoController.text;
          }
          if (commentThreeController.text != "") {
            comments[2] = commentThreeController.text;
          }
          await users.doc(userId).update({
            'comments': comments,
          }).then((value) => print('comments edited'));

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdminSearch()),
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

  TextFormField yearsTextField() {
    return TextFormField(
        autofocus: false,
        keyboardType: TextInputType.text,
        controller: yearsController,
        onSaved: (value) {
          yearsController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 15),
          hintText: "Years of Experience",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: lightGreen,
          filled: true,
          hintStyle: TextStyle(color: black),
        ));
  }
}
