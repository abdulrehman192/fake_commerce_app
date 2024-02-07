import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fake_commerce_app/Constants/pref_data.dart';
import 'package:fake_commerce_app/Controllers/auth_controller.dart';
import 'package:fake_commerce_app/Controllers/cart_controller.dart';
import 'package:fake_commerce_app/Controllers/dashboard_controller.dart';
import 'package:fake_commerce_app/Controllers/product_controller.dart';
import 'package:fake_commerce_app/Routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:delayed_display/delayed_display.dart';

import '../../Constants/AppAssets.dart';
import '../../Network/api_provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  _moveNext() async{
    bool connected = await ApiProvider().checkInternetAccess();
    String userId = await PrefData.getUserId();
    bool intro = await PrefData.isIntroAvailable();
    if(connected){
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      Get.put(()=> AuthController(), permanent: true);
      Get.put(()=> DashboardController(), permanent: true);
      Get.put(()=> ProductController(), permanent: true);
      Get.put(()=> CartController(), permanent: true);
      AuthController auth = Get.find<AuthController>();
      auth.onInit();
      if(userId.isNotEmpty){
        Future.delayed(const Duration(seconds: 4), (){
          Get.offNamed(Routes.dashboardView);
        });
      }
      else{
        if(intro == false){
          Future.delayed(const Duration(seconds: 4), (){
            Get.offNamed(Routes.loginView);
          });
        }
        else{
          Future.delayed(const Duration(seconds: 4), (){
            Get.offNamed(Routes.introView);
          });
        }
      }
    }
    else{
      Get.defaultDialog(
        title: "No Internet",
        content: const Text("You are not connected to the internet"),
        actions: [
          ElevatedButton(
              onPressed: (){
                Future.delayed(const Duration(milliseconds: 1000), () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                });
              },
              child: const Text("Close")
          )
        ]
      );
    }

  }
  @override
  void initState() {
    _moveNext();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        width: 1.sw,
        height: 1.sh,
        padding: EdgeInsets.all(8.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DelayedDisplay(
              delay: Duration.zero,
              fadeIn: true,
              child: Image.asset(AppAssets.appLogo, height: 100.h,)
            ),
            SizedBox(height: 10.h),
            AnimatedTextKit(
              isRepeatingAnimation: true,
              repeatForever: false,
              animatedTexts: [
                TyperAnimatedText("Fake Ecommerce",
                    textStyle: TextStyle(color: Theme.of(context).textTheme.titleMedium!.color, fontWeight:FontWeight.w400, fontSize: 30.sp, fontFamily: "Play"),
                    speed: const Duration(milliseconds: 200)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
