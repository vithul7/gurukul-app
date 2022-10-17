import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

//this is a copy of main page for now
const yellow = const Color(0xffFFEB3B);
const darkGreen = const Color(0xff388E3C);
const lightGreen = const Color(0xffC8E6C9);
const black = const Color(0xff212121);
const green = const Color(0xff4CAf50);
const white = const Color(0xffFFFFFF);
const gray = const Color(0xff757575);
const lightGray = const Color(0xffBDBDBD);

TextEditingController searchController = new TextEditingController();
bool searchButtonPressed = true;

class SearchPractice extends StatefulWidget {
  const SearchPractice({Key? key}) : super(key: key);

  @override
  _SearchPracticeState createState() => _SearchPracticeState();
}

class _SearchPracticeState extends State<SearchPractice> {
  final _formKey = GlobalKey<FormState>();
  final Stream<QuerySnapshot> students = FirebaseFirestore.instance.collection('students').snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment View'),
        centerTitle: true,
        backgroundColor: yellow,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
             searchTextField(),
            SizedBox(height: 20),
            searchButton(),
            Container(
              height: 250,
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

                return ListView.builder (
                  itemCount: data.size,
                  itemBuilder: (context, index) {
                    if (data.docs[index]['name'] == searchController.text && searchButtonPressed == true) {
                      searchButtonPressed = false;
                      return Text('${data.docs[index]['name']} and ${data.docs[index]['classroom']} and ${data.docs[index]['comments']}');
                    }
                    return Text('');
                  }
                );
              },

              ),
            ),


          ],
        ),
      ),
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
          fillColor: lightGreen,
          filled: true,
          hintStyle: TextStyle(color: black),
        ));
  }

  TextButton searchButton() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: lightGreen,
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
