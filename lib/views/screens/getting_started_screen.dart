import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:send_man/utils/app_colors.dart';
import 'package:send_man/views/screens/home_screen.dart';
import 'package:send_man/views/widgets/common_widgets/text_builder.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  _textBuilder(),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buttonBuilder(context),
                ],
              ),
            ),
            Positioned(
              right: 0.0,
              top: 20.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _stipeBuilder(
                    kcOrangeColor.withOpacity(0.7),
                    150.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _stipeBuilder(
                    kcOrangeColor,
                    100.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stipeBuilder(final Color color, final double width) {
    return Container(
      width: width,
      height: 30.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          bottomLeft: Radius.circular(40.0),
        ),
      ),
    );
  }

  Widget _textBuilder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/app_icon.png',
          width: 100.0,
          height: 100.0,
        ),
        TextBuilder.heading1(
          "Hello",
          style: TextStyle(
            fontSize: 60.0,
          ),
        ),
        TextBuilder.heading4(
          'Welcome to Send Man !',
        ),
        SizedBox(
          height: 30.0,
        ),
        TextBuilder.body(
          "Share high quality disappearing images\nwith your friends to be awesome!",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget _buttonBuilder(final BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MaterialButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
            color: kcOrangeColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            textColor: Colors.white,
            padding: const EdgeInsets.all(19.0),
            child: Text(
              "Get Started",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
