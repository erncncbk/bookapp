import 'package:bookapp/core/components/animations/bottomAnimation.dart';
import 'package:bookapp/core/components/buttons/custom_elevated_button.dart';
import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/app/app_constants.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EmptyCart extends StatefulWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  State<EmptyCart> createState() => _EmptyCartState();
}

class _EmptyCartState extends State<EmptyCart> {
  NavigationService navigation = NavigationService.instance;

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeNotifier>(context);

    return _emptyCart(_themeProvider);
  }

  Widget _emptyCart(ThemeNotifier _themeProvider) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: WidgetAnimator(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              TextWidget(
                text: "Your Cart is empty",
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
              _shoppingCart(),
              TextWidget(
                text: "How can you shop?",
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
                text:
                    "To shop, you must  login. To place an order, you must follow the sections below.",
                textStyle: TextStyle(
                  color: _themeProvider.currentTheme != ThemeData.light()
                      ? AppColors.white
                      : AppColors.black,
                  decoration: TextDecoration.none,
                ).smallStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              _sectionsList(_themeProvider),
              CustomElevatedButton(
                isSmall: true,
                width: 200,
                btnColor: AppColors.kPrimary,
                btnFunction: () {
                  navigation.navigateToPage(
                    path: NavigationConstants.homeView,
                  );
                },
                text: "Start Shopping",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shoppingCart() {
    return WidgetAnimator(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Container(
          height: 300,
          width: double.infinity,
          child: SvgPicture.asset(
            "s1".toSVG,
          ),
        ),
      ),
    );
  }

  Widget _sectionsList(ThemeNotifier _themeProvider) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: Constant.shopSectionList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5),
                          color:
                              _themeProvider.currentTheme != ThemeData.light()
                                  ? AppColors.white
                                  : AppColors.black)),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Container(
                        child: TextWidget(
                          text: Constant.shopSectionList[index],
                          textStyle: TextStyle(
                            color:
                                _themeProvider.currentTheme != ThemeData.light()
                                    ? AppColors.white
                                    : AppColors.black,
                            decoration: TextDecoration.none,
                          ).extraSmallStyle2,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
