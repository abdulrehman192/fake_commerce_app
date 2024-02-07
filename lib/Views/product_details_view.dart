import 'package:fake_commerce_app/Constants/AppColors.dart';
import 'package:fake_commerce_app/Controllers/product_controller.dart';
import 'package:fake_commerce_app/Widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: GetBuilder<ProductController>(
        autoRemove: false,
        builder: (controller){
          return ListView(
            children: [
              NetworkCacheImage(
                  imageUrl: controller.selectedProduct.imageUrl.toString(),
                  width: 1.sw,
                  height: 230.h
              ),
              Padding(
                padding: EdgeInsets.all(8.h),
                child: Column(
                  children: [
                    Text(controller.selectedProduct.title.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                    controller.selectedProduct.rating == null ? const SizedBox() :
                    SizedBox(height: 10.h,),
                    controller.selectedProduct.rating == null ? const SizedBox() :
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            RatingBar.builder(
                              initialRating: controller.selectedProduct.rating!.rating ?? 4,
                              minRating: 1,
                              maxRating: 5,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 18,
                              itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                              },
                              ignoreGestures: true,
                            ),
                            Text(" ${controller.selectedProduct.rating!.rating ?? 4}(${controller.selectedProduct.rating!.count ?? 5})")
                          ],
                        ),
                        ElevatedButton.icon(
                            onPressed: (){

                            },
                            icon: const Icon(Icons.shopping_cart),
                            label: const Text("Add To Cart")
                        )
                      ],
                    ),
                    SizedBox(height: 5.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controller.selectedProduct.category.toString().toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: AppColors.primaryColor),),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 1.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.h),
                                color: AppColors.primaryColor
                            ),
                            child: Text("\$ ${controller.selectedProduct.price.toString()}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Text(controller.selectedProduct.description.toString(), textAlign: TextAlign.justify,),
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
