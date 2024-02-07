import 'package:delayed_display/delayed_display.dart';
import 'package:fake_commerce_app/Constants/pref_data.dart';
import 'package:fake_commerce_app/Routes/app_routes.dart';
import 'package:fake_commerce_app/Utils/CommonFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/Constants/AppAssets.dart';
class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {

  CarouselSliderController controller = CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        CommonFunctions.closeApp();
        return false;
      },
      child: Scaffold(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        body: DelayedDisplay(
          delay: const Duration(milliseconds: 500),
          child: Column(
            children: [
              SizedBox(height: 100.h,),
              Expanded(
                child: CarouselSlider(
                  controller: controller,
                  unlimitedMode: true,
                  enableAutoSlider: true,
                  initialPage: _currentIndex,
                  slideTransform: const DefaultTransform(),
                  slideIndicator: CircularSlideIndicator(
                      padding: EdgeInsets.only(bottom: 0.h),
                      indicatorBackgroundColor: Colors.grey,
                      currentIndicatorColor: Get.theme.primaryColor,
                      itemSpacing: 15.w,
                      // indicatorRadius: 1.5.h
                  ),
                  onSlideChanged: (i){
                    if(_currentIndex > 0)
                    {
                      _currentIndex --;
                    }
                    else
                    {
                      _currentIndex ++;
                    }
                    setState(() {

                    });
                  },
                  children: [
                    _carouselItem(
                        imageUrl: AppAssets.onboard1,
                        title: 'Select the Product',
                        description: 'Choose from a range of products. Our Products are quality products',
                    ),
                    _carouselItem(
                      imageUrl: AppAssets.onboard2,
                      title: 'Buy with ease',
                      description: 'Select the product that suits you and add to cart',
                    ),
                    _carouselItem(
                      imageUrl: AppAssets.onboard3,
                      title: 'Manage everything on the go',
                      description: 'Manage Your Profile and cart in a very secure environment.',
                    ),

                  ],
                ),
              ),
              SizedBox(height: 20.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: (){
                            PrefData.setIntroAvailable(false);
                            Get.toNamed(Routes.signupView);
                          },
                          child: const Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold),)
                      ),
                    ),
                    SizedBox(width: 20.w,),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: (){
                            PrefData.setIntroAvailable(false);
                            Get.toNamed(Routes.loginView);
                          },
                          child: const Text("Sign In", style: TextStyle(fontWeight: FontWeight.bold),)
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h,),
              TextButton(
                  onPressed: (){
                    PrefData.setIntroAvailable(false);
                    Get.offAllNamed(Routes.dashboardView);
                  },
                  child: const Text("Skip for now", style: TextStyle(fontWeight: FontWeight.bold),)
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _carouselItem({required String imageUrl, required String title, required String description})
  {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.appLogo , height: 40.h,),
              Text(" Fake Ecommerce", style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, ),),
            ],
          ),
          SizedBox(height: 20.h,),
          Image.asset(imageUrl, height: 0.40.sh,),
          SizedBox(height: 8.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),),
                SizedBox(height: 8.h,),
                Text(description, style: TextStyle(fontSize: 15.sp), textAlign: TextAlign.center,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
