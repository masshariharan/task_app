import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:task_app/controller/payment_controller.dart';
import 'package:task_app/model/product_model.dart';
import 'package:task_app/utils/pref_helper.dart';

class ProductDetailController extends GetxController {
  final PaymentController paymentController = Get.put(PaymentController());

  @override
  void onInit() {
    Logger().w('init');

    super.onInit();
  }

  @override
  void onClose() {
    isAddedCart = false.obs;
    Logger().w('dispose');
    super.onClose();
  }

  var quantityCount = 1.obs;
  var isAddedCart = false.obs;

  void quantityIncreament() {
    quantityCount++;
  }

  void quantityDecreament() {
    if (quantityCount > 1) {
      quantityCount--;
    }
  }

  void buyingForProduct(price) {
    paymentController.openCheckout(amount: price * quantityCount.value);
  }

  void addToCart(Product product) async {
    await PreferenceHelper.saveCartProducts(product);
    checkAddedCart(product);
    Get.snackbar('Successfully added', 'Products added to cart');
  }

  Future<void> checkAddedCart(Product productData) async {
    Logger().i("data.id");
    List<Product> product = await PreferenceHelper.getCartProducts();
    Logger().i("data.id");
    for (var data in product) {
      Logger().w(data.id);
      if (data.id == productData.id) {
        Logger().i(data.id);
        isAddedCart.value = true;
      }
    }
  }
}
