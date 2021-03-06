import 'dart:math';

import 'package:flutter/material.dart';
import 'package:send_man/enums/progress_status_type.dart';
import 'package:send_man/viewmodels/upload_vm.dart';
import 'package:send_man/viewmodels/vm_provider.dart';
import 'package:send_man/views/widgets/common_widgets/empty_builder.dart';
import 'package:send_man/views/widgets/common_widgets/round_icon_button.dart';
import 'package:send_man/views/widgets/common_widgets/text_builder.dart';
import 'package:send_man/views/widgets/common_widgets/progress_status_builder.dart';
import 'package:send_man/views/widgets/upload_widgets/image_grid.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VMProvider<UploadVM>(
      vm: UploadVM(context),
      builder: (context, vm) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _titleBuilder(vm),
                      Expanded(
                        child: vm.coreImagesList == null
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.orangeAccent,
                                ),
                              )
                            : vm.coreImagesList!.isEmpty
                                ? EmptyBuilder(
                                    title: 'Oh No...',
                                    subTitle:
                                        "Looks like you haven't uploaded any images yet! Press the upload button on the top right corner to upload your first image.",
                                  )
                                : SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        if (vm.todayImages?.isNotEmpty ?? false)
                                          Column(
                                            children: [
                                              TextBuilder.body('Today'),
                                              ImgGrid(
                                                coreImgs: vm.todayImages ?? [],
                                              ),
                                            ],
                                          ),
                                        if (vm.todayImages?.isNotEmpty ?? false)
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                        if (vm.otherImages?.isNotEmpty ?? false)
                                          Column(
                                            children: [
                                              if (vm.todayImages?.isNotEmpty ??
                                                  false)
                                                TextBuilder.body('Other'),
                                              ImgGrid(
                                                coreImgs: vm.otherImages ?? [],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                      ),
                    ],
                  ),
                ),
                ProgressStatusBuilder(
                  type: ProgressStatusType.upload,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _titleBuilder(final UploadVM vm) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBuilder.heading2('Upload'),
              TextBuilder.heading4(
                'Select image to upload',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Transform.rotate(
            angle: pi / 180 * 30,
            child: RoundIconButton(
              onPressed: vm.getInitialImgFromGallery,
              padding: const EdgeInsets.all(15.0),
              icon: Icon(Icons.keyboard_arrow_up_rounded),
              shadow: BoxShadow(
                color: Colors.deepOrange.withOpacity(0.3),
                blurRadius: 20.0,
                offset: Offset(5.0, 10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
