import 'package:flutter/material.dart';
import '../../size_config.dart';
import 'components/sign_in_body.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
