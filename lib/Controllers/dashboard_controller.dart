import 'package:fake_commerce_app/Views/dashboard/home_view.dart';
import 'package:fake_commerce_app/Views/dashboard/product_list_view.dart';
import 'package:get/get.dart';
import '../Views/dashboard/cart_view.dart';
import '../Views/dashboard/profile_view.dart';
import 'cart_controller.dart';

class DashboardController extends GetxController
{

  int _selectedIndex = 0;
  final pages = const [
    HomeView(),
    ProductsView(),
    CartView(),
    ProfileView()
  ];

  int get selectedIndex => _selectedIndex;


  set selectedIndex(int val){
    _selectedIndex = val;
    update();
  }
  @override
  void onInit() {
    CartController c = Get.find<CartController>();
    super.onInit();
  }
}