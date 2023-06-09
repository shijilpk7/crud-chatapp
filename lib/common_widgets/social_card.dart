import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../size_config.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({
    Key? key,
    this.icon,
    this.press,
  }) : super(key: key);

  final String? icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press!,
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        padding: EdgeInsets.all(getProportionateScreenWidth(12)),
        // height: getProportionateScreenHeight(40),
        // width: getProportionateScreenWidth(100),
        decoration: BoxDecoration(
            color: Color(0xFFF5F6F9),
            borderRadius: BorderRadius.all(Radius.circular(25))
            // shape: BoxShape.circle,
            ),
        child: Row(
          children: [
            SvgPicture.asset(icon!),
            SizedBox(
              width: getProportionateScreenWidth(25),
            ),
            Text('Login with google')
          ],
        ),
      ),
    );
  }
}
