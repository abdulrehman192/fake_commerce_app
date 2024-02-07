import 'package:fake_commerce_app/Constants/AppColors.dart';
import 'package:fake_commerce_app/Controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/Controllers/product_controller.dart';
import 'Controllers/auth_controller.dart';
import 'Controllers/dashboard_controller.dart';
import 'Routes/app_pages.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setPrefix("com.example.fake_commerce_app");

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.white
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
      builder: (context, _) {

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,

          title: 'Fake Commerce',
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child!,
            );
          },
          initialBinding: InitialBindings(),
          initialRoute: "/",
          routes: AppPages.routes,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: AppColors.primaryColor,
            scaffoldBackgroundColor: Colors.white,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(AppColors.primaryColor),
                foregroundColor: const MaterialStatePropertyAll(Colors.white),
              )
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(AppColors.primaryColor),
              )
            ),
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(AppColors.primaryColor),
                )
            ),
            appBarTheme: const AppBarTheme(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              elevation: 0
            ),
            cardTheme: CardTheme(
              color: Colors.blue.shade50,
              surfaceTintColor: Colors.blue.shade50,
            ),
            cardColor: Colors.blue.shade50,
          ),

        );
      }
    );
  }
}

class InitialBindings implements Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => ProductController(), fenix: true);
    Get.lazyPut(() => CartController(), fenix: true);
    Get.lazyPut(() => DashboardController(), fenix: true);
  }

}
