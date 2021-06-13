import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:send_man/models/image_upload_model.dart';
import 'package:send_man/services/database/img_upload_provider.dart';
import 'package:send_man/views/widgets/common_widgets/round_icon_button.dart';

class ImageViewScreen extends StatefulWidget {
  final ImgUpload coreImg;
  const ImageViewScreen({
    Key? key,
    required this.coreImg,
  }) : super(key: key);

  @override
  _ImageViewScreenState createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  bool _isButtonVisible = false;
  // int _currentImg = 0;

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => setState(() => _isButtonVisible = !_isButtonVisible),
          child: Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              PhotoViewGallery.builder(
                itemCount: 1,
                builder: (context, index) {
                  final _imgUrl = widget.coreImg.imgUrl ?? '';

                  return PhotoViewGalleryPageOptions(
                    imageProvider: CachedNetworkImageProvider(_imgUrl),
                    initialScale: PhotoViewComputedScale.covered,
                    filterQuality: FilterQuality.high,
                    maxScale: PhotoViewComputedScale.covered * 2,
                    minScale: PhotoViewComputedScale.contained,
                    heroAttributes: PhotoViewHeroAttributes(tag: _imgUrl),
                  );
                },
                // onPageChanged: (index) => setState(() => _currentImg = index),
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

  Widget _iconsContainer(final ImgUpload coreImg) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundIconButton(
                padding: const EdgeInsets.all(15.0),
                icon: Icon(
                  Icons.arrow_downward_rounded,
                ),
                shadow: BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                ),
                onPressed: () =>
                    ImgUploadProvider().downloadImage(coreImg.imgUrl ?? ''),
              ),
              SizedBox(
                width: 20.0,
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
