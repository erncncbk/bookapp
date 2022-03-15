import 'dart:io';

import 'package:bookapp/core/constants/enums/alert_type_enum.dart';
import 'package:bookapp/core/constants/enums/page_enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppStateGetterAndSetter with ChangeNotifier {
//* objects
  ///
  ///
  ///
  String? _token;
  AlertType _alertType = AlertType.None;
  String _errorMessage = "success";
  bool _isProgressIndicatorVisible = false; // loading status
  int? _selectedBottomIndex = 0; // selected bottom index
  PageEnums _pageEnums =
      PageEnums.HOME; // sayfa icerisindeki  widget yonlendirilmesi
  File? _imageFromFile;

//* getters
//
//
  int? get getSelectedBottomIndex =>
      _selectedBottomIndex; // get selected bottom index
  PageEnums get getPageEnums => _pageEnums; // get selected main enums type
  AlertType? get alertType => _alertType;
  String? get errorMessage => _errorMessage;
  bool? get isProgressIndicatorVisible => _isProgressIndicatorVisible;
  String? get getToken => _token;
  File? get getImageFromFile => _imageFromFile;

//*setters
//
//

  void setToken(String? message) {
    _token = message;
  }

  void clearToken() {
    _token = null;
  }

  void setIsProgressIndicatorVisible(bool value, {bool isNotifier = true}) {
    _isProgressIndicatorVisible = value;
    debugPrint('Loading durumu : $value');
    if (isNotifier) notifyListeners();
  }

  void setErrorMessage(String message, {bool isNotifier = true}) {
    _errorMessage = message;
    if (isNotifier) notifyListeners();
  }

  void setAlertType(AlertType type) {
    _alertType = type;
  }

  // set selected bottom index
  void setSelectedBottomIndex(int value, {bool isNotifier = true}) {
    _selectedBottomIndex = value;
    if (isNotifier) notifyListeners();
  }

// set  page enums type
  void setPageEnums(PageEnums value, {bool isNotifier = true}) {
    _pageEnums = value;
    if (isNotifier) notifyListeners();
  }

  void setImageFromFile(File? value, {bool isNotifier = true}) {
    _imageFromFile = value;
    if (isNotifier) notifyListeners();
  }
}
