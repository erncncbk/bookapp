import 'package:bookapp/core/components/animations/bottomAnimation.dart';
import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EmptyBookmark extends StatefulWidget {
  const EmptyBookmark({Key? key}) : super(key: key);

  @override
  State<EmptyBookmark> createState() => _EmptyBookmarkState();
}

class _EmptyBookmarkState extends State<EmptyBookmark> {
  NavigationService navigation = NavigationService.instance;

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeNotifier>(context);

    return _emptyBookmark(_themeProvider);
  }

  Widget _emptyBookmark(ThemeNotifier _themeProvider) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: WidgetAnimator(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              TextWidget(
                text: "Your Bookmark is empty",
                textStyle: TextStyle(
                  color: _themeProvider.currentTheme != ThemeData.light()
                      ? AppColors.white
                      : AppColors.black,
                  decoration: TextDecoration.none,
                ).largeStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              TextWidget(
                text:
                    "How about taking a stroll?\nWe're sure you have something suitable.",
                textStyle: TextStyle(
                  color: _themeProvider.currentTheme != ThemeData.light()
                      ? AppColors.white
                      : AppColors.black,
                  decoration: TextDecoration.none,
                ).normalStyle,
                textAlign: TextAlign.center,
              ),
              _emptyBookmarkImage(),
            ],
          ),
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
            "b1".toSVG,
          ),
        ),
      ),
    );
  }
}
