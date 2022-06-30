import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetWorkImage extends StatelessWidget {
  final String? imagePath;
  final String? placeHolder;
  final double? width;
  final double? height;

  const NetWorkImage(
      {Key? key, this.imagePath, this.placeHolder, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath ?? "",
      imageBuilder: (context, builder) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 0.5,
              color: Colors.black.withOpacity(0.2),
            ),
          ],
          image: DecorationImage(image: builder, fit: BoxFit.cover),
        ),
      ),
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholder: (context, url) => Image.asset(placeHolder!),
      errorWidget: (context, url, error) => Image.asset(placeHolder!),
    );
  }
}

class CacheImage extends StatelessWidget {
  final String? imagePath;
  final String? placeHolder;
  final double? width;
  final double? height;

  const CacheImage(
      {Key? key, this.imagePath, this.placeHolder, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath!,
      width: width,
      height: height,
      fit: BoxFit.fill,
      placeholder: (context, url) => Image.asset(placeHolder!),
      errorWidget: (context, url, error) => Image.asset(placeHolder!),
    );
  }
}
