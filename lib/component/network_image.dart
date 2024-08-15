import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const Center(
          child: SpinKitRipple(
        color: Colors.grey,
      )),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  //   Image.network(
  //     imageUrl,
  //     fit: BoxFit.cover,
  //     // loadingBuilder: (BuildContext context, Widget child,
  //     //     ImageChunkEvent? loadingProgress) {
  //     //   if (loadingProgress == null) return child;
  //     //   return const Center(
  //     //       child: SpinKitRipple(
  //     //     color: Colors.grey,
  //     //   )
  //     //       // CircularProgressIndicator(
  //     //       //   color: Colors.grey,
  //     //       //   value: loadingProgress.expectedTotalBytes != null
  //     //       //       ? loadingProgress.cumulativeBytesLoaded /
  //     //       //           loadingProgress.expectedTotalBytes!
  //     //       //       : null,
  //     //       // ),
  //     //       );
  //     // },
  //   );
  // }
}
