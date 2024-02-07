
import 'package:flutter/services.dart';

class EmailInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Implement your email validation logic here
    String newText = newValue.text;

    // Example: Allow only valid email characters
    String filteredText = newText.replaceAll(RegExp(r'[^a-zA-Z0-9@._-]'), '');

    return newValue.copyWith(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}

class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Implement your phone number validation logic here
    String newText = newValue.text;

    // Example: Allow only digits and limit to a specific length
    String filteredText = newText.replaceAll(RegExp(r'[^0-9]'), '');

    // Example: Limit to a specific length (e.g., 10 digits for a US phone number)
    // if (filteredText.length > 10) {
    //   filteredText = filteredText.substring(0, 10);
    // }

    // You can implement more sophisticated validation based on your requirements

    return newValue.copyWith(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}


class NICInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Implement your phone number validation logic here
    String newText = newValue.text;

    // Example: Allow only digits and limit to a specific length
    String filteredText = newText.replaceAll(RegExp(r'[^0-9-]'), '');

    // Example: Limit to a specific length (e.g., 10 digits for a US phone number)
    // if (filteredText.length > 10) {
    //   filteredText = filteredText.substring(0, 10);
    // }

    // You can implement more sophisticated validation based on your requirements

    return newValue.copyWith(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}