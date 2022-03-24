import 'package:flutter/material.dart';

class ApplicationConstants {
  static ApplicationConstants? _instance;
  static ApplicationConstants? get instance {
    _instance ??= ApplicationConstants._init();
    return _instance;
  }

  ApplicationConstants._init();

  static const int RESENDCODETIME = 120;

  String get eMAILREGIEX =>
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
}

class Constant {
  static const String userToken = "UserToken";
  static const String firstOpen = "FirstOpen";
  static const String theme = "Theme";

  static const int TIMEOUTPERIOD = 30;
  static const int PICTURETIMEOUT = 150;

  static const images = [
    "assets/images/bg_1.png",
    "assets/images/bg_2.png",
    "assets/images/bg_3.png",
    "assets/images/bg_4.png",
    "assets/images/bg_5.png",
    "assets/images/bg_6.png",
  ];
  static const book_images = [
    "assets/images/1.png",
    "assets/images/2.png",
    "assets/images/3.png",
    "assets/images/4.png",
    "assets/images/5.png",
    "assets/images/6.png",
  ];
  static const discoverImages = [
    "assets/images/d1.png",
    "assets/images/d2.png",
    "assets/images/d3.png",
    "assets/images/d4.png",
    "assets/images/d5.png",
    "assets/images/d6.png",
    "assets/images/d7.png",
    "assets/images/d8.png",
  ];
  static const campaignsImages = [
    "assets/images/c1.png",
    "assets/images/c2.png",
    "assets/images/c3.png",
    "assets/images/c4.png",
    "assets/images/c5.png",
  ];
  static const giftCard = [
    "assets/images/g1.png",
  ];

  static const List<String> titleList = [
    "Account",
    "Orders",
    "What Should I Read",
    "Bookmarks",
    // "Authors",
    "Campaigns",
    "Gift Cart",
    "Settings",
  ];
  static const List<String> shopSectionList = [
    "Add the product you are viewing to your cart.",
    "Check your product information on the 'My Cart' page. Please update any fields you want to change.",
    "Click the 'continue' button to make the payment.",
    "Select your delivery and billing address. You can enter a different delivery address with the 'add new address' option.",
    "When you click on the “Invoice comes with the product“ option, an invoice will be issued to your delivery address.",
    "If an invoice will be issued to a different address and person/institution; You need to remove the tick. In this case, you can add new address information.",
    "Click the Continue button and go to the “Payment” page and select the payment type.",
    "After confirming the 'Distance Sales' and 'Pre-Information' acceptance agreements, complete your order with the 'buy' option.",
  ];

  static const List<IconData> iconList = [
    Icons.account_circle_outlined,
    Icons.shopping_basket_outlined,
    Icons.menu_book_rounded,
    Icons.bookmarks,
    // Icons.mode_edit_outlined,
    Icons.campaign_outlined,
    Icons.card_giftcard_outlined,
    Icons.settings,
  ];
}
