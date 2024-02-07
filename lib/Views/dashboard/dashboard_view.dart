import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utils/CommonFunctions.dart';
import '/Controllers/dashboard_controller.dart';
import '../../Widgets/home_bottom_bar.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      autoRemove: false,
      builder: (controller) {
        return WillPopScope(
          onWillPop: ()async{
            CommonFunctions.closeApp();
            return false;
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: controller.pages[controller.selectedIndex],

            bottomNavigationBar: HomeBottomBar(
              selectedIndex: controller.selectedIndex,
              onTap: (val){
                controller.selectedIndex = val;
              },
            ),
          ),
        );
      }
    );
  }
}
