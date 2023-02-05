import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/controller/product_controller.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class MenuView extends StatelessWidget {
  MenuView({super.key}) {
    controller.getCategories();
  }
  final controller = Get.put<Productontroller>(Productontroller());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 250.h, bottom: 150.h),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              controller.selectedCategoryName.value = "";
              controller.getProducts(null);
              ZoomDrawer.of(context)!.close();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.transparent,
              child: Text(
                "CATEGORIES",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.sp),
              ),
            ),
          ),
          Obx(
            () {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.categories.isEmpty) {
                return const Center(child: Text("There is no category"));
              } else {
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.categories.length,
                    itemBuilder: (_, index) {
                      return menuTile(
                          title: controller.categories[index],
                          onTap: () {
                            controller.selectedCategoryName.value =
                                controller.categories[index];
                            controller
                                .getProducts(controller.categories[index]);
                            ZoomDrawer.of(context)!.close();
                          });
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  GestureDetector menuTile(
      {required String title, required Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Icon(
              Icons.circle,
              color: Colors.white,
              size: 25.w,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
