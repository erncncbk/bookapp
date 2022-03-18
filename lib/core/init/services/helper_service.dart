import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:flutter/material.dart';

class HelperService {
  NavigationService navigation = NavigationService.instance;

  static List<TextSpan> highlightOccurrences(String? source, String? query) {
    if (query == null ||
        query.isEmpty ||
        !source!.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.kPrimary)
            .extraSmallStyle,
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }

  Widget actionWidget(ThemeNotifier _themeProvider) {
    return IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Icon(
          Icons.notifications_none_rounded,
        ),
        onPressed: () {
          navigation.navigateToPage(
            path: NavigationConstants.notificationPage,
          );
        });
  }

  ///Widget like that. | - | 1  | + |
  ///provide initial value, and functions.
  ///title, hideable and changeable
  ///Padding size is optional
  static Widget quantityWidget(
      int value, VoidCallback? increaseFunc, VoidCallback? decreaseFunc,
      {String title = "Quantity",
      bool isTitle = true,
      double buttonPaddingSize = 10}) {
    return FittedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(visible: isTitle, child: Text(title)),
          Row(children: [
            HelperService.iconButtonWidget(Icons.remove, decreaseFunc),
            Container(
                padding: EdgeInsets.only(
                    left: buttonPaddingSize, right: buttonPaddingSize),
                child: TextWidget(
                  text: value.toString(),
                  textAlign: TextAlign.left,
                )),
            HelperService.iconButtonWidget(Icons.add, increaseFunc),
          ]),
        ],
      ),
    );
  }

  /// icon button widget that has white container and shadow
  /// provide icon and function
  static Widget iconButtonWidget(IconData iconData, VoidCallback? onpress) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 3),
            )
          ]),
      child: IconButton(
        icon: Icon(
          iconData,
          color: AppColors.kPrimary,
        ),
        onPressed: onpress!,
      ),
    );
  }

  static Widget moreHoriz() {
    return IconButton(
        icon: Icon(Icons.more_horiz),
        onPressed: () => {print("more")}).customIcon;
  }
}
