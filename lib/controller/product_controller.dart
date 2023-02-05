import 'package:flutter_task/models/product.dart';
import 'package:flutter_task/models/product_detail.dart';
import 'package:flutter_task/repositories/product_repository.dart';
import 'package:get/get.dart';

class Productontroller extends GetxController {
  final isLoading = false.obs;
  RxString selectedCategoryName = "".obs;
  List<String> categories = [];
  Product? allProductList;
  Rx<Product> categorizedProductList = Product.emptyProduct().obs;
  Rx<ProductDetail> productDetail = ProductDetail.emptyProductDetail().obs;

  ProductRepository repo = ProductRepository();

  void getCategories() async {
    isLoading.value = true;

    categories = await repo.fetchCategories();

    isLoading.value = false;
  }

  void getProducts(String? category) async {
    isLoading.value = true;

    allProductList = await repo.fetchProducts();
    if (category == null) {
      categorizedProductList.value = allProductList!;
    } else {
      categorizedProductList.value.products = allProductList!.products
          .where((element) => element.category == category)
          .toList();
    }

    isLoading.value = false;
  }

  void getProductDetails({required int productId}) async {
    isLoading.value = true;

    productDetail.value = await repo.fetchProductDetail(productID: productId);

    isLoading.value = false;
  }
}
