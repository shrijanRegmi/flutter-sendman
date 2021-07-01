import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_man/views/screens/getting_started_screen.dart';
import 'package:send_man/views/screens/home_screen.dart';
import 'package:send_man/views/screens/splash_screen.dart';

import 'models/app_user.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 3000), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _appUser = Provider.of<AppUser?>(context);

    if (_isLoading) return SplashScreen();
    if (_appUser == null) return GettingStartedScreen();
    return HomeScreen();
  }
}
