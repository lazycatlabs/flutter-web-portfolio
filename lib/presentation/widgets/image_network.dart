import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:lazycatlabs/presentation/presentation.dart';

///*********************************************
///  my-ananda-hospital |
///  image_network.dart
/// --------------------------------------------
/// Created by Mudassir 🧑🏻‍💻 @ >codelogs_
/// on 📅 08/06/21 🕰 10:10 with ❤️
/// email : hey.mudassir@gmail.com
/// github : https://www.github.com/Lzyct
///*********************************************
/// © 2021 | All Right Reserved
class ImageNetwork extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;

  const ImageNetwork({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      width: width,
      height: height,
      fadeInDuration: const Duration(milliseconds: 300),
      imageUrl: imageUrl,
      placeholder: (context, url) => SizedBox(
        width: Dimens.space46,
        height: Dimens.space46,
        child: const CupertinoActivityIndicator(),
      ),
      // errorWidget: (context, url, error) =>
      //     new SvgPicture.asset(Images.icEmpty),
    );
  }
}
