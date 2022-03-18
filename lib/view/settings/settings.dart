import 'package:bookapp/core/components/appbar/custom_app_two.dart';
import 'package:bookapp/core/components/scaffold/custom_scaffold.dart';
import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/services/helper_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  NavigationService navigation = NavigationService.instance;

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeNotifier>(context);
    return CustomScaffold(
        appbarWidget: CustomAppBarTwo(
          title: "Settings",
          actionWidget: HelperService.moreHoriz(),
        ),
        contentWidget: _body(_themeProvider),
        context: context);
  }

  Widget _body(ThemeNotifier _themeProvider) {
    return Container(
      child: Column(children: [
        _list("Notification Options", () {
          navigation.navigateToPage(
              path: NavigationConstants.notificationOptions);
        }, _themeProvider),
        _list("Terms & Conditions", () {}, _themeProvider),
      ]),
    );
  }

  Widget _list(
      String title, VoidCallback function, ThemeNotifier _themeProvider) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Row(
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
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Divider(
                height: .5,
                color: _themeProvider.currentTheme != ThemeData.light()
                    ? AppColors.white.withOpacity(0.13)
                    : AppColors.grey.withOpacity(0.13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
