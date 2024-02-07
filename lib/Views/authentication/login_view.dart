import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Constants/AppAssets.dart';
import '../../Constants/Dimensions.dart';
import '../../Controllers/auth_controller.dart';
import '../../Routes/app_routes.dart';
import '../../Widgets/input_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return DelayedDisplay(
            delay: Duration.zero,
            fadeIn: true,
            child: ListView(
              padding: EdgeInsets.all(scaffoldPadding),
              children: [
                SizedBox(height: 50.h,),
                Image.asset(AppAssets.loginIcon),
                SizedBox(height: 10.h,),
                InputField(
                    controller: controller.usernameController,
                    labelText: "Username",
                    hintText: "Enter Username Here",
                    keyboard: TextInputType.text,
                    preIcon: const Icon(Icons.person_2),
                ),
                InputField(
                  controller: controller.passwordController,
                  labelText: "Password",
                  hintText: "Enter Password Here",
                  isPassword: controller.hidePassword,
                  preIcon: const Icon(Icons.lock),
                  trailIcon: Container(
                    height: 30.h,
                    width: 30.h,
                    padding: EdgeInsets.all(5.h),
                    child: IconButton(
                      onPressed: (){
                        controller.hidePassword = !controller.hidePassword;
                      },
                      splashRadius: 20,
                      icon: Icon(controller.hidePassword ? Icons.visibility : Icons.visibility_off, color: Get.theme.primaryColor,),
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),

                controller.loading ? const Center(child: CircularProgressIndicator(),) :
                SizedBox(
                  width: 1.sw,
                  child: ElevatedButton(
                    onPressed: (){
                      controller.login(context);
                    },
                    child: const Text("Login", style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(height: 20.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold,),),
                    // SizedBox(width: 8.h,),
                    TextButton(
                        onPressed: (){
                          Get.toNamed(Routes.signupView, );
                        },
                        child: const Text("Signup")
                    )
                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
