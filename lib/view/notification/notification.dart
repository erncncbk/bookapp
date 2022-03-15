import 'package:bookapp/core/components/appbar/custom_app_two.dart';
import 'package:bookapp/core/components/scaffold/custom_scaffold.dart';
import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/view/search_page/search_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NavigationService navigation = NavigationService.instance;

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeNotifier>(context);

    return CustomScaffold(
        height: 40,
        appbarWidget: CustomAppBarTwo(
          title: "Notification",
          actionWidget: _actionWidget(),
        ),
        contentWidget: _body(_themeProvider),
        isAsyncCall: false,
        context: context);
  }

  Widget _body(ThemeNotifier _themeProvider) {
    return Container(
      alignment: Alignment.topCenter,
      child: TextWidget(
        text: "You do not have any notifications at the moment.",
        textStyle: TextStyle(
          color: _themeProvider.currentTheme != ThemeData.light()
              ? AppColors.white
              : AppColors.black,
          decoration: TextDecoration.none,
        ).extraSmallStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _actionWidget() {
    return IconButton(
        icon: Icon(Icons.search),
        onPressed: () => {
              navigation.navigateToPage(path: NavigationConstants.searchPage)
            }).customIcon;
  }
}
