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
  }
}
