import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/screens/sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../size_config.dart';
import '../../../common_widgets/futureprogressdialog.dart';
import '../../../common_widgets/social_card.dart';
import '../../../services/firebase_services.dart';
import '../../chat/chatpage.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Welcome to CRUD",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              GoogleLoginButton(),
              SizedBox(height: getProportionateScreenHeight(20)),
            ],
          ),
        ),
      ),
    );
  }
}

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialCard(
          icon: "assets/icons/google-icon.svg",
          press: () {
            showDialog(
                    context: context,
                    builder: (context) => FutureProgressDialog(
                        Provider.of<GoogleSignInProvider>(context,
                                listen: false)
                            .googleLogin()))
                //google login
                .then((value) {
              print(value);
              if (value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Chatpage(
                            email: Provider.of<GoogleSignInProvider>(context,
                                    listen: false)
                                .user
                                .email)));
              } else {
                showDialog(
                    context: context,
                    builder: (_) {
                      return Dialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Center(
                                      child: Text(
                                          'Something went wrong, Please try again')),
                                ),
                              ],
                            ),
                            Positioned(
                              right: -10,
                              top: -10,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8))),
                                      child: const Center(
                                          child: Icon(Icons.close,
                                              color: Colors.white, size: 18))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              }
            });
          },
        ),
        // SocialCard(
        //   icon: "assets/icons/facebook-2.svg",
        //   press: () {},
        // ),
        // SocialCard(
        //   icon: "assets/icons/twitter.svg",
        //   press: () {},
        // ),
      ],
    );
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final auth = FirebaseAuth.instance;
  CollectionReference ref = FirebaseFirestore.instance.collection('user');

  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmpassController =
      new TextEditingController();
  final TextEditingController emailController = new TextEditingController();

  var error = null;

  register(String email, String password) async {
    if (error == null) {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .whenComplete(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInScreen()));
      });
    } else {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(13, 71, 161, 1),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      filled: true, fillColor: Colors.white, hintText: 'Email'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: confirmpassController,
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Confirm Password'),
                  onChanged: (value) {
                    if (confirmpassController.text != passwordController.text) {
                      setState(() {
                        error = 'error';
                      });
                    } else {
                      setState(() {
                        error = null;
                      });
                    }
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MaterialButton(
                        height: 40,
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 20),
                        ),
                        color: Colors.white),
                    MaterialButton(
                        height: 40,
                        onPressed: () {
                          register(
                              emailController.text, passwordController.text);
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(fontSize: 20),
                        ),
                        color: Colors.white),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
