import 'package:delayed_display/delayed_display.dart';
import 'package:fake_commerce_app/Constants/AppColors.dart';
import 'package:fake_commerce_app/Constants/Dimensions.dart';
import 'package:fake_commerce_app/Controllers/auth_controller.dart';
import 'package:fake_commerce_app/Controllers/product_controller.dart';
import 'package:fake_commerce_app/Models/category_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Routes/app_routes.dart';
import '../../Widgets/network_image.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Duration delayDuration = const Duration(milliseconds: 500);
    return Scaffold(
      
      body: GetBuilder<ProductController>(
        autoRemove: false,
        builder: (controller){
          return RefreshIndicator(
            onRefresh: ()async{
              await controller.getAllProducts();
            },
            child: controller.loading ? const Center(child: CircularProgressIndicator(),) :
            DelayedDisplay(
              delay: delayDuration,
              child: ListView(
                padding: EdgeInsets.all(scaffoldPadding),
                children: [
                  SizedBox(height: 40.h,),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(6.h),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: GetBuilder<AuthController>(
                        autoRemove: false,
                        builder: (auth) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Welcome back!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),),
                              auth.currentUser.name == null ? const SizedBox() :
                              Text("${auth.currentUser.name!.firstName} ${auth.currentUser.name!.lastName}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),)
                            ],
                          );
                        }
                      ),
                    ),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        CategoryProducts category = controller.categoryProducts[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(category.category.toString().toUpperCase(), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
                            SizedBox(height: 3.h,),
                            SizedBox(
                              height: 135.h,
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index){
                                    return SizedBox(
                                      width: 98.h,
                                      child: GestureDetector(
                                        onTap: (){
                                          controller.selectedProduct = category.products![index];
                                          Get.toNamed(Routes.productDetailsView);
                                        },
                                        child: Card(
                                          child: Stack(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  NetworkCacheImage(
                                                    imageUrl: category.products![index].imageUrl.toString(),
                                                    width: 100.h,
                                                    height: 80.h,
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.all(1.h),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(category.products![index].title.toString(), style: TextStyle(fontSize: 12.sp), maxLines: 3, overflow: TextOverflow.ellipsis,)
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Positioned(
                                                  top: 8.h,
                                                  right: 0,
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 5.h),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.primaryColor,
                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8.h), bottomLeft: Radius.circular(8.h), )
                                                    ),
                                                    child: Text("\$ ${category.products![index].price.toString()}", style: const TextStyle(color: Colors.white),),
                                                  )
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) => SizedBox(width: 3.h,),
                                  itemCount: category.products!.length
                              ),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 5.h,),
                      itemCount: controller.categoryProducts.length
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }


}
