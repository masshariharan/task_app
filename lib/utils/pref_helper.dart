import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_app/model/product_model.dart';

class PreferenceHelper {
  static const String cartProducts = 'cartProducts';

  static Future<bool> saveCartProducts(Product addProduct) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var productList = prefs.getStringList(cartProducts);
    productList ??= [];
    productList.add(json.encode(addProduct.toJson()));
    return await prefs.setStringList(cartProducts, productList);
  }

  static Future<List<Product>> getCartProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? productList = prefs.getStringList(cartProducts);
    if (productList != null) {
      Logger().w(productList.first);
      return productList
          .map((item) => Product.fromJson(json.decode(item)))
          .toList();
    }

    return [];
  }

  static Future<void> removeProduct(Product removeProduct) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? productList = prefs.getStringList(cartProducts);

    if (productList != null) {
      List<Product> products = productList
          .map((item) => Product.fromJson(json.decode(item)))
          .toList();
      Logger().w(products);
      products.removeWhere((product) => product.id == removeProduct.id);

      Logger().i(products);
      List<String> updatedProductList =
          products.map((product) => json.encode(product.toJson())).toList();
      await prefs.setStringList(cartProducts, updatedProductList);
    }
  }

  static void clearedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(cartProducts);
    await prefs.clear();
  }
}
