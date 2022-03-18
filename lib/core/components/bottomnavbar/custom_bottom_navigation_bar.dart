import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
import 'package:bookapp/locator.dart';
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
  BookStateProvider? _bookStateProvider = locator<BookStateProvider>();

  @override
  Widget build(BuildContext context) {
    NavigationService navigation = NavigationService.instance;
    AppStateProvider _appStateProvider = Provider.of<AppStateProvider>(context);
    _bookStateProvider = Provider.of<BookStateProvider>(context);

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
                    navigation.navigateToPageClear(
                      path: NavigationConstants.homeView,
                    );
                  } else if (index == 1) {
                    navigation.navigateToPageClear(
                        path: NavigationConstants.discoverPage);
                  } else if (index == 2) {
                    navigation.navigateToPage(
                      path: NavigationConstants.favorites,
                    );
                  } else if (index == 3) {
                    navigation.navigateToPage(
                      path: NavigationConstants.shoppingCart,
                    );
                  }
                  // _appStateProvider.setSelectedBottomIndex(index);
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
                          ? Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Icon(
                                  Icons.shopping_bag,
                                  size: 20,
                                  color: AppColors.kPrimary,
                                ),
                                _bookStateProvider!.getCartItem > 0
                                    ? Positioned(
                                        top: -8.0,
                                        right: -10.0,
                                        child: CircleAvatar(
                                          radius: 8,
                                          backgroundColor: AppColors.white,
                                          child: Text(
                                            _bookStateProvider!.getCartItem
                                                .toString(),
                                            style:
                                                TextStyle(color: AppColors.grey)
                                                    .extraSmallStyle2,
                                          ),
                                        ))
                                    : SizedBox()
                              ],
                            )
                          : Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 20,
                                  color: _themeProvider.currentTheme !=
                                          ThemeData.light()
                                      ? AppColors.white
                                      : AppColors.black,
                                ),
                                _bookStateProvider!.getCartItem > 0
                                    ? Positioned(
                                        top: -8.0,
                                        right: -10.0,
                                        child: CircleAvatar(
                                          radius: 8,
                                          backgroundColor: AppColors.white,
                                          child: Text(
                                            _bookStateProvider!.getCartItem
                                                .toString(),
                                            style:
                                                TextStyle(color: AppColors.grey)
                                                    .extraSmallStyle2,
                                          ),
                                        ))
                                    : SizedBox()
                              ],
                            ),
                      label: 'Cart'),
                ]),
          )),
    );
  }
}
