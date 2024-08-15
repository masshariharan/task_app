import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:task_app/model/product_model.dart';
import 'package:task_app/service/product_service.dart';

class ProductController extends GetxController {
  @override
  void onInit() {
    Logger().w('init');
    getProduct();

    super.onInit();
  }

  List<Product> product = [];
  void getProduct() async {
    product = await ProductService.getProducts();
    update();
  }

  Future<List<Product>> fetchPage(int pageIndex, int pageSize) async {
    final startIndex = pageIndex * pageSize;
    final endIndex = startIndex + pageSize;
    await Future.delayed(Duration(seconds: 1));
    return product.sublist(
        startIndex, endIndex > product.length ? product.length : endIndex);
  }
}
