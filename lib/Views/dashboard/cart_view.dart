import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Constants/AppAssets.dart';
import '../../Constants/AppColors.dart';
import '../../Constants/Dimensions.dart';
import '../../Controllers/cart_controller.dart';
import '../../Controllers/dashboard_controller.dart';
import '../../Widgets/input_field.dart';
import '../../Widgets/product_card.dart';


class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        actions: [
          GetBuilder<CartController>(
            autoRemove: false,
            builder: (controller) {
              return TextButton(
                  onPressed: (){
                    _showPaymentSummarySheet(context,);
                  },
                  child: Row(
                    children: [
                      Text("Checkout", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
                      SizedBox(width: 5.h,),
                      const Icon(Icons.keyboard_arrow_down, size: 28,)
                    ],
                  )
              );
            }
          ),
          SizedBox(width: 5.h,),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: DelayedDisplay(
        child: GetBuilder<CartController>(
          autoRemove: false,
          builder: (controller) {
            return controller.cartItems.isEmpty ? Center(
              child: RefreshIndicator(
                onRefresh: ()async{
                  await controller.getAllCartItems();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.emptyCartImage, height: 160.h,),
                    SizedBox(height: 10.h,),
                    Text("No Item in Cart", style: TextStyle(color: Get.theme.primaryColor, fontWeight: FontWeight.bold, fontSize: 16.sp),),
                    SizedBox(height: 10.h,),
                    ElevatedButton.icon(
                        onPressed: (){
                          DashboardController dash = Get.find<DashboardController>();
                          dash.selectedIndex = 0;
                        },
                        icon: const Icon(Icons.home),
                        label: const Text("Go to Home")
                    )
                  ],
                ),
              ),
            ) :
            RefreshIndicator(
              onRefresh: ()async{
                await controller.getAllCartItems();
              },
              child: ListView.separated(

                  padding: EdgeInsets.all(scaffoldPadding),
                  itemBuilder: (context, index){
                    return ProductCard(product: controller.cartProducts[index], isCartItem: true,);
                  },
                  separatorBuilder: (context, index) => SizedBox(height : 3.h),
                  itemCount: controller.cartProducts.length
              ),
            );
          }
        ),
      )
    );
  }

  _showPaymentSummarySheet(BuildContext context , ){
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(12.h), topRight: Radius.circular(12.h)),
        ),
        backgroundColor: Colors.grey.shade200,
        isScrollControlled: true,
        builder: (context){
          return GetBuilder<CartController>(
            builder: (controller) {
              return Container(
                width: 1.sw,
                // alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12.h), topRight: Radius.circular(12.h)),
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.h,),
                        Center(
                          child: Container(
                            width: 50.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.w),
                                color: Colors.grey
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 20.h),
                          child: _paymentSummary(controller),
                        ),
                        SizedBox(height: 2.h,),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.h),
                          child: controller.loading ? Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),) :
                          SizedBox(
                            width: 1.sw,
                            child: ElevatedButton(
                                onPressed: (){
                                },
                                child: const Text("Checkout", style: TextStyle(fontWeight: FontWeight.bold),)
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h,),
                      ],
                    ),
                    Positioned(
                        top: 5.h,
                        right: 8.h,
                        child: GestureDetector(
                            onTap: (){
                              Get.back();
                            },
                            child: Icon(Icons.cancel, color: Colors.grey.shade600,)
                        )
                    )
                  ],
                ),
              );
            }
          );
        }
    );
  }

  Widget _paymentSummary(CartController controller){
    return Container(
      margin: EdgeInsets.symmetric(vertical :10.h,),
      padding: EdgeInsets.all(10.h),
      width: 1.sw,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.h),
          color: Colors.blue.shade50
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Payment Summary", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor),),
          SizedBox(height: 12.h,),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Subtotal" , style: TextStyle(color: Colors.grey.shade600),),
                  Text("৳ ${controller.total}", style: TextStyle(color: Colors.grey.shade600),)
                ],
              ),
              SizedBox(height: 3.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Discount" , style: TextStyle(color: Colors.grey.shade600),),
                  Text("৳ ${controller.discount}", style: TextStyle(color: Colors.grey.shade600),)
                ],
              ),
              SizedBox(height: 3.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Coupon" , style: TextStyle(color: Colors.grey.shade600),),
                  Text("৳ ${controller.coupon}", style: TextStyle(color: Colors.grey.shade600),)
                ],
              ),
              const Divider(),
              SizedBox(height: 3.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total" , style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold),),
                  Text("৳ ${controller.payable}", style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold),)
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
