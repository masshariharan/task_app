import 'package:get/get.dart';
import 'package:task_app/app_binding/app_binding.dart';
import 'package:task_app/view/cart_view.dart';
import 'package:task_app/view/products_view.dart';
import 'package:task_app/routes/app_route.dart';

import '../view/product_detail_view.dart';

class AppPage {
  static const initial = AppRoute.productView;
  static final pages = [
    GetPage(
      name: AppRoute.productView,
      page: () => const ProductsView(),
      binding: AppBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: AppRoute.productDetailView,
      page: () => const ProductDetailView(),
      binding: AppBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoute.myCartView,
      page: () => const MyCartView(),
      binding: AppBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
