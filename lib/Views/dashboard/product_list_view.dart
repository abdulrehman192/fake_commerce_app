import 'package:delayed_display/delayed_display.dart';
import 'package:fake_commerce_app/Controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Constants/Dimensions.dart';
import '../../Widgets/product_card.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GetBuilder<ProductController>(
        autoRemove: false,
        builder: (controller){
         return controller.loading ? const Center(child: CircularProgressIndicator(),):
             controller.products.isEmpty ? const Center(child: Text("No Products", style: TextStyle(fontWeight: FontWeight.bold),),) :
           DelayedDisplay(
             child: RefreshIndicator(
               onRefresh: ()async{
                 controller.getAllProducts();
               },
               child: ListView.separated(
                 padding: EdgeInsets.all(scaffoldPadding),
                 itemBuilder: (context, index){
                   return ProductCard(product: controller.products[index],);
                 },
                 separatorBuilder: (context, index) => SizedBox(height: 8.h,),
                 itemCount: controller.products.length
                        ),
             ),
           );
        },
      )
    );
  }
}
