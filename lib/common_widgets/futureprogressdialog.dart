// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

const _DefaultDecoration = BoxDecoration(
  color: Colors.white,
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.all(Radius.circular(10)),
);

class FutureProgressDialog extends StatelessWidget {
  /// Dialog will be closed when [future] task is finished.
  @required
  final Future future;

  /// [BoxDecoration] of [FutureProgressDialog].
  final BoxDecoration? decoration;

  /// opacity of [FutureProgressDialog]
  final double? opacity;

  /// If you want to use custom progress widget set [progress].
  final Widget? progress;

  /// If you want to use message widget set [message].
  final Widget? message;

  FutureProgressDialog(
    this.future, {
    this.decoration,
    this.opacity = 1.0,
    this.progress,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    future.then((val) {
      Navigator.of(context).pop(val);
    }).catchError((e) {
      Navigator.of(context).pop();
    });

    return WillPopScope(
      child: _buildDialog(context),
      onWillPop: () {
        return Future(() {
          return false;
        });
      },
    );
  }

  Widget _buildDialog(BuildContext context) {
    var content;
    if (message == null) {
      content = Center(
        child: Container(
          height: 30,
          width: 30,
          child: LoadingAnimationWidget.twistingDots(
            leftDotColor: Colors.green,
            rightDotColor: Colors.yellow,
            size: 30,
          ),
        ),
      );
    } else {
      content = Container(
        height: 100,
        padding: const EdgeInsets.all(20),
        decoration: decoration ?? _DefaultDecoration,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          progress ??
              LoadingAnimationWidget.twistingDots(
                leftDotColor: Colors.green,
                rightDotColor: Colors.yellow,
                size: 30,
              ),
          SizedBox(width: 20),
          _buildText(context)
        ]),
      );
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Opacity(
        opacity: opacity!,
        child: content,
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    if (message == null) {
      return SizedBox.shrink();
    }
    return Expanded(
      flex: 1,
      child: message!,
    );
  }
}
