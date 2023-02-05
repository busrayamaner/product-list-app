import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/controller/product_controller.dart';
import 'package:get/get.dart';

class ProductDetailView extends StatelessWidget {
  ProductDetailView({super.key});
  final controller = Get.find<Productontroller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
        centerTitle: true,
        title: Text("Product Detail",
            style: TextStyle(
              color: Colors.black,
              fontSize: 62.sp,
              fontWeight: FontWeight.w500,
            )),
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.productDetail.value.id == 0) {
            return const Center(
                child: Text("Could not access product detail."));
          } else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                    items: controller.productDetail.value.images
                        .map(
                          (item) => ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(item,
                                  fit: BoxFit.fill, width: Get.width)),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 50.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.productDetail.value.title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "${controller.productDetail.value.price} TL",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 50.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: controller.productDetail.value.rating,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 80.w,
                        direction: Axis.horizontal,
                      ),
                      SizedBox(width: 50.w),
                      Text(
                        "(${controller.productDetail.value.rating})",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Divider(),
                  infoRow(
                      title: controller.productDetail.value.brand,
                      icon: Icons.store),
                  infoRow(
                      title: controller.productDetail.value.description,
                      icon: Icons.description),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget infoRow({required String title, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(
            icon,
            size: 40.sp,
            color: const Color(0xffBF4C5F),
          ),
          SizedBox(width: 50.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 45.sp,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
