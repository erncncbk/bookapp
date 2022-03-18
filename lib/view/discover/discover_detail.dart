import 'package:bookapp/core/components/appbar/custom_app_bar.dart';
import 'package:bookapp/core/components/appbar/custom_app_two.dart';
import 'package:bookapp/core/components/bottomnavbar/custom_bottom_navigation_bar.dart';
import 'package:bookapp/core/components/card/books_card.dart';
import 'package:bookapp/core/components/scaffold/custom_scaffold.dart';
import 'package:bookapp/core/components/search/search_container.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
import 'package:bookapp/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiscoverDetail extends StatefulWidget {
  const DiscoverDetail({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<DiscoverDetail> createState() => _DiscoverDetailState();
}

class _DiscoverDetailState extends State<DiscoverDetail> {
  BookStateProvider? _bookStateProvider = locator<BookStateProvider>();
  NavigationService navigation = NavigationService.instance;

  @override
  Widget build(BuildContext context) {
    _bookStateProvider = Provider.of<BookStateProvider>(context);
    final _themeProvider = Provider.of<ThemeNotifier>(context);
    AppStateProvider _appStateProvider = Provider.of<AppStateProvider>(context);
    _appStateProvider.setSelectedBottomIndex(1, isNotifier: false);
    return CustomScaffold(
        appbarWidget: _bookStateProvider?.getBookListModel?.isNotEmpty ?? false
            ? CustomAppBar(
                title: widget.title ?? "What Should I Read",
                actionWidget: _actionWidget(_themeProvider),
                leadingWidget: _leadingWidget(_themeProvider),
              )
            : SizedBox(),
        contentWidget: _bookStateProvider?.getBookListModel?.isNotEmpty ?? false
            ? _body(_bookStateProvider!, _themeProvider)
            : SizedBox(),
        isAsyncCall: false,
        context: context);
  }

  Widget _body(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return Column(
      children: [
        SearchContainer(),
        __verticalBookList(_bookStateProvider, _themeProvider),
      ],
    );
  }

  Widget __verticalBookList(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return Expanded(
      child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 4.0,
          childAspectRatio: 3 / 4,
          children: List.generate(_bookStateProvider.getBookListModel!.length,
              (index) {
            return GestureDetector(
                onTap: () {
                  _bookStateProvider.setSelectedBookId(
                      _bookStateProvider.getBookListModel![index].id);
                  navigation.navigateToPage(
                    path: NavigationConstants.bookDetail,
                  );
                },
                // child: _bookCard(_bookStateProvider, _themeProvider, index),
                child: BooksCard(
                  index: index,
                  title: _bookStateProvider.getBookListModel![index].title,
                  price: _bookStateProvider.getBookListModel![index].price
                      .toString(),
                  currencyCode:
                      _bookStateProvider.getBookListModel![index].currencyCode,
                ));
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
          navigation.navigateToPage(
            path: NavigationConstants.notificationPage,
          );
        });
  }

  Widget _leadingWidget(ThemeNotifier _themeProvider) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        }).customIcon;
  }
}
