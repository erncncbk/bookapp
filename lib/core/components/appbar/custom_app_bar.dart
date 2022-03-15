import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.actionWidget,
    this.leadingWidget,
  }) : super(key: key);
  final String? title;
  final Widget? actionWidget;
  final Widget? leadingWidget;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    AppStateProvider _appStateProvider = Provider.of<AppStateProvider>(context);
    final _themeProvider = Provider.of<ThemeNotifier>(context);
    return PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          iconTheme: IconThemeData(
              color: _themeProvider.currentTheme != ThemeData.light()
                  ? AppColors.white
                  : AppColors.black),
          shadowColor: Colors.transparent,
          backgroundColor: _themeProvider.currentTheme != ThemeData.light()
              ? AppColors.white.withOpacity(0.13)
              : AppColors.grey.withOpacity(0.13),
          toolbarHeight: MediaQuery.of(context).size.height * 0.04,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          actions: [widget.actionWidget!],
          leading: widget.leadingWidget,
          title: Center(
            child: Container(
              padding: EdgeInsets.only(top: 8),
              child: TextWidget(
                text: widget.title ?? "",
                textStyle: TextStyle(
                        color: AppColors.kPrimary,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w500)
                    .smallStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}
