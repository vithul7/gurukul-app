import 'package:flutter/material.dart';
import 'package:gurukul_1/SearchPractice.dart';
import 'CreateAccount.dart';
import 'ExistingUser.dart';

const yellow = const Color(0xffFFEB3B);
const darkGreen = const Color(0xff388E3C);
const lightGreen = const Color(0xffC8E6C9);
const black = const Color(0xff212121);
const green = const Color(0xff4CAf50);
const white = const Color(0xffFFFFFF);
const gray = const Color(0xff757575);
const lightGray = const Color(0xffBDBDBD);
const middleGreen = const Color(0xff4CBB17);

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreen,
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: middleGreen,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Image.asset('images/gurukul.png'),
            ),
            existingUserButton(context),
            createAccountButton(context),
          ],
        ),
      ),
    );
  }

  TextButton createAccountButton(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: lightGreen,
        fixedSize: const Size.fromWidth(250),
      ),
      child: Text('Create Account'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateAccount()),
        );
      },
    );
  }

  TextButton existingUserButton(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: lightGreen,
        fixedSize: const Size.fromWidth(250),
      ),
      child: Text('Existing User'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ExistingUser()),
        );
      },
    );
  }
}
