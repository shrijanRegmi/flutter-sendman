import 'package:flutter/material.dart';
import 'package:send_man/views/widgets/common_widgets/empty_builder.dart';
import 'package:send_man/views/widgets/upload_widgets/image_grid_item.dart';

class ImgGrid extends StatelessWidget {
  final List<String> images;
  const ImgGrid({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return images.isEmpty
        ? EmptyBuilder(
            title: "No uploads yet ?",
            subTitle:
                "Press the button on top right corner\nto upload your first image",
          )
        : GridView.builder(
            itemCount: images.length,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.5,
            ),
            itemBuilder: (context, index) {
              final _imgUrl = images[index];

              return ImgGridItem(
                imgUrl: _imgUrl,
              );
            },
          );
  }
}
