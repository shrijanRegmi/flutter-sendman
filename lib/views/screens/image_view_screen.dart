import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:send_man/models/core_img_model.dart';
import 'package:send_man/services/database/img_upload_provider.dart';
import 'package:send_man/services/dialog/diaglog_provider.dart';
import 'package:send_man/views/widgets/common_widgets/round_icon_button.dart';

class ImageViewScreen extends StatefulWidget {
  final CoreImage coreImg;
  const ImageViewScreen({
    Key? key,
    required this.coreImg,
  }) : super(key: key);

  @override
  _ImageViewScreenState createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  bool _isButtonVisible = false;
  int _currentImg = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(milliseconds: 400),
      () {
        setState(() {
          _isButtonVisible = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => setState(() => _isButtonVisible = !_isButtonVisible),
          child: Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
              PhotoViewGallery.builder(
                itemCount: (widget.coreImg.imgUrls ?? []).length,
                scrollPhysics: BouncingScrollPhysics(),
                builder: (context, index) {
                  final _imgUrl = widget.coreImg.imgUrls![index];
                  return PhotoViewGalleryPageOptions(
                    imageProvider: CachedNetworkImageProvider(_imgUrl),
                    initialScale: PhotoViewComputedScale.contained,
                    filterQuality: FilterQuality.high,
                    maxScale: PhotoViewComputedScale.contained * 4,
                    minScale: PhotoViewComputedScale.contained,
                    heroAttributes: PhotoViewHeroAttributes(tag: _imgUrl),
                  );
                },
                onPageChanged: (index) => setState(() => _currentImg = index),
              ),
              if (_isButtonVisible)
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: _iconsContainer(widget.coreImg),
                ),
              if (_isButtonVisible)
                Positioned(
                  right: 20.0,
                  top: 20.0,
                  child: RoundIconButton(
                    padding: const EdgeInsets.all(12.0),
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close_rounded,
                    ),
                    shadow: BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconsContainer(final CoreImage coreImg) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RoundIconButton(
                padding: const EdgeInsets.all(15.0),
                icon: Icon(
                  Icons.delete_outline_rounded,
                ),
                shadow: BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                ),
                onPressed: () {
                  DialogProvider(context).showConfirmationDialog(
                    'Are you sure you want to delete this image ?',
                    'Deletion is permanent and cannot be undone.',
                    onPressedPositive: () {
                      ImgUploadProvider().deleteImg(
                        coreImg,
                        coreImg.imgUrls![_currentImg],
                      );
                      Navigator.pop(context);
                    },
                  );
                },
              ),
              RoundIconButton(
                padding: const EdgeInsets.all(15.0),
                icon: Icon(
                  Icons.arrow_downward_rounded,
                ),
                shadow: BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                ),
                onPressed: () => ImgUploadProvider().downloadImage(
                  coreImg.imgUrls![_currentImg],
                ),
              ),
              RoundIconButton(
                padding: const EdgeInsets.all(15.0),
                icon: Icon(
                  Icons.share,
                ),
                shadow: BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                ),
                onPressed: () =>
                    ImgUploadProvider().shareImage(coreImg.id ?? ''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
