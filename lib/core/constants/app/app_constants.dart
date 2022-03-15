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

  static const int TIMEOUTPERIOD = 20;
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
    "Authors",
    "Campaigns",
    "Gift Cart",
    "Settings",
  ];
  static const List<IconData> iconList = [
    Icons.account_circle_outlined,
    Icons.shopping_basket_outlined,
    Icons.menu_book_rounded,
    Icons.bookmarks,
    Icons.mode_edit_outlined,
    Icons.campaign_outlined,
    Icons.card_giftcard_outlined,
    Icons.settings,
  ];

  static const book_list = [
    {
      "id": 100,
      "title": "Code Complete: A Practical Handbook of Software Construction",
      "isbn": "978-0735619678",
      "price": 2954,
      "currencyCode": "EUR",
      "author": "Mike Riley"
    },
    {
      "id": 200,
      "title": "The Pragmatic Programmer",
      "isbn": "978-0201616224",
      "price": 3488,
      "currencyCode": "EUR",
      "author": "Andrew Hunt and Dave Thomas"
    },
    {
      "id": 300,
      "title": "iOS Forensic Analysis",
      "isbn": "978-1430233428",
      "price": 4604,
      "currencyCode": "EUR",
      "author": "Sean Morrisey"
    },
    {
      "id": 400,
      "title":
          "Ghost in the Wires: My Adventures as the World's Most Wanted Hacker",
      "isbn": "978-0316037709",
      "price": 1493,
      "currencyCode": "EUR",
      "author": "Kevin Mitnick"
    },
    {
      "id": 500,
      "title": "Handling Unexpected Errors",
      "isbn": "978-0590353403",
      "price": 1399,
      "currencyCode": "GBP",
      "author": "Charles R. Ash"
    },
    {
      "id": 600,
      "title": "Android Application Development For Dummies",
      "isbn": "978-0470770184",
      "price": 1979,
      "currencyCode": "USD",
      "author": "Donn Felker"
    }
  ];
  static const book = [
    {
      "id": 100,
      "title": "Code Complete: A Practical Handbook of Software Construction",
      "isbn": "978-0735619678",
      "description":
          "Widely considered one of the best practical guides to programming, Steve McConnell’s original CODE COMPLETE has been helping developers write better software for more than a decade. Now this classic book has been fully updated and revised with leading-edge practices—and hundreds of new code samples—illustrating the art and science of software construction. Capturing the body of knowledge available from research, academia, and everyday commercial practice, McConnell synthesizes the most effective techniques and must-know principles into clear, pragmatic guidance. No matter what your experience level, development environment, or project size, this book will inform and stimulate your thinking—and help you build the highest quality code.",
      "price": 2954,
      "currencyCode": "EUR",
      "author": "Mike Riley"
    },
    {
      "id": 100,
      "title": "Code Complete: A Practical Handbook of Software Construction",
      "isbn": "978-0735619678",
      "description":
          "Widely considered one of the best practical guides to programming, Steve McConnell’s original CODE COMPLETE has been helping developers write better software for more than a decade. Now this classic book has been fully updated and revised with leading-edge practices—and hundreds of new code samples—illustrating the art and science of software construction. Capturing the body of knowledge available from research, academia, and everyday commercial practice, McConnell synthesizes the most effective techniques and must-know principles into clear, pragmatic guidance. No matter what your experience level, development environment, or project size, this book will inform and stimulate your thinking—and help you build the highest quality code.",
      "price": 2954,
      "currencyCode": "EUR",
      "author": "Mike Riley"
    },
    {
      "id": 100,
      "title": "Code Complete: A Practical Handbook of Software Construction",
      "isbn": "978-0735619678",
      "description":
          "Widely considered one of the best practical guides to programming, Steve McConnell’s original CODE COMPLETE has been helping developers write better software for more than a decade. Now this classic book has been fully updated and revised with leading-edge practices—and hundreds of new code samples—illustrating the art and science of software construction. Capturing the body of knowledge available from research, academia, and everyday commercial practice, McConnell synthesizes the most effective techniques and must-know principles into clear, pragmatic guidance. No matter what your experience level, development environment, or project size, this book will inform and stimulate your thinking—and help you build the highest quality code.",
      "price": 2954,
      "currencyCode": "EUR",
      "author": "Mike Riley"
    },
    {
      "id": 100,
      "title": "Code Complete: A Practical Handbook of Software Construction",
      "isbn": "978-0735619678",
      "description":
          "Widely considered one of the best practical guides to programming, Steve McConnell’s original CODE COMPLETE has been helping developers write better software for more than a decade. Now this classic book has been fully updated and revised with leading-edge practices—and hundreds of new code samples—illustrating the art and science of software construction. Capturing the body of knowledge available from research, academia, and everyday commercial practice, McConnell synthesizes the most effective techniques and must-know principles into clear, pragmatic guidance. No matter what your experience level, development environment, or project size, this book will inform and stimulate your thinking—and help you build the highest quality code.",
      "price": 2954,
      "currencyCode": "EUR",
      "author": "Mike Riley"
    },
    {
      "id": 100,
      "title": "Code Complete: A Practical Handbook of Software Construction",
      "isbn": "978-0735619678",
      "description":
          "Widely considered one of the best practical guides to programming, Steve McConnell’s original CODE COMPLETE has been helping developers write better software for more than a decade. Now this classic book has been fully updated and revised with leading-edge practices—and hundreds of new code samples—illustrating the art and science of software construction. Capturing the body of knowledge available from research, academia, and everyday commercial practice, McConnell synthesizes the most effective techniques and must-know principles into clear, pragmatic guidance. No matter what your experience level, development environment, or project size, this book will inform and stimulate your thinking—and help you build the highest quality code.",
      "price": 2954,
      "currencyCode": "EUR",
      "author": "Mike Riley"
    },
    {
      "id": 100,
      "title": "Code Complete: A Practical Handbook of Software Construction",
      "isbn": "978-0735619678",
      "description":
          "Widely considered one of the best practical guides to programming, Steve McConnell’s original CODE COMPLETE has been helping developers write better software for more than a decade. Now this classic book has been fully updated and revised with leading-edge practices—and hundreds of new code samples—illustrating the art and science of software construction. Capturing the body of knowledge available from research, academia, and everyday commercial practice, McConnell synthesizes the most effective techniques and must-know principles into clear, pragmatic guidance. No matter what your experience level, development environment, or project size, this book will inform and stimulate your thinking—and help you build the highest quality code.",
      "price": 2954,
      "currencyCode": "EUR",
      "author": "Mike Riley",
    }
  ];
}
