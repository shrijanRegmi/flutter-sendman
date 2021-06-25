import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:send_man/models/core_img_model.dart';
import 'package:send_man/utils/app_colors.dart';
import 'package:send_man/views/screens/image_view_screen.dart';
import 'package:send_man/views/widgets/common_widgets/round_icon_button.dart';

class ImgGridItem extends StatelessWidget {
  final CoreImage coreImg;
  final Function(String)? shareImg;
  const ImgGridItem({
    Key? key,
    required this.coreImg,
    this.shareImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ImageViewScreen(
              coreImg: coreImg,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            color: kcLightOrangeColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Hero(
            tag: coreImg.imgUrls![0],
            child: CachedNetworkImage(
              imageUrl: coreImg.imgUrls![0],
              fit: BoxFit.cover,
              imageBuilder: (context, imgProvider) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: imgProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RoundIconButton(
                            onPressed: () => shareImg!(coreImg.id ?? ''),
                            padding: const EdgeInsets.all(5.0),
                            shadow: BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                            ),
                            icon: Icon(
                              Icons.share,
                              size: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
