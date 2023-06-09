import 'package:crud/screens/sign_in/email_password_login.dart';
import 'package:crud/services/common_viewmodel.dart';
import 'package:crud/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
      ChangeNotifierProvider(create: (_) => CommonViewModel()),
    ], child: MaterialApp(home: LoginScreen()));
  }
}
