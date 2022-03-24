import 'dart:async';
import 'dart:math';

import 'package:bookapp/core/components/animations/bottomAnimation.dart';
import 'package:bookapp/core/components/appbar/custom_app_bar.dart';
import 'package:bookapp/core/components/bottomnavbar/custom_bottom_navigation_bar.dart';
import 'package:bookapp/core/components/card/books_card.dart';
import 'package:bookapp/core/components/scaffold/custom_scaffold.dart';
import 'package:bookapp/core/components/search/search_container.dart';
import 'package:bookapp/core/components/slider/custom_carousel_card.dart';
import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/app/app_constants.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
import 'package:bookapp/core/init/services/helper_service.dart';
import 'package:bookapp/core/init/services/process_service.dart';
import 'package:bookapp/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ProcessService? _processService = locator<ProcessService>();
  final AppStateProvider? _appStateProvider = locator<AppStateProvider>();
  BookStateProvider? _bookStateProvider = locator<BookStateProvider>();
  NavigationService navigation = NavigationService.instance;
  final HelperService? _helperService = locator<HelperService>();

  var num = 1;
  @override
  void initState() {
    main();

    super.initState();
  }

  int random(min, max) {
    return min + Random().nextInt(max - min);
  }

  Future main() async {
    await getBookListAsync();
    num = random(1, 6);
  }

  Future getBookListAsync() async {
    await _processService!.getRepositoryAsync(
      context: context,
      function: () async => await _bookStateProvider!.getBookList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _bookStateProvider = Provider.of<BookStateProvider>(context);
    AppStateProvider appStateProvider = Provider.of<AppStateProvider>(context);
    appStateProvider.setSelectedBottomIndex(0, isNotifier: false);
    final _themeProvider = Provider.of<ThemeNotifier>(context);

    return CustomScaffold(
        appbarWidget: _bookStateProvider!.getBookListModel != null
            ? CustomAppBar(
                title: "Home",
                actionWidget: _helperService!.actionWidget(_themeProvider),
              )
            : SizedBox(),
        contentWidget: _bookStateProvider!.getBookListModel != null
            ? _body(_bookStateProvider!, _themeProvider)
            : SizedBox(),
        isAsyncCall: _appStateProvider!.isProgressIndicatorVisible,
        bottomNavigatorBar: _bookStateProvider!.getBookListModel != null
            ? CustomBottomNavigationBar()
            : SizedBox(),
        context: context);
  }

  Widget _body(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return _bookStateProvider.getBookListModel?.isEmpty ?? false
        ? const SizedBox()
        : Column(
            children: [
              const SearchContainer(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: getBookListAsync,
                  color: _themeProvider.currentTheme != ThemeData.light()
                      ? AppColors.white
                      : AppColors.black,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(children: [
                      Container(
                        height: 140,
                        child: CustomCarouselCard(),
                      ),
                      _selectedBooks(_bookStateProvider, _themeProvider),
                      __horizontalBookList(_bookStateProvider, _themeProvider),
                    ]),
                  ),
                ),
              )
            ],
          );
  }

  Widget _selectedBooks(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return WidgetAnimator(
      child: GestureDetector(
        onTap: () {
          _goBookDetail(_bookStateProvider, (num - 1));
        },
        child: Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.047,
              right: MediaQuery.of(context).size.width * 0.047),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // if you need this
              side: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 3,
              ),
            ),
            child: Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.width * 0.047),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/$num.png",
                          ),
                          fit: BoxFit.contain,
                        )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.025,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: "Editor's Pick",
                          textStyle: TextStyle(
                            color: AppColors.kPrimary,
                            decoration: TextDecoration.none,
                          ).largeStyle,
                          textAlign: TextAlign.right,
                        ),
                        TextWidget(
                          text: _bookStateProvider
                                  .getBookListModel?[num - 1].title
                                  .toString() ??
                              "",
                          textStyle: TextStyle(
                            color:
                                _themeProvider.currentTheme != ThemeData.light()
                                    ? AppColors.white
                                    : AppColors.black,
                            decoration: TextDecoration.none,
                          ).normalStyle,
                          textAlign: TextAlign.center,
                        ),
                        TextWidget(
                          text:
                              "by ${_bookStateProvider.getBookListModel?[num - 1].author ?? ""}",
                          textStyle: TextStyle(
                            color: AppColors.kPrimary,
                            decoration: TextDecoration.none,
                          ).extraSmallStyle,
                          textAlign: TextAlign.center,
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(top: 5),
                        //   child: GeneralButtonWidget(
                        //     btnText: LocaleKeys.button_make_book,
                        //     radius: 28,
                        //     width: MediaQuery.of(context).size.width / 2.5,
                        //     btnFunction: this.widget.btnFunction,
                        //   ),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bookCard(BookStateProvider _bookStateProvider,
      ThemeNotifier _themeProvider, int index) {
    return Stack(
      children: [
        Container(
          width: 240,
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.047,
              right: MediaQuery.of(context).size.width * 0.047),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // if you need this
              side: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 2,
              ),
            ),
            child: Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.width * 0.047),
              child: Column(
                children: [
                  Hero(
                    transitionOnUserGestures: true,
                    tag: "img$index",
                    child: Container(
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            image: AssetImage(
                              Constant.book_images[index],
                            ),
                            fit: BoxFit.contain,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  TextWidget(
                    text: _bookStateProvider.getBookListModel?[index].title
                            .toString() ??
                        "",
                    textStyle: TextStyle(
                      color: _themeProvider.currentTheme != ThemeData.light()
                          ? AppColors.white
                          : AppColors.black,
                      decoration: TextDecoration.none,
                    ).smallStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 10,
            right: 30,
            child: TextWidget(
              text:
                  '${_bookStateProvider.getBookListModel?[index].price} ${_bookStateProvider.getBookListModel?[index].currencyCode}',
              textStyle: TextStyle(
                color: _themeProvider.currentTheme != ThemeData.light()
                    ? AppColors.white
                    : AppColors.black,
                decoration: TextDecoration.none,
              ).smallStyle,
              textAlign: TextAlign.right,
            )),
      ],
    );
  }

  Widget __horizontalBookList(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return Container(
      height: 300,
      width: double.infinity,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: _bookStateProvider.getBookListModel?.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                _goBookDetail(_bookStateProvider, index);
              },
              // child: _bookCard(_bookStateProvider, _themeProvider, index)
              child: BooksCard(
                imgHeight: 180,
                imgWidth: 180,
                index: index,
                title: _bookStateProvider.getBookListModel![index].title,
                price: _bookStateProvider.getBookListModel![index].price
                    .toString(),
                currencyCode:
                    _bookStateProvider.getBookListModel![index].currencyCode,
              ));
        },
      ),
    );
  }

  _goBookDetail(_bookStateProvider, index) {
    _bookStateProvider
        .setSelectedBookId(_bookStateProvider.getBookListModel![index].id);
    navigation.navigateToPage(
      path: NavigationConstants.bookDetail,
    );
  }
}
