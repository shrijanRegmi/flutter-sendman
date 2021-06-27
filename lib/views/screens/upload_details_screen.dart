import 'dart:io';

import 'package:flutter/material.dart';
import 'package:send_man/helpers/date_time_helper.dart';
import 'package:send_man/services/ads/ad_provider.dart';
import 'package:send_man/viewmodels/upload_vm.dart';
import 'package:send_man/viewmodels/vm_provider.dart';
import 'package:send_man/views/widgets/common_widgets/round_icon_button.dart';
import 'package:send_man/views/widgets/common_widgets/text_builder.dart';
import 'package:send_man/views/widgets/upload_widgets/upload_details_images_list.dart';

class UploadDetailScreen extends StatelessWidget {
  final File initialImg;
  final AdProvider adProvider;
  const UploadDetailScreen({
    Key? key,
    required this.initialImg,
    required this.adProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VMProvider<UploadVM>(
      vm: UploadVM(context),
      onInit: (vm) {
        vm.updateImgFiles([initialImg]);
      },
      builder: (context, vm) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBuilder.heading2('Upload Details'),
                    SizedBox(
                      height: 20.0,
                    ),
                    _imagesBuilder(vm),
                    SizedBox(
                      height: 30.0,
                    ),
                    _dateBuilder(vm),
                    SizedBox(
                      height: 30.0,
                    ),
                    _timeBuilder(vm),
                    SizedBox(
                      height: 50.0,
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
                              'Note: If disappearing date or time is not provided then it defaults to 7 days from the date of publication.',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    _buttonBuilder(vm),
                    SizedBox(
                      height: 30.0,
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

  Widget _imagesBuilder(final UploadVM vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextBuilder.heading4('Images'),
            RoundIconButton(
              padding: const EdgeInsets.all(8.0),
              icon: Icon(Icons.add_rounded),
              shadow: BoxShadow(
                color: Colors.deepOrange.withOpacity(0.3),
                blurRadius: 20.0,
                offset: Offset(5.0, 5.0),
              ),
              onPressed: vm.uploadAdditionalImages,
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        UploadDetailsImagesList(
          imgFiles: vm.imgFiles,
          onDelete: (file) => vm.removeFile(file),
        ),
      ],
    );
  }

  Widget _dateBuilder(final UploadVM vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextBuilder.heading4('Disappearing Date'),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundIconButton(
              onPressed: vm.openDatePicker,
              padding: const EdgeInsets.all(10.0),
              icon: Icon(
                Icons.calendar_today_rounded,
                size: 20.0,
              ),
              shadow: BoxShadow(
                color: Colors.deepOrange.withOpacity(0.3),
                blurRadius: 20.0,
                offset: Offset(5.0, 5.0),
              ),
            ),
            if (vm.disDate != null)
              TextBuilder.body(
                DateTimeHelper().getFormattedDate(vm.disDate!),
              ),
          ],
        ),
      ],
    );
  }

  Widget _timeBuilder(final UploadVM vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextBuilder.heading4('Disappearing Time'),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundIconButton(
              padding: const EdgeInsets.all(10.0),
              icon: Icon(
                Icons.access_time_sharp,
                size: 20.0,
              ),
              shadow: BoxShadow(
                color: Colors.deepOrange.withOpacity(0.3),
                blurRadius: 20.0,
                offset: Offset(5.0, 5.0),
              ),
              onPressed: vm.openTimePicker,
            ),
            if (vm.disTime != null)
              TextBuilder.body(
                DateTimeHelper().getFormattedTime(vm.disTime!),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buttonBuilder(final UploadVM vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: MaterialButton(
            onPressed: () => vm.publishImages(adProvider),
            padding: const EdgeInsets.all(20.0),
            color: Colors.orange,
            textColor: Colors.white,
            child: Text(
              'Publish',
            ),
          ),
        ),
      ],
    );
  }
}
