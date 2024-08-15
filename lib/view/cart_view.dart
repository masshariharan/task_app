import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/component/app_button.dart';
import 'package:task_app/component/quantity_button.dart';
import 'package:task_app/component/widget/widget.dart';
import 'package:task_app/config/app_color.dart';
import 'package:task_app/controller/cart_controller.dart';
import 'package:task_app/routes/app_route.dart';

class MyCartView extends GetView<CartController> {
  const MyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Cart'),
        ),
        body: Obx(
          () => controller.cartItem.isEmpty
              ? SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Your cart is empty!',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Get.offAllNamed(AppRoute.productView);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.secondaryColor,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                          child: const Text(
                            'Shop now',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: controller.cartItem.length,
                            itemBuilder: (context, index) {
                              var cartProduct = controller.cartItem[index];

                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ReusableListTileProduct(
                                        imageUrl:
                                            cartProduct.product.images.first,
                                        price: cartProduct.product.price *
                                            cartProduct.qtyCount,
                                        title: cartProduct.product.title,
                                        rating: cartProduct.product.rating,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          QuantityButton(
                                            quantityCount: cartProduct.qtyCount,
                                            onTapAdd: () {
                                              controller
                                                  .quantityIncreament(index);
                                            },
                                            onTapRemove: () {
                                              controller
                                                  .quantityDecreament(index);
                                            },
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          OutlinedButton(
                                              onPressed: () {
                                                controller.removeCartItem(
                                                    cartProduct.product);
                                              },
                                              child: const Text('Remove',
                                                  style: TextStyle(
                                                      color: Colors.black))),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      Obx(() => Text(
                          'Total Price ₹${controller.cartTotalPrice.value}')),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: AppButton(
                            text:
                                'Proceed to buy (${controller.cartItem.length} items)',
                            color: AppColor.secondaryColor,
                            onPressed: () {
                              controller.buyingForCartProduct();
                            }),
                      )
                    ],
                  ),
                ),
        ));
  }
}
