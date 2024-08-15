import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  const PriceText({super.key, required this.price});
  final double price;
  @override
  Widget build(BuildContext context) {
    return Text(
      '₹$price',
      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
    );
  }
}
