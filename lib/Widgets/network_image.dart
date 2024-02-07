
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Constants/AppAssets.dart';

class NetworkCacheImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final bool bottomRound;
  const NetworkCacheImage({super.key, required this.imageUrl, required this.width, required this.height, this.bottomRound = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(6.h), topRight: Radius.circular(6.h), bottomLeft: bottomRound ? Radius.circular(6.h) : Radius.zero, bottomRight: bottomRound ? Radius.circular(6.h) : Radius.zero, ),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.fill,
              ),
            ),
          ),
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Padding(
                padding:  EdgeInsets.all(20.w),
                child: Center(child: CircularProgressIndicator(value: downloadProgress.progress, strokeWidth: 2,)),
              ),
          // placeholder: (context, url) => Image.asset(AppAssets.profileImage),
          errorWidget: (context, url, error) => Container(
            width: width,
            height: height,
            // padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppAssets.productImage),
                    fit: BoxFit.fill
                )
            ),
          )
      ),
    );
  }
}
