import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/controller/product_controller.dart';
import 'package:flutter_task/models/product.dart';
import 'package:flutter_task/view/product_detail_view.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key}) {
    controller.getProducts(null);
  }
  final controller = Get.find<Productontroller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            if (ZoomDrawer.of(context)!.isOpen()) {
              ZoomDrawer.of(context)!.close();
            } else {
              ZoomDrawer.of(context)!.open();
            }
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        title: Obx(() {
          return Text(
              controller.selectedCategoryName.value == ""
                  ? "Home Page"
                  : controller.selectedCategoryName.value,
              style: TextStyle(
                color: Colors.black,
                fontSize: 62.sp,
                fontWeight: FontWeight.w500,
              ));
        }),
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.categorizedProductList.value.products.isEmpty) {
            return Center(
                child: Text(
                    "There is no product in ${controller.selectedCategoryName.value} category"));
          } else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount:
                    controller.categorizedProductList.value.products.length,
                itemBuilder: (context, index) => buildImageCard(
                    controller.categorizedProductList.value.products[index]),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildImageCard(ProductElement product) => Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: GestureDetector(
          onTap: () {
            controller.getProductDetails(productId: product.id);
            Get.to(() => ProductDetailView());
          },
          child: Container(
            color: const Color.fromARGB(255, 219, 183, 189),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      viewportFraction: 1,
                    ),
                    items: product.images
                        .map(
                          (item) => Image.network(item,
                              fit: BoxFit.fill, width: Get.width),
                        )
                        .toList(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        product.title,
                        style: TextStyle(fontSize: 35.sp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                      Text("${product.price} TL"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
