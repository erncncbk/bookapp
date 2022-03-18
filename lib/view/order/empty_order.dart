import 'package:bookapp/core/components/animations/bottomAnimation.dart';
import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EmptyOrder extends StatefulWidget {
  const EmptyOrder({Key? key}) : super(key: key);

  @override
  State<EmptyOrder> createState() => _EmptyOrderState();
}

class _EmptyOrderState extends State<EmptyOrder> {
  NavigationService navigation = NavigationService.instance;

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeNotifier>(context);

    return _emptyOrder(_themeProvider);
  }

  Widget _emptyOrder(ThemeNotifier _themeProvider) {
    return SingleChildScrollView(
      child: WidgetAnimator(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              TextWidget(
                text: "You haven't placed any order yet.",
                textStyle: TextStyle(
                  color: _themeProvider.currentTheme != ThemeData.light()
                      ? AppColors.white
                      : AppColors.black,
                  decoration: TextDecoration.none,
                ).normalStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              TextWidget(
                text: "When you do, their status appear here.",
                textStyle: TextStyle(
                  color: _themeProvider.currentTheme != ThemeData.light()
                      ? AppColors.white
                      : AppColors.black,
                  decoration: TextDecoration.none,
                ).extraSmallStyle,
                textAlign: TextAlign.center,
              ),
              _emptyOrderImage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyOrderImage() {
    return WidgetAnimator(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Container(
          height: 300,
          width: double.infinity,
          child: SvgPicture.asset(
            "o1".toSVG,
          ),
        ),
      ),
    );
  }
}
