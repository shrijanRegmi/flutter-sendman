import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_man/viewmodels/upload_status_vm.dart';
import 'package:send_man/views/widgets/common_widgets/progress.dart';
import 'package:send_man/views/widgets/common_widgets/text_builder.dart';

class UploadStatusBuilder extends StatelessWidget {
  const UploadStatusBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _uploadStatusVm = Provider.of<UploadStatusVM>(context);

    final _uploaded = _uploadStatusVm.uploadStatus?.uploading ?? 0;
    final _total = _uploadStatusVm.uploadStatus?.total ?? 0;
    final _progress = _uploadStatusVm.uploadStatus?.progress ?? 0.0;
    final _isDone = _uploadStatusVm.uploadStatus?.done ?? true;

    if (_isDone) return Container();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, 0.0),
            blurRadius: 10.0,
            color: Colors.black26,
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBuilder.heading4(
                "Uploading...",
              ),
              TextBuilder.heading5(
                "$_uploaded of $_total",
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Expanded(
                child: Progress(_progress * 100),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
