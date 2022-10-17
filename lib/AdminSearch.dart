import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'AddStudent.dart';
import 'AdminScreen.dart';
import 'EditIntern.dart';
import 'EditStudent.dart';
import 'ExperiencedSuggestion.dart';
import 'OneYearSuggestion.dart';

//this is a copy of main page for now
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
String userId = "none";
bool searchButtonPressed = false;
bool editButtonPressed = false;
bool suggestionsButtonPressed = false;

class AdminSearch extends StatefulWidget {
  const AdminSearch({Key? key}) : super(key: key);

  @override
  _AdminSearchState createState() => _AdminSearchState();
}

class _AdminSearchState extends State<AdminSearch> {
  final _formKey = GlobalKey<FormState>();
  final Stream<QuerySnapshot> users = FirebaseFirestore.instance
      .collection('users')
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
            editButton(),
            _suggestionButton(),
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
        stream: users,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text('Error');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
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
                    Text('Comment 1: ${data.docs[index]['comments'][0]}',
                        style: TextStyle(fontSize: 15)),
                    Text('Comment 2: ${data.docs[index]['comments'][1]}',
                        style: TextStyle(fontSize: 15)),
                    Text('Comment 3: ${data.docs[index]['comments'][2]}',
                        style: TextStyle(fontSize: 15)),
                    Text('Years of Experience: ${data.docs[index]['years']}',
                        style: TextStyle(fontSize: 15)),
                  ]);
                } else if (data.docs[index]['name'] == searchController.text &&
                    editButtonPressed == true) {
                  userId = data.docs[index].id;
                  editButtonPressed = false;
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditIntern(userId),
                        ));
                  });
                } else if (data.docs[index]['name'] == searchController.text &&
                    suggestionsButtonPressed == true) {
                  if (data.docs[index]['years'] != "") {
                    suggestionsButtonPressed = false;
                    if (data.docs[index]['years'] == "1") {
                      WidgetsBinding.instance?.addPostFrameCallback((_) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OneYearSuggestion(),
                            ));
                      });
                    } else {
                      WidgetsBinding.instance?.addPostFrameCallback((_) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExperiencedSuggestion(),
                            ));
                      });
                    }
                  } else {
                    suggestionsButtonPressed = false;
                    Fluttertoast.showToast(
                        msg: "Contact overseer to input number of years");
                  }
                }
                return new Container(height: 0.0, width: 0.0);
              });
        },
      ),
    );
  }

  TextButton internScreenButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: green,
        fixedSize: const Size.fromWidth(175),
      ),
      child: Text('Admin Screen', style: TextStyle(fontSize: 20)),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AdminScreen()));
      },
    );
  }

  TextButton _suggestionButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: green,
        fixedSize: const Size.fromWidth(200),
      ),
      child: Text('Suggestions', style: TextStyle(fontSize: 20)),
      onPressed: () {
        setState(() {
          suggestionsButtonPressed = true;
        });
      },
    );
  }

  TextButton editButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: green,
        fixedSize: const Size.fromWidth(200),
      ),
      child: Text('Edit Intern', style: TextStyle(fontSize: 20)),
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
          hintText: "Intern or Overseer Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: green,
          filled: true,
          hintStyle: TextStyle(color: black),
        ));
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
}
