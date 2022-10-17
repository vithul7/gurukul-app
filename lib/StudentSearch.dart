import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

import 'AddStudent.dart';
import 'DeleteStudent.dart';
import 'EditStudent.dart';
import 'InternScreen.dart';

const yellow = const Color(0xffFFEB3B);
const darkGreen = const Color(0xff388E3C);
const lightGreen = const Color(0xffC8E6C9);
const black = const Color(0xff212121);
const green = const Color(0xff4CAf50);
const white = const Color(0xffFFFFFF);
const gray = const Color(0xff757575);
const lightGray = const Color(0xffBDBDBD);
const middleGreen = const Color(0xff4CBB17);

TextEditingController searchController = new TextEditingController();
String studentId = "none";
bool searchButtonPressed = false;
bool editButtonPressed = false;
bool deleteButtonPressed = false;

class StudentSearch extends StatefulWidget {
  const StudentSearch({Key? key}) : super(key: key);

  @override
  _StudentSearchState createState() => _StudentSearchState();
}

class _StudentSearchState extends State<StudentSearch> {
  final _formKey = GlobalKey<FormState>();
  final Stream<QuerySnapshot> students = FirebaseFirestore.instance
      .collection('students')
      .snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreen,
      appBar: AppBar(
        title: Text('Search'),
        centerTitle: true,
        backgroundColor: middleGreen,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              internScreenButton(),
            ]),
            SizedBox(height: 10),
            searchTextField(),
            SizedBox(height: 20),
            searchButton(),
            Expanded(child: displaySearchedData()),
            addButton(),
            editButton(),
            deleteButton(),
          ],
        ),
      ),
    );
  }

  Container displaySearchedData() {
    return Container(
      // color: darkGreen,

      padding: const EdgeInsets.symmetric(vertical: 20),
      child: StreamBuilder<QuerySnapshot>(
        stream: students,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text('something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }

          final data = snapshot.requireData;

          return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                if (data.docs[index]['name'] == searchController.text &&
                    searchButtonPressed == true) {
                  searchButtonPressed = false;
                  return Column(children: [
                    Text(
                      '${data.docs[index]['name']}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Text('Classroom: ${data.docs[index]['classroom']}',
                        style: TextStyle(fontSize: 20)),
                    Text('Comment 1: ${data.docs[index]['commentOne']}',
                        style: TextStyle(fontSize: 15)),
                    Text('Comment 2: ${data.docs[index]['commentTwo']}',
                        style: TextStyle(fontSize: 15)),
                    Text('Comment 3: ${data.docs[index]['commentThree']}',
                        style: TextStyle(fontSize: 15)),
                  ]);
                  return Text(
                      '${data.docs[index]['name']} and ${data.docs[index]['classroom']} and ${data.docs[index]['comments']}');
                } else if (data.docs[index]['name'] == searchController.text &&
                    editButtonPressed == true) {
                  studentId = data.docs[index].id;
                  editButtonPressed = false;
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditStudent(studentId),
                        ));
                  });
                } else if (data.docs[index]['name'] == searchController.text &&
                    deleteButtonPressed == true) {
                  studentId = data.docs[index].id;
                  deleteButtonPressed = false;
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeleteStudent(studentId),
                        ));
                  });
                }
                return new Container(height: 0.0, width: 0.0);
              });
        },
      ),
    );
  }

  TextButton editButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: green,
        fixedSize: const Size.fromWidth(200),
      ),
      child: Text('Edit Student', style: TextStyle(fontSize: 20)),
      onPressed: () {
        setState(() {
          editButtonPressed = true;
        });
      },
    );
  }

  TextFormField searchTextField() {
    return TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter a name to search";
          }
        },
        autofocus: false,
        keyboardType: TextInputType.text,
        controller: searchController,
        onSaved: (value) {
          searchController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 15),
          hintText: "Student Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: green,
          filled: true,
          hintStyle: TextStyle(color: black),
        ));
  }

  TextButton addButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: green,
        fixedSize: const Size.fromWidth(200),
      ),
      child: Text('Add Student', style: TextStyle(fontSize: 20)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddStudent()),
        );
        setState(() {
          searchButtonPressed = true;
        });
      },
    );
  }

  TextButton searchButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: green,
        fixedSize: const Size.fromWidth(200),
      ),
      child: Text('Search!', style: TextStyle(fontSize: 20)),
      onPressed: () {
        setState(() {
          searchButtonPressed = true;
        });
      },
    );
  }

  TextButton deleteButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: green,
        fixedSize: const Size.fromWidth(200),
      ),
      child: Text('Delete Student', style: TextStyle(fontSize: 20)),
      onPressed: () {
        setState(() {
          deleteButtonPressed = true;
        });
      },
    );
  }

  TextButton internScreenButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: green,
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
