import 'package:flutter/material.dart';
import 'package:flutter_task/view/home_page.dart';
import 'package:flutter_task/view/menu_layout.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({super.key});
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xffD44A61),
            Color(0xffBF4C5F),
            Color(0xffBF4C5F),
            Color(0xffC57380),
            Color(0xffffc3a0),
          ],
        ),
      ),
      child: ZoomDrawer(
        controller: zoomDrawerController,
        menuScreen: MenuView(),
        mainScreen: HomePage(),
        mainScreenTapClose: true,
        showShadow: true,
        style: DrawerStyle.defaultStyle,
        angle: 0.0,
      ),
    );
  }
}
