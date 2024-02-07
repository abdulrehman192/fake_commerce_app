import 'package:fake_commerce_app/Network/api_endpoints.dart';
import 'package:fake_commerce_app/Network/api_provider.dart';
import 'package:fake_commerce_app/Routes/app_routes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../Constants/pref_data.dart';
import '../Models/user_model.dart';
import '../Utils/CommonFunctions.dart';

class AuthController extends GetxController {
  final ApiProvider _apiProvider = ApiProvider();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final zipCodeController = TextEditingController();

  User _currentUser = User();
  bool _hidePassword = true;
  bool loading = false;

  //getters
  User get currentUser => _currentUser;
  bool get hidePassword => _hidePassword;


  //setters

  set hidePassword(bool val){
    _hidePassword = val;
    update();
  }


  @override
  void onInit() {
    _loadUserData();
    super.onInit();
  }



  _startLoading(){
    loading = true;
    update();
  }

  _stopLoading(){
    loading = false;
    update();
  }


  login(BuildContext context, )async{
    _startLoading();
    if(_loginValidation(context)){
      var body = {
        "username" : usernameController.text.trim(),
        "password" : passwordController.text.trim(),
      };
      await PrefData.setIntroAvailable(false);
      dynamic res = await _apiProvider.post(url: ApiEndpoints.login, body: body, files: {});
      if(res != null){
        if(res.statusCode == 200){
          await PrefData.setUserId("1");
          await _loadUserData();
          Get.offAllNamed(Routes.dashboardView);
        }
        else{
          CommonFunctions.showNotification("Something went wrong", "Something went wrong while creating the profile", MessageType.success, context);
        }
      }
      else{
        CommonFunctions.showNotification("Something went wrong", "Check Internet Connection. Something went wrong while creating the profile", MessageType.success, context);
      }

    }
    _stopLoading();
  }

  signup(BuildContext context,)async{
    _startLoading();
    if(_signupValidation(context)){
      Map<String, PlatformFile> files = {};
      User user = User(
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        password: passwordController.text.trim(),
        username: usernameController.text.trim(),
        name: Name(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
        ),
        address: Address(
          city: cityController.text.trim(),
          street: streetController.text.trim(),
        )
      );
      await PrefData.setIntroAvailable(false);
      // dynamic res = await _apiProvider.post(url: ApiEndpoints.signup, body: user.toJson(), files: files);
      dynamic res = await _apiProvider.post(url: ApiEndpoints.signup, body: user.toJson(), files: files);
      if(res != null){
        if(res.statusCode == 200){
          await PrefData.setUserId("1");
          await _loadUserData();
          CommonFunctions.showNotification("Account Created", "Your Account Successfully Created", MessageType.success, context);
          Get.offAllNamed(Routes.dashboardView);
        }
        else{
          CommonFunctions.showNotification("Something went wrong", "Something went wrong while creating the profile", MessageType.success, context);
        }
      }
      else{
        CommonFunctions.showNotification("Something went wrong", "Check Internet Connection. Something went wrong while creating the profile", MessageType.success, context);
      }

    }
    _stopLoading();
  }

  updateProfile(BuildContext context,)async{
    String userId = await PrefData.getUserId();
    if(userId.isNotEmpty){
      _startLoading();
      if(_profileValidation(context)){
        Map<String, PlatformFile> files = {};
        User user = User(
            email: emailController.text.trim(),
            phone: phoneController.text.trim(),
            username: usernameController.text.trim(),
            name: Name(
              firstName: firstNameController.text.trim(),
              lastName: lastNameController.text.trim(),
            ),
            address: Address(
              city: cityController.text.trim(),
              street: streetController.text.trim(),
            )
        );
        await PrefData.setIntroAvailable(false);
        dynamic res = await _apiProvider.put(url: "${ApiEndpoints.updateProfile}/${_currentUser.id}", body: user.toJson(), files: files);
        if(res != null){
          if(res.statusCode == 200){
            CommonFunctions.showNotification("Profile Updated", "Your Profile Successfully Created", MessageType.success, context);

          }
          else{
            CommonFunctions.showNotification("Something went wrong", "Something went wrong while updating the profile", MessageType.success, context);
          }
        }
        else{
          CommonFunctions.showNotification("Something went wrong", "Check Internet Connection. Something went wrong while updating the profile", MessageType.success, context);
        }

      }
    }
    _stopLoading();
  }

