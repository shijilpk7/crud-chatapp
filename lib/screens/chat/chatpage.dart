import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/screens/sign_in/email_password_login.dart';
import 'package:crud/services/firebase_services.dart';
import 'package:crud/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../services/message.dart';

class Chatpage extends StatefulWidget {
  String email;
  Chatpage({required this.email});
  @override
  _ChatpageState createState() => _ChatpageState(email: email);
}

class _ChatpageState extends State<Chatpage> {
  String email;
  _ChatpageState({required this.email});

  final fs = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController message = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Messages').animate().fadeIn(),
        actions: [
          MaterialButton(
            onPressed: () {
              Provider.of<GoogleSignInProvider>(context, listen: false)
                  .logout();
              _auth.signOut().whenComplete(() {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              });
            },
            child: Text("SignOut"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: getProportionateScreenHeight(690),
                child: messages(email: email)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: message,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        hintText: 'message',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: new BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.transparent),
                          borderRadius: new BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        message.text = value!;
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (message.text.isNotEmpty) {
                        fs.collection('Messages').doc().set({
                          'message': message.text.trim(),
                          'time': DateTime.now(),
                          'email': email
                        });
                        message.clear();
                      }
                      FocusScope.of(context).unfocus();
                    },
                    icon: Icon(Icons.send_sharp),
                  ),
                ],
              ).animate().slideX(duration: 900.ms),
            )
          ],
        ),
      ),
    );
  }
}
