import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:task_app/controller/payment_controller.dart';
import 'package:task_app/model/product_model.dart';
import 'package:task_app/utils/pref_helper.dart';

class CartController extends GetxController {
  @override
  void onInit() {
    Logger().w('init');
    getCardProduct();
    cartTotalAmountInitial();
    super.onInit();
  }

  final PaymentController paymentController = Get.put(PaymentController());
  var cartItem = <CartItem>[].obs;

  var cartTotalPrice = 0.0.obs;

  void quantityIncreament(int index) {
    cartItem[index].qtyCount++;
    cartItem.refresh();
    Logger().w(cartItem[index].qtyCount);
    cartTotalPrice.value = cartItem.fold<double>(
        0,
        (previousValue, next) =>
            previousValue + (next.product.price * next.qtyCount));
    String totalPrice = cartTotalPrice.value.toStringAsFixed(2);
    cartTotalPrice.value = double.parse(totalPrice);
  }

  void quantityDecreament(int index) {
    if (cartItem[index].qtyCount > 1) {
      cartItem[index].qtyCount--;
      cartTotalPrice.value = cartItem.fold<double>(
          0,
          (previousValue, next) =>
              previousValue + (next.product.price * next.qtyCount));
      String totalPrice = cartTotalPrice.value.toStringAsFixed(2);
      cartTotalPrice.value = double.parse(totalPrice);
      cartItem.refresh();
    }
  }

  void cartTotalAmountInitial() {

    Future.delayed(const Duration(milliseconds: 500), () {
      if (cartItem.isNotEmpty) {
        cartTotalPrice.value =
            cartItem.map((item) => item.product.price).reduce((a, b) => a + b);

        String totalPrice = cartTotalPrice.value.toStringAsFixed(2);
        cartTotalPrice.value = double.parse(totalPrice);
        update();
      }
    });
    Logger().i(cartTotalPrice.value);
  }

  Future<void> getCardProduct() async {
    cartItem.clear();
    List<Product> product = await PreferenceHelper.getCartProducts();

    //cartProduct.value = product;
    for (var data in product) {
      cartItem.add(CartItem(product: data));
    }
  }

  void removeCartItem(product) async {
    await PreferenceHelper.removeProduct(product);
    getCardProduct();
    cartTotalAmountInitial();
    Get.snackbar('Successfully removed', 'Products removed from cart');
  }

  void buyingForCartProduct() {
    paymentController.openCheckout(amount: cartTotalPrice.value);
  }
}

class CartItem {
  Product product;
  int qtyCount;

  CartItem({required this.product, this.qtyCount = 1});
}
