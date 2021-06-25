import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyBuilder extends StatefulWidget {
  final String? title;
  final String? subTitle;
  const EmptyBuilder({
    Key? key,
    this.title,
    this.subTitle,
  }) : super(key: key);

  @override
  _EmptyBuilderState createState() => _EmptyBuilderState();
}

class _EmptyBuilderState extends State<EmptyBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 2000,
      ),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Lottie.asset(
            'assets/lottie/chat_empty.json',
            width: MediaQuery.of(context).size.width - 150.0,
            height: MediaQuery.of(context).size.width - 150.0,
            controller: _animationController,
            onLoaded: (comp) {
              _animationController
                ..duration = Duration(milliseconds: 3000)
                ..repeat();
            },
          ),
          if (widget.title != null)
            Text(
              '${widget.title}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Color(
                  0xff3D4A5A,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          SizedBox(
            height: 10.0,
          ),
          if (widget.subTitle != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                '${widget.subTitle}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xff3D4A5A),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          SizedBox(
            height: 100.0,
          ),
        ],
      ),
    );
  }
}
