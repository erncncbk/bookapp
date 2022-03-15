import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/enums/page_enums.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    AppStateProvider _appStateProvider = Provider.of<AppStateProvider>(context);
    NavigationService navigation = NavigationService.instance;

    final _themeProvider = Provider.of<ThemeNotifier>(context);

    return Container(
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: BottomNavigationBar(
                backgroundColor:
                    _themeProvider.currentTheme != ThemeData.light()
                        ? AppColors.white.withOpacity(0.13)
                        : AppColors.grey.withOpacity(0.13),
                currentIndex: _appStateProvider.getSelectedBottomIndex!,
                onTap: (int index) {
                  if (index == 0) {
                    _appStateProvider.setPageEnums(PageEnums.HOME);
                    navigation.navigateToPageClear(
                      path: NavigationConstants.homeView,
                    );
                  } else if (index == 1) {
                    navigation.navigateToPageClear(
                        path: NavigationConstants.discoverPage);
                    _appStateProvider.setPageEnums(PageEnums.PROFILE);
                  } else if (index == 2) {
                    _appStateProvider.setPageEnums(PageEnums.CALENDER);
                  } else if (index == 3) {
                    _appStateProvider.setPageEnums(PageEnums.CALENDER);
                  } else if (index == 4) {
                    _appStateProvider.setPageEnums(PageEnums.CALENDER);
                  }
                  _appStateProvider.setSelectedBottomIndex(index);
                },
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 10,
                selectedIconTheme: CupertinoIconThemeData(),
                unselectedFontSize: 10,
                selectedItemColor:
                    _themeProvider.currentTheme != ThemeData.light()
                        ? AppColors.white
                        : AppColors.black,
                unselectedItemColor:
                    _themeProvider.currentTheme != ThemeData.light()
                        ? AppColors.white
                        : AppColors.black,
                showUnselectedLabels: true,
                showSelectedLabels: true,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: _appStateProvider.getSelectedBottomIndex == 0
                          ? Icon(
                              Icons.book,
                              size: 24,
                              color: AppColors.kPrimary,
                            )
                          : Icon(
                              Icons.book_outlined,
                              size: 20,
                              color: _themeProvider.currentTheme !=
                                      ThemeData.light()
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                      label: 'Books'),
                  BottomNavigationBarItem(
                      icon: _appStateProvider.getSelectedBottomIndex == 1
                          ? Icon(
                              Icons.keyboard_command_key_sharp,
                              size: 24,
                              color: AppColors.kPrimary,
                            )
                          : Icon(
                              Icons.keyboard_command_key_sharp,
                              size: 20,
                              color: _themeProvider.currentTheme !=
                                      ThemeData.light()
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                      label: 'Discover'),
                  BottomNavigationBarItem(
                      icon: _appStateProvider.getSelectedBottomIndex == 2
                          ? Icon(
                              Icons.favorite,
                              size: 24,
                              color: AppColors.kPrimary,
                            )
                          : Icon(
                              Icons.favorite_border_outlined,
                              size: 20,
                              color: _themeProvider.currentTheme !=
                                      ThemeData.light()
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                      label: 'Favorites'),
                  BottomNavigationBarItem(
                      icon: _appStateProvider.getSelectedBottomIndex == 3
                          ? Icon(
                              Icons.shopping_bag,
                              size: 24,
                              color: AppColors.kPrimary,
                            )
                          : Icon(
                              Icons.shopping_bag_outlined,
                              size: 20,
                              color: _themeProvider.currentTheme !=
                                      ThemeData.light()
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                      label: 'Badge'),
                ]),
          )),
    );
  }
}
