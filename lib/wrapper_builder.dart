import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_man/models/image_upload_model.dart';
import 'package:send_man/services/database/img_upload_provider.dart';

class WrapperBuilder extends StatelessWidget {
  final Function(BuildContext) builder;
  const WrapperBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<CoreImage>?>.value(
          value: ImgUploadProvider().coreImagesStream,
          initialData: null,
        ),
      ],
      child: builder(context),
    );
  }
}
