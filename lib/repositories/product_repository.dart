import 'dart:convert';

import 'package:flutter_task/models/product.dart';
import 'package:flutter_task/models/product_detail.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart';

class ProductRepository {
  Future<List<String>> fetchCategories() async {
    Uri uri = Uri.parse("https://dummyjson.com/products/categories");
    List<String> categoryList = [];

    var result = await get(uri);

    if (result.statusCode == HttpStatus.ok) {
      var data = jsonDecode(result.body);

      for (var element in data) {
        categoryList.add(element);
      }
    }

    return categoryList;
  }

  Future<Product?> fetchProducts() async {
    Uri uri = Uri.parse("https://dummyjson.com/products");
    Product? productList;

    var result = await get(uri);

    if (result.statusCode == HttpStatus.ok) {
      var data = jsonDecode(result.body);

      productList = Product.fromJson(data);
    }

    return productList;
  }

  Future<ProductDetail> fetchProductDetail({required int productID}) async {
    Uri uri = Uri.parse("https://dummyjson.com/products/$productID");
    ProductDetail productDetail = ProductDetail.emptyProductDetail();

    var result = await get(uri);

    if (result.statusCode == HttpStatus.ok) {
      var data = jsonDecode(result.body);

      productDetail = ProductDetail.fromJson(data);
    }

    return productDetail;
  }
}
