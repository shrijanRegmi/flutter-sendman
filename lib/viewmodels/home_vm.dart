import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_man/services/ads/ad_provider.dart';

class HomeVM extends ChangeNotifier {
  final BuildContext context;
  HomeVM(this.context);

  AdProvider get adProvider => Provider.of<AdProvider>(context);
}
