
import 'dart:math';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Constants/Dimensions.dart';

class CommonFunctions
{

  static showNotification( String title ,String message, MessageType type, BuildContext context, [Color? color,] ) {
    NotificationPosition notificationPosition = NotificationPosition.topRight;
    double width = Get.width <= mobileWidth ? 0.95.sw : mobileWidth + 50;
    if(type == MessageType.success)
    {
      ElegantNotification.success(
        notificationPosition: notificationPosition,
        title: Text(title, style: TextStyle(color: Colors.black),),
        description:  Text(message, style: TextStyle(fontSize: 12.sp, color: Colors.black),),
        width: width ,
      ).show(context);
    }
    else if(type == MessageType.error)
    {
      ElegantNotification.error(
        notificationPosition: notificationPosition,
        title: Text(title, style: TextStyle(color: Colors.black),),
        description:  Text(message, style: TextStyle(fontSize: 12.sp, color: Colors.black),),
        width: width ,
      ).show(context);
    }
    else if(type == MessageType.info)
    {
      ElegantNotification.info(
        notificationPosition: notificationPosition,
        title: Text(title, style: TextStyle(color: Colors.black),),
        description:  Text(message, style: TextStyle(fontSize: 12.sp, color: Colors.black),),
        width: width ,
      ).show(context);
    }
  }

  static showSnackBar(String title, String message){
    GetSnackBar snackBar = GetSnackBar(title: title, message: message, duration: const Duration(seconds: 2),);
    Get.showSnackbar(snackBar);
  }

  static showConfirmAlert({required String title, required String content, required Function() onYes}) async
  {

    Get.defaultDialog(
      title: title,
      backgroundColor: Get.theme.dialogBackgroundColor,
      content: Text(content),
      actions: [
        ElevatedButton(
            onPressed: (){
              onYes();
              Get.back();
            },
            child: const Text("Yes")
        ),
        ElevatedButton(
            onPressed: (){
              Get.back();
            },
            child: const Text("No")
        )
      ]
    );
  }

  static String formatDate(DateTime dateTime)
  {
    return DateFormat("EEE, MMM dd, yyyy").format(dateTime);
  }

  static String formatTime(TimeOfDay timeOfDay)
  {
    var date = DateTime.now();
    DateTime dateTime = DateTime(
      date.year, // Use the year from the current date
      date.month, // Use the month from the current date
      date.day, // Use the day from the current date
      timeOfDay.hour, // Set the hours from TimeOfDay
      timeOfDay.minute, // Set the minutes from TimeOfDay
    );
    return DateFormat("hh:mm aa").format(dateTime);
  }

  static bool isCreditCardValid(String cardNumber) {
    // Remove non-digit characters from the input
    cardNumber = cardNumber.replaceAll(RegExp(r'\D'), '');

    if (cardNumber.length < 13 || cardNumber.length > 19) {
      // Check if the card number has a valid length
      return false;
    }

    int sum = 0;
    bool alternate = false;

    // Iterate through the card number digits from right to left
    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);

      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }

      sum += digit;
      alternate = !alternate;
    }

    // The card number is valid if the sum is divisible by 10
    return sum % 10 == 0;
  }

  static openDatePicker({required BuildContext context, required DateTime initialDate, required Function(DateTime) onSelected }) async
  {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1970),
        lastDate: DateTime.now()
    );

    if(date != null)
    {
      onSelected(date);
    }
  }

  static openTimePicker({required BuildContext context, required TimeOfDay initialTime, required Function(TimeOfDay) onSelect }) async
  {
    TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: initialTime,
    );

    if(time != null)
    {
      onSelect(time);
    }
  }

  static String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }


  static showPopupMenu(BuildContext context,
      {required List<String> items, required Function(String) onSelect, required Offset position}) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx,
        position.dy,
        MediaQuery.of(context).size.width - position.dx,
        MediaQuery.of(context).size.height - position.dy,),
      items: items.map((e) {
        return PopupMenuItem<String>(
          value: e,
          onTap: (){
            onSelect(e);
          },
          child: Text(e),

        );
      }
      ).toList(),
      elevation: 8.0,
    );
  }


  static bool validateEmail(String email)
  {
    final bool emailValid =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }



  //get file name from firebase storage link
  static String getFileName(String url) {
    RegExp regExp =  RegExp(r'.+(\/|%2F)(.+)\?.+');
    //This Regex won't work if you remove ?alt...token
    Iterable<RegExpMatch> matches = regExp.allMatches(url);

    RegExpMatch match = matches.elementAt(0);
    return Uri.decodeFull(match.group(2)!);
  }

  static showErrorMessage(String errorLocation ,String errorMessage,  [Color? color]) {
   final snackBar = GetSnackBar(
      title: errorLocation,
      message: errorMessage,
      backgroundColor: color?? Colors.black,
      duration: const Duration(seconds: 3),
    );
    Get.showSnackbar(snackBar);
  }


  static bool validatePassword(String value) {
    bool check = true;
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

      if (!regex.hasMatch(value)) {
        check = false;
      }

      return check;
  }


  static String generateUniqueCode() {
    const length = 8;
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'; // You can customize this to include other characters if needed
    Random random = Random();
    String code = '';

    for (int i = 0; i < length; i++) {
      int index = random.nextInt(characters.length);
      code += characters[index];
    }

    return code;
  }

  static closeApp() {
    showConfirmAlert(
        title: "Exit App",
        content: "Do you want to exit the app?",
        onYes: (){
          Future.delayed(const Duration(milliseconds: 1000), () {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          });
        }
    );
  }


}
enum MessageType { success, error, info }