  _loadUserData()async{
    String userId = await PrefData.getUserId();

    if(userId.isNotEmpty){
      dynamic res = await _apiProvider.get(url: "${ApiEndpoints.getUserProfile}/$userId", body: {});
      if(res != null){
        if(res.statusCode == 200){
          _currentUser = User.fromJson(res.data);
          firstNameController.text = _currentUser.name!.firstName ?? "";
          lastNameController.text = _currentUser.name!.lastName ?? "";
          usernameController.text = _currentUser.username?? "";
          emailController.text = _currentUser.email?? "";
          phoneController.text = _currentUser.phone?? "";
          cityController.text = _currentUser.address!.city?? "";
          streetController.text = _currentUser.address!.street?? "";
          zipCodeController.text = _currentUser.address!.zipCode?? "";
          update();
        }
      }
    }
  }

  bool _loginValidation(BuildContext context){
    bool valid = false;
    if(usernameController.text.trim().isEmpty){
      CommonFunctions.showNotification("Username Required", "Please Enter Username First", MessageType.error, context);
    }
    else if(passwordController.text.trim().isEmpty){
      CommonFunctions.showNotification("Password Required", "Please Enter Password First", MessageType.error, context);
    }
    else{
      valid = true;
    }
    return valid;
  }

  bool _signupValidation(BuildContext context){
    bool valid = false;
    if(firstNameController.text.trim().isEmpty){
      CommonFunctions.showNotification("First Name Required", "Please Enter First Name First", MessageType.error, context);
    }
    else if(lastNameController.text.trim().isEmpty){
      CommonFunctions.showNotification("Last Name Required", "Please Enter Last Name First", MessageType.error, context);
    }
    else if(usernameController.text.trim().isEmpty){
      CommonFunctions.showNotification("Username Required", "Please Enter Username First", MessageType.error, context);
    }
    else if(phoneController.text.trim().isEmpty){
      CommonFunctions.showNotification("Phone Required", "Please Enter Phone First", MessageType.error, context);
    }
    else if(emailController.text.trim().isEmpty){
      CommonFunctions.showNotification("Email Required", "Please Enter Email Address First", MessageType.error, context);
    }
    else if(!emailController.text.trim().isEmail){
      CommonFunctions.showNotification("Invalid Email", "Please Enter Valid Email Address First", MessageType.error, context);
    }
    else if(passwordController.text.trim().isEmpty){
      CommonFunctions.showNotification("Password Required", "Please Enter Password First", MessageType.error, context);
    }
    else if(passwordController.text.trim().length < 8){
      CommonFunctions.showNotification("Weak Password", "Password must be at least 8 length", MessageType.error, context);
    }
    else if(confirmPasswordController.text.trim().isEmpty){
      CommonFunctions.showNotification("Confirm Password Required", "Please Enter Confirm Password First", MessageType.error, context);
    }
    else if(confirmPasswordController.text.trim() != passwordController.text.trim()){
      CommonFunctions.showNotification("Password Not Matched", "Both passwords must be matched", MessageType.error, context);
    }

    else{
      valid = true;
    }
    return valid;
  }

  bool _profileValidation(BuildContext context){
    bool valid = false;
    if(firstNameController.text.trim().isEmpty){
      CommonFunctions.showNotification("First Name Required", "Please Enter First Name First", MessageType.error, context);
    }
    else if(lastNameController.text.trim().isEmpty){
      CommonFunctions.showNotification("Last Name Required", "Please Enter Last Name First", MessageType.error, context);
    }
    else if(usernameController.text.trim().isEmpty){
      CommonFunctions.showNotification("Username Required", "Please Enter Username First", MessageType.error, context);
    }
    else if(phoneController.text.trim().isEmpty){
      CommonFunctions.showNotification("Phone Required", "Please Enter Phone First", MessageType.error, context);
    }
    else if(emailController.text.trim().isEmpty){
      CommonFunctions.showNotification("Email Required", "Please Enter Email Address First", MessageType.error, context);
    }
    else if(!emailController.text.trim().isEmail){
      CommonFunctions.showNotification("Invalid Email", "Please Enter Valid Email Address First", MessageType.error, context);
    }

    else if(cityController.text.trim().isEmpty){
      CommonFunctions.showNotification("City Required", "Please Enter City First", MessageType.error, context);
    }
    else if(streetController.text.trim().isEmpty){
      CommonFunctions.showNotification("Street Required", "Please Enter Street First", MessageType.error, context);
    }
    else{
      valid = true;
    }
    return valid;
  }
}