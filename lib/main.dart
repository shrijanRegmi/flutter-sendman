import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:send_man/wrapper.dart';
import 'package:send_man/wrapper_builder.dart';

void main() {
  runApp(SendManApp());
}

class SendManApp extends StatelessWidget {
  const SendManApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snap) {
        if (snap.data != null)
          return WrapperBuilder(
            builder: (context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  fontFamily: 'Nunito',
                ),
                title: 'Send Man',
                home: Material(child: Wrapper()),
              );
            },
          );

        return Container();
      },
    );
  }
}
