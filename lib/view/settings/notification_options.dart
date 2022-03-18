import 'package:bookapp/core/components/appbar/custom_app_two.dart';
import 'package:bookapp/core/components/scaffold/custom_scaffold.dart';
import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/extensions/context_extension.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/services/helper_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationOptions extends StatefulWidget {
  NotificationOptions({Key? key}) : super(key: key);

  @override
  State<NotificationOptions> createState() => _NotificationOptionsState();
}

class _NotificationOptionsState extends State<NotificationOptions> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeNotifier>(context);
    return CustomScaffold(
        appbarWidget: CustomAppBarTwo(
          title: "Notification Options",
          actionWidget: HelperService.moreHoriz(),
        ),
        contentWidget: _body(_themeProvider),
        context: context);
  }

  Widget _body(ThemeNotifier _themeProvider) {
    return Container(
      child: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: TextWidget(
            text:
                "Set notification settings to be informed about the 'Book Store' advantages.",
            textStyle: TextStyle(
              color: _themeProvider.currentTheme != ThemeData.light()
                  ? AppColors.white
                  : AppColors.black,
              decoration: TextDecoration.none,
            ).extraSmallStyle,
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: context.lowValue),
        _list("My Notifications", _themeProvider),
      ]),
    );
  }

  Widget _list(String title, ThemeNotifier _themeProvider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            text: title,
            textStyle: TextStyle(
              color: _themeProvider.currentTheme != ThemeData.light()
                  ? AppColors.white
                  : AppColors.black,
              decoration: TextDecoration.none,
            ).extraSmallStyle,
            textAlign: TextAlign.left,
          ),
          CupertinoSwitch(
            value: isOpen,
            onChanged: (value) {
              isOpen = value;
              setState(
                () {},
              );
            },
            thumbColor: AppColors.white,
            activeColor: AppColors.kPrimary,
          ),
        ],
      ),
    );
  }
}
