import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({Key? key, required this.context, required this.url})
      : super(key: key);

  final BuildContext context;
  final String url;

  @override
  Widget build(BuildContext context) {
    String imageUrl = url;
    if (imageUrl.isEmpty) {
      imageUrl = "https://via.placeholder.com/150";
    }
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
