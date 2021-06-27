import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_man/enums/progress_status_type.dart';
import 'package:send_man/viewmodels/progress_status_vm.dart';
import 'package:send_man/views/widgets/common_widgets/progress.dart';
import 'package:send_man/views/widgets/common_widgets/text_builder.dart';

class ProgressStatusBuilder extends StatelessWidget {
  final ProgressStatusType type;
  const ProgressStatusBuilder({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _progressStatusVm = Provider.of<ProgressStatusVM>(context);
    final _status = _progressStatusVm.getStatus(type);

    final _title = _status?.title ?? '';
    final _uploaded = _status?.uploading ?? 0;
    final _total = _status?.total ?? 0;
    final _progress = _status?.progress ?? 0.0;
    final _isDone = _status?.done ?? true;

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
                "$_title",
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
