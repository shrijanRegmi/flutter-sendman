import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:send_man/utils/app_colors.dart';

class ImgGridItem extends StatelessWidget {
  final String imgUrl;
  const ImgGridItem({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: kcLightPurpleColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: CachedNetworkImage(
          imageUrl: imgUrl,
          fit: BoxFit.cover,
          imageBuilder: (context, imgProvider) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: imgProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
