import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_man/models/app_user.dart';
import 'package:send_man/models/core_img_model.dart';
import 'package:send_man/services/database/img_upload_provider.dart';
import 'package:send_man/viewmodels/progress_status_vm.dart';

class WrapperBuilder extends StatelessWidget {
  final Function(BuildContext) builder;
  const WrapperBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appUser = Provider.of<AppUser?>(context);

    if (_appUser == null) return builder(context);

    return MultiProvider(
      providers: [
        StreamProvider<List<CoreImage>?>.value(
          value: ImgUploadProvider(
            uid: _appUser.uid,
          ).coreImagesStream,
          initialData: null,
        ),
        ChangeNotifierProvider<ProgressStatusVM>(
          create: (context) => ProgressStatusVM(),
        )
      ],
      child: builder(context),
    );
  }
}
