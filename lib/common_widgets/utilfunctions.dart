import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UtilFunctions {
  static showLoaderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoadingAnimationWidget.hexagonDots(
            color: Colors.white, size: 40);
      },
    );
  }

  static msgDialog(BuildContext? context, {String? text}) {
    return showDialog(
        // barrierDismissible: false,
        context: context!,
        builder: (_) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 40),
                  child: Text(
                    text!,
                    style: const TextStyle(
                        color: Color(0xff272727),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Inter",
                        fontStyle: FontStyle.normal,
                        fontSize: 15.0),
                  ),
                ),
                positionedWidget(context)
              ],
            ),
          );
        });
  }

  static Widget positionedWidget(BuildContext context, {VoidCallback? onTap}) {
    return Positioned(
        right: -10,
        top: -10,
        child: GestureDetector(
          onTap: onTap ??
              () {
                Navigator.pop(context);
              },
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: const Center(
                    child: Icon(Icons.close, color: Colors.white, size: 18))),
          ),
        ));
  }
}
