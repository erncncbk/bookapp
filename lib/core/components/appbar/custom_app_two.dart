import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBarTwo extends StatefulWidget {
  const CustomAppBarTwo({Key? key, this.title, this.actionWidget})
      : super(key: key);

  final String? title;
  final Widget? actionWidget;

  @override
  _CustomAppBarTwoState createState() => _CustomAppBarTwoState();
}

class _CustomAppBarTwoState extends State<CustomAppBarTwo> {
  @override
  Widget build(BuildContext context) {
    AppStateProvider _appStateProvider = Provider.of<AppStateProvider>(context);
    final _themeProvider = Provider.of<ThemeNotifier>(context);

    return PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
              color: _themeProvider.currentTheme != ThemeData.light()
                  ? AppColors.white
                  : AppColors.black),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          foregroundColor: _themeProvider.currentTheme != ThemeData.light()
              ? AppColors.white
              : AppColors.black,
          toolbarHeight: MediaQuery.of(context).size.height * 0.045,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          actions: [
            widget.actionWidget!,
          ],
          title: Center(
            child: Container(
              padding: EdgeInsets.only(top: 8),
              child: TextWidget(
                text: widget.title ?? "",
                textStyle: TextStyle(
                        color: AppColors.kPrimary,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w500)
                    .extraSmallStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }).customIcon,
        ));
  }
}
