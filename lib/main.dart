import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:send_man/wrapper.dart';
import 'package:send_man/wrapper_builder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(SendManApp());
}

class SendManApp extends StatelessWidget {
  const SendManApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureProvider<AndroidDeviceInfo?>.value(
      value: DeviceInfoPlugin().androidInfo,
      initialData: null,
      child: FutureBuilder(
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
      ),
    );
  }
}
