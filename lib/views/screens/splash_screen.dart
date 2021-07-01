import 'package:flutter/material.dart';
import 'package:send_man/views/widgets/common_widgets/text_builder.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/app_icon.png',
                width: 100.0,
                height: 100.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              TextBuilder.heading1(
                "Send Man",
                style: TextStyle(
                  fontSize: 28.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
