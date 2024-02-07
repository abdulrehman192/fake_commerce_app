import 'package:fake_commerce_app/Views/product_details_view.dart';
import 'package:flutter/material.dart';
import '../Views/authentication/login_view.dart';
import '../Views/authentication/signup_view.dart';
import '../Views/dashboard/cart_view.dart';
import '../Views/dashboard/dashboard_view.dart';
import '../Views/dashboard/home_view.dart';
import '../Views/dashboard/product_list_view.dart';
import '../Views/dashboard/profile_view.dart';
import '../Views/intro/intro_view.dart';
import '../Views/intro/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  static const initialRoute = Routes.splashView;
  static Map<String, WidgetBuilder> routes = {
    Routes.splashView: (context) => const SplashView(),
    Routes.introView: (context) => const IntroView(),
    Routes.dashboardView: (context) => const DashboardView(),
    Routes.loginView: (context) => const LoginView(),
    Routes.signupView: (context) => const SignupView(),
    Routes.homeView: (context) => const HomeView(),
    Routes.productListView: (context) => const ProductsView(),
    Routes.cartView: (context) => const CartView(),
    Routes.profileView: (context) => const ProfileView(),
    Routes.productDetailsView: (context) => const ProductDetailsView(),

  };
}
