import 'package:regexed_validator/regexed_validator.dart';

class Validate {
  RegExp nameRegex = RegExp(r'^[a-zA-Z\s]*$');
  String? validateFirstname(String data) {
    data = data.trim();
    if (data.isEmpty) {
      return 'Firstname is required.';
    }
    if (!nameRegex.hasMatch(data)) {
      return 'Invalid firstname.';
    }
    return null;
  }

  String? validateLastname(String data) {
    data = data.trim();
    if (data.isEmpty) {
      return 'Lastname is required.';
    }
    if (!nameRegex.hasMatch(data)) {
      return 'Invalid lastname.';
    }
    return null;
  }

  String? validateEmail(String data) {
    data = data.trim();
    if (data.isEmpty) {
      return 'Email is required.';
    }
    if (!validator.email(data)) {
      return 'Invalid email.';
    }
    return null;
  }

  String? validateUsername(String data) {
    data = data.trim();
    if (data.isEmpty) {
      return 'Username is required.';
    }
    if (data.length < 6) {
      return 'Username have minimum 6 characters.';
    }
    return null;
  }

  String? validatePassword(String data) {
    data = data.trim();
    if (data.isEmpty) {
      return 'Password is required.';
    }
    if (data.length < 7) {
      return 'Password is minimum 7 characters.';
    }
    return null;
  }

  String? validateComfirmPassword(String data, String comfirm) {
    data = data.trim();
    if (data.isEmpty) {
      return 'Comfirm Password is required.';
    }
    if (data != comfirm) {
      return 'Password didn\'t match.';
    }
    return null;
  }
}

Validate validate = Validate();
