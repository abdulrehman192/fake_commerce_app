import 'package:fake_commerce_app/Controllers/product_controller.dart';
import 'package:fake_commerce_app/Models/product.dart';
import 'package:fake_commerce_app/Utils/CommonFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Constants/AppColors.dart';
import '../Routes/app_routes.dart';
import 'network_image.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isCartItem;
  const ProductCard({super.key, required this.product, this.isCartItem = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(!isCartItem){
          ProductController controller = Get.find<ProductController>();
          controller.selectedProduct = product;
          Get.toNamed(Routes.productDetailsView);
        }
      },
      child: SizedBox(
        height: 85.h,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.h)
          ),
          child: Padding(
            padding: EdgeInsets.all(3.h),
            child: Row(
              children: [
                NetworkCacheImage(
                  imageUrl: product.imageUrl.toString(),
                  width: 80.h,
                  height: 80.h,
                  bottomRound: true,
                ),
                SizedBox(width: 5.h,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.title.toString(), style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 3, overflow: TextOverflow.ellipsis,),
                      const Spacer(),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 1.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.h),
                              color: AppColors.primaryColor
                          ),
                          child: Text("\$ ${product.price.toString()}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
                      ),
                    ],
                  ),
                ),
                isCartItem ?
                Row(
                  children: [
                    SizedBox(width: 3.h,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: AppColors.primaryColor.withOpacity(0.3),
                          child: const Text("+"),
                        ),
                        Text(product.quantity.toString(), style: const TextStyle(fontWeight: FontWeight.bold),),
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: AppColors.primaryColor.withOpacity(0.3),
                          child: const Text("-"),
                        ),
                      ],
                    ),
                  ],
                ) : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
