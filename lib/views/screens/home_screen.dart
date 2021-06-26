import 'package:flutter/material.dart';
import 'package:send_man/viewmodels/home_vm.dart';
import 'package:send_man/viewmodels/vm_provider.dart';
import 'package:send_man/views/widgets/common_widgets/text_builder.dart';
import 'package:send_man/views/widgets/home_widgets/upload_download_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VMProvider<HomeVM>(
      vm: HomeVM(),
      builder: (context, vm) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _appbarBuilder(),
                      SizedBox(
                        height: 20.0,
                      ),
                      _titleAndSubtitleBuilder(),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  UploadDownloadButtons(),
                  SizedBox(
                    height: 40.0,
                  ),
                  _connectBuilder(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _appbarBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // AvatarBuilder(
        //   imgUrl:
        //       'https://img.freepik.com/free-photo/young-handsome-man-with-beard-isolated-keeping-arms-crossed-frontal-position_1368-132662.jpg?size=626&ext=jpg&ga=GA1.2.136948160.1615680000',
        // ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }

  Widget _titleAndSubtitleBuilder() {
    return Center(
      child: Column(
        children: [
          TextBuilder.heading1(
            'Share everything',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextBuilder.heading1(
            'For everyone',
            style: TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _connectBuilder() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBuilder.heading2('Connect across'),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Center(
              child: Image.asset('assets/images/connect.png'),
            ),
          )
        ],
      ),
    );
  }
}
