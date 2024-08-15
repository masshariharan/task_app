import 'package:get/get.dart';
import 'package:task_app/controller/cart_controller.dart';
import 'package:task_app/controller/product_controller.dart';
import 'package:task_app/controller/product_detail_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<ProductDetailController>(() => ProductDetailController());
    Get.lazyPut<CartController>(() => CartController());
  }
}
