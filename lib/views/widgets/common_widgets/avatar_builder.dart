import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:send_man/utils/app_colors.dart';

class AvatarBuilder extends StatelessWidget {
  final String imgUrl;
  final double? size;
  const AvatarBuilder({
    Key? key,
    required this.imgUrl,
    this.size = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: kcLightGreyColor,
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            imgUrl,
          ),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}
