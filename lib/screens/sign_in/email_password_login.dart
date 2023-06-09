import 'package:crud/common_widgets/utilfunctions.dart';
import 'package:crud/screens/chat/chatpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../size_config.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      UtilFunctions.showLoaderDialog(context);
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      Navigator.pop(context);
      if (userCredential.user?.email != null) {
        // Login successful, do something with the userCredential
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => Chatpage(email: userCredential.user!.email!)));
      } else {
        UtilFunctions.msgDialog(context,
            text: 'Something wen wrong. Please try again');
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        UtilFunctions.msgDialog(context, text: 'No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        UtilFunctions.msgDialog(context,
            text: 'Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to CRUD",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(28),
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 900.ms),
            SizedBox(height: getProportionateScreenHeight(15)),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                hintText: 'Email',
                enabled: true,
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black),
                  borderRadius: new BorderRadius.circular(10),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.transparent),
                  borderRadius: new BorderRadius.circular(10),
                ),
              ),
            ).animate().fadeIn(delay: 900.ms),
            SizedBox(height: getProportionateScreenHeight(15)),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                hintText: 'password',
                enabled: true,
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black),
                  borderRadius: new BorderRadius.circular(10),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.transparent),
                  borderRadius: new BorderRadius.circular(10),
                ),
              ),
              obscureText: true,
            ).animate().fadeIn(delay: 1500.ms),
            const SizedBox(height: 16.0),
            Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: Color.fromARGB(255, 4, 111, 211), width: 1),
                    color: const Color(0xffffffff)),
                height: getProportionateScreenHeight(35),
                width: getProportionateScreenWidth(200),
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        _login();
                      } else {
                        UtilFunctions.msgDialog(context,
                            text: 'Please enter all the details to continue');
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.black),
                    ))).animate().fadeIn(delay: 2000.ms),
          ],
        ),
      ),
    );
  }
}
