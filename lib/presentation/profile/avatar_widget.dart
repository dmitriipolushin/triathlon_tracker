import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RectangularAvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  const RectangularAvatarWidget({
    Key? key,
    this.imageUrl,
    this.width = 224,
    this.height = 131,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        imageBuilder: (context, image) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(image: image, fit: BoxFit.cover)),
          );
        },
        placeholder: (context, _) {
          return RectanglePlaceholder(width: width, height: height);
        },
        errorWidget: (context, _, val) {
          return RectanglePlaceholder(width: width, height: height);
        },
      );
    } else {
      return RectanglePlaceholder(width: width, height: height);
    }
  }
}

class RectanglePlaceholder extends StatelessWidget {
  final double width;
  final double height;
  const RectanglePlaceholder({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.grey[300],
      ),
    );
  }
}
