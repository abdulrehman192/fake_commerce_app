import 'package:fake_commerce_app/Constants/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../Constants/AppAssets.dart';
import '../Controllers/cart_controller.dart';

class HomeBottomBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;
  const HomeBottomBar({super.key, required this.selectedIndex, required this.onTap});

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  final List<String> bottomBarList = [
    AppAssets.homeIcon,
    AppAssets.listIcon,
    AppAssets.cartIcon,
    AppAssets.userIcon
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.h,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
            children: List.generate(bottomBarList.length, (index) {
              bool selected = widget.selectedIndex == index;
                return Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      widget.onTap(index);
                    },
                    child: index == 2 ? Stack(
                      alignment: Alignment.topRight,
                      children: [
                        _bottomItem(
                            icon: bottomBarList[index],
                            selected: selected
                        ),
                        Positioned(
                          top: selected ? 3 : 8,
                          right: selected ? 15 : 25,
                          child: GetBuilder<CartController>(
                            builder: (cart) {
                              return cart.cartItems.isEmpty ? const SizedBox():
                                CircleAvatar(
                                radius: 10,
                                backgroundColor: selected ? Colors.blue : AppColors.primaryColor,
                                child: Text(cart.cartProducts.length.toString(), style: TextStyle(fontSize: 9.sp, color: Colors.white ),),
                              );
                            }
                          ),
                        )
                      ],
                    ) :
                    _bottomItem(
                        icon: bottomBarList[index],
                        selected: selected
                    ),
                  ),
                );
            })),
    );
  }

  Widget _bottomItem({required String icon, required bool selected}){
    return Center(
      child: Container(
        width: 40.h,
        height: 40.h,
        decoration: BoxDecoration(
            color: selected
                ? Get.theme.primaryColor
                : Colors.transparent,
            shape: BoxShape.circle),
        child: Center(
          child: SvgPicture.asset(icon, width: 22.h, height: 22.h, color: selected ? Colors.white : Colors.grey,),
        ),
      ),
    );
  }
}
