import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Constants/AppAssets.dart';
import '/Constants/dimensions.dart';
import '/Controllers/auth_controller.dart';
import '/Widgets/input_field.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Signup"),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GetBuilder<AuthController>(
        autoRemove: false,
        builder: (controller){
          return DelayedDisplay(
            delay: Duration.zero,
            fadeIn: true,
            child: ListView(
              padding: EdgeInsets.all(scaffoldPadding),
              children: [
                Image.asset(AppAssets.profileImage, height: 100.h,),
                SizedBox(height: 20.h,),
                InputField(
                    controller: controller.firstNameController,
                    labelText: "First Name",
                    hintText: "Enter Your First Name Here",
                    preIcon: const Icon(Icons.person_2),
                ),
                InputField(
                  controller: controller.lastNameController,
                  labelText: "Last Name",
                  hintText: "Enter Your Last Name Here",
                  preIcon: const Icon(Icons.person_2),
                ),
                InputField(
                  controller: controller.emailController,
                  labelText: "Email",
                  hintText: "Enter Email Address Here",
                  preIcon: const Icon(Icons.email),
                  keyboard: TextInputType.emailAddress,
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
                InputField(
                  controller: controller.confirmPasswordController,
                  labelText: "Confirm Password",
                  hintText: "Enter Confirm Password Here",
                  isPassword: controller.hidePassword,
                  preIcon: const Icon(Icons.lock_clock_rounded),
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
                InputField(
                  controller: controller.usernameController,
                  labelText: "Username",
                  hintText: "Enter Username Here",
                  preIcon: const Icon(Icons.person),
                  keyboard: TextInputType.text,
                ),
                InputField(
                  controller: controller.phoneController,
                  labelText: "Phone",
                  hintText: "Enter Phone Number Here",
                  preIcon: const Icon(Icons.phone),
                  keyboard: TextInputType.phone,
                ),

                SizedBox(height: 10.h,),
                controller.loading ? const Center(child: CircularProgressIndicator(),) :
                SizedBox(
                  width: 1.sw,
                  child: ElevatedButton(
                    onPressed: (){
                      controller.signup(context);
                    },
                    child: const Text("Signup", style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
