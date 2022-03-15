import 'dart:math';

import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/app/app_constants.dart';
import 'package:bookapp/core/constants/enums/app_theme_enum.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/services/fb_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final FBAuthService? _fbAuthService = FBAuthService();
  NavigationService navigation = NavigationService.instance;

  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeNotifier>(context);

    List<void Function()?> functionList = [
      (() {
        print(Constant.titleList[0]);
        navigation.navigateToPage(path: NavigationConstants.accountPage);
      }),
      (() => {print(Constant.titleList[1])}),
      (() => {print(Constant.titleList[2])}),
      (() => {print(Constant.titleList[3])}),
      (() => {print(Constant.titleList[4])}),
      (() => {print(Constant.titleList[5])}),
      (() => {print(Constant.titleList[6])}),
      (() => {print(Constant.titleList[7])}),
      (() {
        print(Constant.titleList[8]);
        Navigator.pop(context);

        _fbAuthService!.signOut(context);
      }),
    ];

    return Drawer(
      backgroundColor: _themeProvider.currentTheme == ThemeData.light()
          ? AppColors.white
          : AppColors.black,
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 60,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                          child: TextWidget(
                        text: "Login",
                        textStyle: TextStyle(
                                color: _themeProvider.currentTheme !=
                                        ThemeData.light()
                                    ? AppColors.white
                                    : AppColors.black,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w600)
                            .normalStyle,
                        textAlign: TextAlign.left,
                      ))
                    ],
                  ),
                ),
                // Container(
                //   height: MediaQuery.of(context).size.height * 0.0875,
                //   width: double.infinity,
                //   child: IconButton(
                //       padding: EdgeInsets.zero,
                //       alignment: Alignment.centerRight,
                //       icon: Transform(
                //         transform: Matrix4.rotationY(pi),
                //         child: SvgPicture.asset(
                //           'menu'.toSVG,
                //           color: _themeProvider.currentTheme != ThemeData.light()
                //               ? AppColors.white
                //               : AppColors.black,
                //         ),
                //       ),
                //       onPressed: () => Navigator.pop(context)),
                // ),
                ListView.builder(
                  itemCount: Constant.titleList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                        child: ListTile(
                      leading: Icon(Constant.iconList[index]),
                      title: GestureDetector(
                        onTap: functionList[index],
                        child: TextWidget(
                          text: Constant.titleList[index],
                          textStyle: TextStyle(
                            color:
                                _themeProvider.currentTheme != ThemeData.light()
                                    ? AppColors.white
                                    : AppColors.black,
                            decoration: TextDecoration.none,
                          ).smallStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);

                        // if (index == 0) {
                        //   Navigator.pushNamed(
                        //       context, AppRoute.SUPPORTS_PAGE);
                        // } else if (index == 2) {
                        //   Navigator.pushNamed(
                        //       context, AppRoute.NEW_FEEDBACK_PAGE);
                        // } else if (index == 3) {
                        //   Navigator.pushNamed(
                        //       context, AppRoute.SCAN_PAGE);
                        // } else if (index == 4) {
                        //   Navigator.pushNamed(
                        //       context, AppRoute.CAMPAINS_PAGE);
                        // } else if (index == 5) {
                        //   showDialog(
                        //       context: context,
                        //       builder: (BuildContext context) {
                        //         return AlertWidget(
                        //           alertType: AlertType.Logout,
                        //         );
                        //       });
                        // }
                      },
                    ));
                  },
                ),
              ],
            ),
            Positioned(
                top: 10,
                bottom: 10,
                right: 0,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios_new),
                ).customIcon),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: IconButton(
                  icon: _themeProvider.currentTheme == ThemeData.light()
                      ? Icon(
                          Icons.nights_stay,
                          color: AppColors.black,
                          size: 30,
                        )
                      : Icon(
                          Icons.light_mode,
                          color: AppColors.white,
                          size: 30,
                        ),
                  onPressed: () {
                    if (_themeProvider.currentTheme == ThemeData.light()) {
                      _themeProvider.changeValue(AppThemes.DARK);
                    } else {
                      _themeProvider.changeValue(AppThemes.LIGHT);
                    }
                  },
                ).customIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
