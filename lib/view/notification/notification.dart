import 'package:bookapp/core/components/animations/bottomAnimation.dart';
import 'package:bookapp/core/components/appbar/custom_app_two.dart';
import 'package:bookapp/core/components/scaffold/custom_scaffold.dart';
import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    return WidgetAnimator(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextWidget(
              text: "You do not have any notifications at the moment.",
              textStyle: TextStyle(
                color: _themeProvider.currentTheme != ThemeData.light()
                    ? AppColors.white
                    : AppColors.black,
                decoration: TextDecoration.none,
              ).largeStyle,
              textAlign: TextAlign.center,
            ),
            _emptyBookmarkImage()
          ],
        ),
      ),
    );
  }

  Widget _emptyBookmarkImage() {
    return WidgetAnimator(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Container(
          height: 300,
          width: double.infinity,
          child: SvgPicture.asset(
            "n1".toSVG,
          ),
        ),
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
