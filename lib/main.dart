import 'package:flutter/material.dart';
import 'package:flutter_task/view/drawer_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1125, 2436),
      builder: (_, __) => GetMaterialApp(
        home: DrawerScreen(),
        title: "Flutter",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
      ),
    );
  }
}
