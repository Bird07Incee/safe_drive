import 'package:marketplace_line_oa/src/model/product_list.dart';

class ProductDataHelper {
  ProductDataHelper._internal();
  static final ProductDataHelper _instance = ProductDataHelper._internal();
  factory ProductDataHelper() => _instance;

  final List<Product> _products = [];

  List<Product> get products => _products;

  void addProduct(List<Product> l) {
    _products.addAll(l);
  }

  void clear() {
    _products.clear();
  }
}
