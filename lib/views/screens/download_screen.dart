import 'dart:math';

import 'package:flutter/material.dart';
import 'package:send_man/enums/progress_status_type.dart';
import 'package:send_man/viewmodels/download_vm.dart';
import 'package:send_man/viewmodels/vm_provider.dart';
import 'package:send_man/views/widgets/common_widgets/round_icon_button.dart';
import 'package:send_man/views/widgets/common_widgets/text_builder.dart';
import 'package:send_man/views/widgets/common_widgets/progress_status_builder.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VMProvider<DownloadVm>(
      vm: DownloadVm(context),
      builder: (context, vm) {
        return Scaffold(
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _titleBuilder(vm),
                            _urlInputBuilder(vm),
                            Container(),
                            Container(),
                          ],
                        ),
                      ),
                    ),
                    ProgressStatusBuilder(
                      type: ProgressStatusType.download,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _titleBuilder(final DownloadVm vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBuilder.heading2('Download'),
            TextBuilder.heading4(
              'Press the button to download',
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        Transform.rotate(
          angle: pi / 180 * 30,
          child: RoundIconButton(
            onPressed: vm.downloadImage,
            padding: const EdgeInsets.all(15.0),
            icon: Icon(Icons.keyboard_arrow_down_rounded),
            shadow: BoxShadow(
              color: Colors.deepPurple.withOpacity(0.3),
              blurRadius: 20.0,
              offset: Offset(5.0, 10.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _urlInputBuilder(final DownloadVm vm) {
    return Column(
      children: [
        TextFormField(
          controller: vm.urlController,
          decoration: InputDecoration(
            hintText: 'Image url...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.deepPurple,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 10.0,
                ),
                child: TextBuilder.body(
                  'Note: By pressing the download button on the top right corner, you will be downloading all the images that is related with this url.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
