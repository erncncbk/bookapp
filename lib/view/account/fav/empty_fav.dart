import 'package:bookapp/core/components/animations/bottomAnimation.dart';
import 'package:bookapp/core/components/buttons/custom_elevated_button.dart';
import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EmptyFav extends StatefulWidget {
  const EmptyFav({Key? key}) : super(key: key);

  @override
  State<EmptyFav> createState() => _EmptyFavState();
}

class _EmptyFavState extends State<EmptyFav> {
  NavigationService navigation = NavigationService.instance;

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeNotifier>(context);

    return _emptyFav(_themeProvider);
  }

  Widget _emptyFav(ThemeNotifier _themeProvider) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: WidgetAnimator(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              TextWidget(
                text: "No favorites yet",
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
                    "Tap on the hearth to add your favorites!\nAdd books to your favorites, see them here at a glance",
                textStyle: TextStyle(
                  color: _themeProvider.currentTheme != ThemeData.light()
                      ? AppColors.white
                      : AppColors.black,
                  decoration: TextDecoration.none,
                ).normalStyle,
                textAlign: TextAlign.center,
              ),
              _emptFavImage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptFavImage() {
    return WidgetAnimator(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Container(
          height: 300,
          width: double.infinity,
          child: Image.asset(
            "f1".toPng,
          ),
        ),
      ),
    );
  }
}
