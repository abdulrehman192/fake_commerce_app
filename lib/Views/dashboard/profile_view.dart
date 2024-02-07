import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Constants/AppAssets.dart';
import '../../Constants/Dimensions.dart';
import '../../Constants/pref_data.dart';
import '../../Routes/app_routes.dart';
import '../../Widgets/input_field.dart';
import '/Controllers/auth_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      autoRemove: false,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Edit Profile"),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: GetBuilder<AuthController>(
            autoRemove: false,
            builder: (controller){
              return DelayedDisplay(
                delay: Duration.zero,
                fadeIn: true,
                child: controller.currentUser.id == null ? Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.loginIcon),
                    const Text("You are not login", style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),):
                ListView(
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
                    InputField(
                      controller: controller.cityController,
                      labelText: "City",
                      hintText: "Enter City Here",
                      preIcon: const Icon(Icons.location_city),
                      keyboard: TextInputType.text,
                    ),
                    InputField(
                      controller: controller.streetController,
                      labelText: "Street",
                      hintText: "Enter Street Here",
                      preIcon: const Icon(Icons.location_city),
                      keyboard: TextInputType.text,
                    ),
                    InputField(
                      controller: controller.zipCodeController,
                      labelText: "Zip Code",
                      hintText: "Enter Zip Code Here",
                      preIcon: const Icon(Icons.qr_code),
                      keyboard: TextInputType.text,
                    ),
                    SizedBox(height: 10.h,),
                    controller.loading ? const Center(child: CircularProgressIndicator(),) :
                    SizedBox(
                      width: 1.sw,
                      child: ElevatedButton(
                        onPressed: (){
                          controller.updateProfile(context);
                        },
                        child: const Text("Update Profile", style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        );
      }
    );
  }
}
