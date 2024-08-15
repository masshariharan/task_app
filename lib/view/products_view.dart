import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:task_app/config/app_color.dart';
import 'package:task_app/model/product_model.dart';
import 'package:task_app/routes/app_route.dart';
import '../component/widget/widget.dart';
import '../controller/product_controller.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          title: const Text('Products'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(AppRoute.myCartView);
                },
                icon: const Icon(Icons.shopping_cart))
          ],
        ),
        body: GetBuilder<ProductController>(
            init: ProductController(),
            builder: (controller) {
              return controller.product.isEmpty
                  ? const Center(
                      child: SpinKitFadingCircle(
                      color: AppColor.primaryColor,
                    ))
                  : PagewiseListView<Product>(
                      pageSize: 10,
                      pageFuture: (pageIndex) =>
                          controller.fetchPage(pageIndex!, 10),
                      noItemsFoundBuilder: (a) =>
                          const Center(child: Text('No items found')),
                      loadingBuilder: (context) => const Center(
                          child: SpinKitFadingCircle(
                        color: AppColor.primaryColor,
                      )),
                      itemBuilder: (context, items, index) {
                        var products = controller.product[index];

                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ReusableListTileProduct(
                              onTap: () {
                                Get.toNamed(AppRoute.productDetailView,
                                    arguments: products);
                              },
                              imageUrl: products.images.first,
                              title: products.title,
                              rating: products.rating,
                              price: products.price),
                        );
                      },
                    );
            }));
  }
}
