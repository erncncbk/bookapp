import 'package:bookapp/core/constants/app/app_constants.dart';

class CustomValidator {
  String? passwordValidate(String value) {
    if (value == "" || value.isEmpty) {
      return "Please enter password";
    } else if (value.length < 6) {
      return "Your password must be at least 6 characters.";
    } else {
      return null;
    }
  }

  String? nickNameValidate(String value) {
    if (value == "" || value.isEmpty) {
      return "Please enter your name";
    } else if (value.length < 3) {
      return "Your name must be at least 3 characters.";
    } else {
      return null;
    }
  }

  String? priceValidate(String value) {
    if (value == "" || value.isEmpty) {
      return "Please enter price";
    } else {
      return null;
    }
  }

  String? messageValidate(String value) {
    if (value == "" || value.isEmpty) {
      return "Please enter price";
    } else if (value.length < 5) {
      return "Your message must be at least 5 characters.";
    } else {
      return null;
    }
  }

  String? emailValidate(String value) {
    if (value == "" || value.isEmpty) {
      return "Please enter valid e-mail ";
    } else if (!RegExp(ApplicationConstants.instance!.eMAILREGIEX)
        .hasMatch(value)) {
      return "This email is not valid.";
    }
    {
      return null;
    }
  }

  String? confirmEmailValidate(
    String email,
    String value,
  ) {
    if (value == "" || value.isEmpty) {
      return "Please enter valid e-mail ";
    } else if (!RegExp(ApplicationConstants.instance!.eMAILREGIEX)
        .hasMatch(value)) {
      return "This email is not valid.";
    }
    if (email != value) return "Email do not match.";
    {
      return null;
    }
  }
}
