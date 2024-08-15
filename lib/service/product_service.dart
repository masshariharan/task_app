import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:task_app/model/product_model.dart';
import 'package:task_app/utils/constant.dart';

class ProductService {
  static Dio dio = Dio();

  static Future<List<Product>> getProducts() async {
    List<Product> products = [];
    try {
      Response response = await dio.get(Url.getProducts);

      if (response.statusCode == 200) {
        Products productsData = Products.fromJson(response.data);
        products = productsData.product;
      }

    } catch (e) {
      Logger().e(e);
    }
    return products;
  }
}
