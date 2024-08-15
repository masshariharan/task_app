import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:task_app/component/app_text.dart';
import 'package:task_app/config/app_color.dart';

import '../network_image.dart';

class ReusableRatingBar extends StatelessWidget {
  const ReusableRatingBar({super.key, required this.rating});

  final double rating;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$rating',
          style: TextStyle(color: AppColor.darkAmberColor),
        ),
        const SizedBox(
          width: 5,
        ),
        RatingBarIndicator(
          rating: rating,
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: AppColor.primaryColor,
          ),
          itemCount: 5,
          itemSize: 25.0,
        ),
      ],
    );
  }
}

class ReusableListTileProduct extends StatelessWidget {
  const ReusableListTileProduct(
      {super.key,
      this.onTap,
      required this.imageUrl,
      required this.title,
      required this.rating,
      required this.price});

  final void Function()? onTap;
  final String imageUrl;
  final String title;
  final double rating;
  final double price;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height / 5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColor.whiteGreyColor)),
        child: Row(
          children: [
            Container(
                color: AppColor.whiteGreyColor,
                height: double.maxFinite,
                width: width / 3,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: NetworkImageWidget(
                  imageUrl: imageUrl,
                )
                ),
            Expanded(
              child: ListTile(
                title: Text(title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableRatingBar(
                      rating: rating,
                    ),
                    PriceText(price: price),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
