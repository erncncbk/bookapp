import 'package:bookapp/core/components/animations/bottomAnimation.dart';
import 'package:bookapp/core/components/appbar/custom_app_bar.dart';
import 'package:bookapp/core/components/bottomnavbar/custom_bottom_navigation_bar.dart';
import 'package:bookapp/core/components/scaffold/custom_scaffold.dart';
import 'package:bookapp/core/components/search/search_bar.dart';
import 'package:bookapp/core/components/search/search_container.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/app/app_constants.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
import 'package:bookapp/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

import '../../core/init/provider/app_state/app_state_provider.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  AppStateProvider? _appStateProvider = locator<AppStateProvider>();
  BookStateProvider? _bookStateProvider = locator<BookStateProvider>();
  NavigationService navigation = NavigationService.instance;

  @override
  Widget build(BuildContext context) {
    _bookStateProvider = Provider.of<BookStateProvider>(context);
    final _themeProvider = Provider.of<ThemeNotifier>(context);
    // return Scaffold(
    //   backgroundColor: _themeProvider.currentTheme == ThemeData.light()
    //       ? AppColors.white
    //       : AppColors.black,
    //   body: SafeArea(
    //     child: _body(_bookStateProvider!, _themeProvider),
    //   ),
    //   bottomNavigationBar:
    //       _bookStateProvider?.getBookListModel?.isNotEmpty ?? false
    //           ? CustomBottomNavigationBar()
    //           : SizedBox(),
    // );
    return CustomScaffold(
        appbarWidget: _bookStateProvider?.getBookListModel?.isNotEmpty ?? false
            ? CustomAppBar(
                title: "Discover",
                actionWidget: _actionWidget(_themeProvider),
              )
            : SizedBox(),
        contentWidget: _bookStateProvider?.getBookListModel?.isNotEmpty ?? false
            ? _body(_bookStateProvider!, _themeProvider)
            : SizedBox(),
        isAsyncCall: _appStateProvider!.isProgressIndicatorVisible,
        bottomNavigatorBar:
            _bookStateProvider?.getBookListModel?.isNotEmpty ?? false
                ? CustomBottomNavigationBar()
                : SizedBox(),
        context: context);
  }

  Widget _body(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return Column(
      children: [
        // SearchContainer(),

        // SearchBar(
        //   isEnable: false,
        //   searchFunction: () {
        //     navigation.navigateToPage(path: NavigationConstants.searchPage);
        //   },
        // ),

        __verticalDiscoverList(_bookStateProvider, _themeProvider),
      ],
    );
  }

  Widget __verticalDiscoverList(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return Expanded(
      child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 4.0,
          childAspectRatio: 3 / 4,
          children: List.generate(Constant.discoverImages.length, (index) {
            return GestureDetector(
              onTap: () {
                navigation.navigateToPage(
                    path: NavigationConstants.discoverDetail, data: "xdxp");
              },
              // child: _bookCard(_bookStateProvider, _themeProvider, index),
              child: WidgetAnimator(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(
                            Constant.discoverImages[index],
                          ),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
            );
          })),
    );
  }

  Widget _actionWidget(ThemeNotifier _themeProvider) {
    return IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Icon(
          Icons.notifications_none_rounded,
        ),
        onPressed: () {
          if (_appStateProvider?.getToken == null) {
            navigation.navigateToPage(
              path: NavigationConstants.loginPage,
            );
          } else {
            navigation.navigateToPage(
              path: NavigationConstants.notificationPage,
            );
          }
        });
  }
}
