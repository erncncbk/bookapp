import 'package:bookapp/core/components/buttons/custom_elevated_button.dart';
import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/app/app_constants.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
import 'package:bookapp/core/init/services/process_service.dart';
import 'package:bookapp/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotEmptyFav extends StatefulWidget {
  const NotEmptyFav({Key? key}) : super(key: key);

  @override
  State<NotEmptyFav> createState() => _NotEmptyFavState();
}

class _NotEmptyFavState extends State<NotEmptyFav> {
  NavigationService navigation = NavigationService.instance;
  final ProcessService? _processService = locator<ProcessService>();
  BookStateProvider? _bookStateProvider = locator<BookStateProvider>();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bookStateProvider = Provider.of<BookStateProvider>(context);
    final _themeProvider = Provider.of<ThemeNotifier>(context);
    _bookStateProvider!.findFavItems(isNotifier: false);

    return _notEmptyFav(_bookStateProvider!, _themeProvider);
  }

  Widget _notEmptyFav(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: TextWidget(
                text:
                    "You have ${_bookStateProvider.getFavCount} favorite item  ",
                textStyle: TextStyle(
                  color: _themeProvider.currentTheme != ThemeData.light()
                      ? AppColors.white
                      : AppColors.black,
                  decoration: TextDecoration.none,
                ).normalStyle,
                textAlign: TextAlign.left,
              ),
            ),
            _cartList(_bookStateProvider, _themeProvider),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartList(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return ListView.builder(
        itemCount: _bookStateProvider.getFavBookList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var num = _bookStateProvider.getFavBookList[index].id
              .toString()
              .replaceAll('0', "");
          return GestureDetector(
            onTap: () {
              _bookStateProvider.setSelectedBookId(
                  _bookStateProvider.getFavBookList[index].id);
              navigation.navigateToPage(
                path: NavigationConstants.bookDetail,
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(0, 3),
                    )
                  ],
                  // color: _themeProvider.currentTheme != ThemeData.light()
                  //     ? AppColors.white.withOpacity(0.13)
                  //     : AppColors.grey.withOpacity(0.13),
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Hero(
                            transitionOnUserGestures: true,
                            tag: "img${int.parse(num) - 1}",
                            child: Container(
                              height: 100,
                              width: 80,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 3,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                  color: AppColors.black,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      Constant.book_images[int.parse(num) - 1],
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              //Title
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          child: TextWidget(
                                            text: _bookStateProvider
                                                .getFavBookList[index].title,
                                            textStyle: TextStyle(
                                              color:
                                                  _themeProvider.currentTheme !=
                                                          ThemeData.light()
                                                      ? AppColors.white
                                                      : AppColors.black,
                                              decoration: TextDecoration.none,
                                            ).smallStyle,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        //Author
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          child: TextWidget(
                                            text:
                                                "by ${_bookStateProvider.getFavBookList[index].author}",
                                            textStyle: TextStyle(
                                              color: AppColors.kPrimary,
                                              decoration: TextDecoration.none,
                                            ).extraSmallStyle,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: GestureDetector(
                                            onTap: () {
                                              _bookStateProvider
                                                  .setSelectedBookId(
                                                      _bookStateProvider
                                                          .getFavBookList[index]
                                                          .id);
                                              _bookStateProvider.setFavList();
                                            },
                                            child: CircleAvatar(
                                              radius: 14,
                                              backgroundColor: AppColors.white,
                                              foregroundColor:
                                                  _themeProvider.currentTheme !=
                                                          ThemeData.light()
                                                      ? AppColors.white
                                                      : AppColors.black,
                                              child: _bookStateProvider
                                                      .getFavBookList[index]
                                                      .isFav!
                                                  ? Icon(
                                                      Icons.favorite,
                                                      color: AppColors.kPrimary,
                                                    )
                                                  : Icon(
                                                      Icons
                                                          .favorite_border_outlined,
                                                      color: _themeProvider
                                                                  .currentTheme !=
                                                              ThemeData.light()
                                                          ? AppColors.white
                                                          : AppColors.black,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //Price
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      child: TextWidget(
                                        text:
                                            '${_bookStateProvider.getFavBookList[index].price} ${_bookStateProvider.getFavBookList[index].currencyCode}',
                                        textStyle: TextStyle(
                                          color: AppColors.kPrimary,
                                          decoration: TextDecoration.none,
                                        ).smallStyle,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: CustomElevatedButton(
                                      isSmall: true,
                                      btnColor: AppColors.kPrimary,
                                      btnFunction: () async {
                                        // await getBookAsync();
                                        // _bookStateProvider.setSelectedBookId(
                                        //     _bookStateProvider
                                        //         .getFavBookList[index].id);
                                        // var quantity =
                                        //     _bookStateProvider.getCartBooktMap[
                                        //         _bookStateProvider
                                        //             .getSelectedBookModel];
                                        // quantity ??= 0;
                                        // _bookStateProvider
                                        //     .updateCartBookQuantitiyFromMap(
                                        //         _bookStateProvider
                                        //             .getBookModel!,
                                        //         quantity + 1);
                                        // navigation.navigateToPage(
                                        //     path: NavigationConstants
                                        //         .shoppingCart);
                                      },
                                      text: "Add to Cart",
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          );
        });
  }
}
