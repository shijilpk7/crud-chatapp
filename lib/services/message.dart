import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../size_config.dart';

class messages extends StatefulWidget {
  String email;
  messages({required this.email});
  @override
  _messagesState createState() => _messagesState(email: email);
}

class _messagesState extends State<messages> {
  String email;
  _messagesState({required this.email});

  Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
      .collection('Messages')
      .orderBy('time')
      .snapshots();

  // ScrollController listScrollController = ScrollController();

  // @override
  // void initState() {
  //   super.initState();
  //   // Scroll to the bottom of the ListView after the layout is complete
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (listScrollController.hasClients) {
  //       final position = listScrollController.position.maxScrollExtent;
  //       listScrollController.animateTo(position,
  //           duration: Duration(seconds: 3), curve: Curves.easeOut);
  //     }
  //     ;
  //   });
  // }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("something is wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: LoadingAnimationWidget.hexagonDots(
                  color: Colors.white, size: 40));
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemBuilder: (_, index) {
            QueryDocumentSnapshot qs = snapshot.data!.docs[index];
            Timestamp t = qs['time'];
            DateTime d = t.toDate();
            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: email == qs['email']
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: SizedBox(
                      width: 300,
                      child: Card(
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          title: Text(qs['email'],
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: getProportionateScreenWidth(10))),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 200,
                                child: Text(
                                  qs['message'],
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          getProportionateScreenWidth(15)),
                                ),
                              ),
                              Text(
                                  d.hour.toString() + ":" + d.minute.toString(),
                                  style: TextStyle(
                                      fontSize:
                                          getProportionateScreenWidth(10)))
                            ],
                          ),
                        ),
                      ),
                    ).animate().fadeIn(duration: 900.ms),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
