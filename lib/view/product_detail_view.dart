import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:task_app/component/app_button.dart';
import 'package:task_app/component/app_text.dart';
import 'package:task_app/component/network_image.dart';
import 'package:task_app/component/quantity_button.dart';
import 'package:task_app/config/app_color.dart';
import 'package:task_app/controller/product_detail_controller.dart';
import 'package:task_app/model/product_model.dart';
import 'package:task_app/routes/app_route.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    var productData = Get.arguments as Product;
    controller.checkAddedCart(productData);
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NetworkImageWidget(
                            imageUrl: productData.images.first))),
              ),
              Text(productData.description),
              Row(
                children: [
                  Text(
                    '${productData.rating}',
                    style: TextStyle(color: AppColor.darkAmberColor),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  RatingBarIndicator(
                    rating: productData.rating,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: AppColor.primaryColor,
                    ),
                    itemCount: 5,
                    itemSize: 25.0,
                  ),
                ],
              ),
              Obx(() => PriceText(
                  price: productData.price * controller.quantityCount.value)),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => QuantityButton(
                  quantityCount: controller.quantityCount.value,
                  onTapAdd: () {
                    controller.quantityIncreament();
                  },
                  onTapRemove: () {
                    controller.quantityDecreament();
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Obx(
                () => controller.isAddedCart.value
                    ? AppButton(
                        text: 'Go to cart',
                        color: AppColor.secondaryColor,
                        onPressed: () {
                          Get.toNamed(AppRoute.myCartView);
                        },
                      )
                    : AppButton(
                        text: 'Add to cart',
                        color: AppColor.secondaryColor,
                        onPressed: () {
                          controller.addToCart(productData);
                        },
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppButton(
                text: 'Buy now',
                color: AppColor.primaryColor,
                onPressed: () {
                  controller.buyingForProduct(productData.price);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
