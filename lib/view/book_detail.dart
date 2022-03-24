import 'package:barcode_widget/barcode_widget.dart';
import 'package:bookapp/core/components/alert/alert_dialog.dart';
import 'package:bookapp/core/components/appbar/custom_app_two.dart';
import 'package:bookapp/core/components/buttons/custom_elevated_button.dart';
import 'package:bookapp/core/components/scaffold/custom_scaffold.dart';
import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/extensions/context_extension.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
import 'package:bookapp/core/init/services/helper_service.dart';
import 'package:bookapp/core/init/services/process_service.dart';
import 'package:bookapp/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class BookDetail extends StatefulWidget {
  const BookDetail({Key? key}) : super(key: key);

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  final ProcessService? _processService = locator<ProcessService>();
  AppStateProvider? _appStateProvider = locator<AppStateProvider>();
  BookStateProvider? _bookStateProvider = locator<BookStateProvider>();
  NavigationService navigation = NavigationService.instance;

  @override
  void initState() {
    main();

    super.initState();
  }

  @override
  void dispose() {
    _bookStateProvider!.setBookModel(null, isNotifier: false);
    // _bookStateProvider!.setSelectedBookId(null, isNotifier: false);

    super.dispose();
  }

  Future main() async {
    await getBookAsync();

    _bookStateProvider!.setQuantity(1, isNotifier: false);
    _bookStateProvider!.setBookMark(isNotifier: false);
  }

  Future getBookAsync() async {
    await _processService!.getRepositoryAsync(
      context: context,
      function: () async => await _bookStateProvider!.getBook(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _bookStateProvider = Provider.of<BookStateProvider>(context);
    final _themeProvider = Provider.of<ThemeNotifier>(context);

    return CustomScaffold(
        appbarWidget: _bookStateProvider!.getBookModel != null
            ? CustomAppBarTwo(
                title: "Book Detail",
                actionWidget: _actionWidget(),
              )
            : SizedBox(),
        contentWidget: _bookStateProvider!.getBookModel != null
            ? _body(_bookStateProvider!, _themeProvider)
            : SizedBox(),
        isAsyncCall: _appStateProvider!.isProgressIndicatorVisible,
        context: context);
  }

  Widget _body(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return Column(
      children: [
        Stack(
          children: [
            _image(_bookStateProvider, _themeProvider),
            _icons(_bookStateProvider, _themeProvider)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_stars(), Text("(0)")],
        ),
        _titleAuthor(_bookStateProvider, _themeProvider),
        SizedBox(
          height: context.normalValue,
        ),
        quantityAndCartBtnWidget(),
        SizedBox(
          height: context.normalValue,
        ),
        _priceBarcodeRow(_themeProvider),
        _description(_themeProvider)
      ],
    );
  }

  Widget _titleAuthor(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return Column(
      children: [
        TextWidget(
          text: '${_bookStateProvider.getBookModel?.title} ',
          textStyle: TextStyle(
            color: _themeProvider.currentTheme != ThemeData.light()
                ? AppColors.white
                : AppColors.black,
            decoration: TextDecoration.none,
          ).extraSmallStyle,
          textAlign: TextAlign.center,
        ),
        TextWidget(
          text: 'by ${_bookStateProvider.getBookModel?.author} ',
          textStyle: TextStyle(
                  color: AppColors.kPrimary,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w600)
              .extraSmallStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _image(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return Center(
      child: Container(
        width: 200,
        height: 240,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // if you need this
            side: BorderSide(
              color: AppColors.grey.withOpacity(0.8),
              width: 1,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Hero(
                transitionOnUserGestures: true,
                tag:
                    "img${int.parse(_bookStateProvider.getSelectedBookId.toString().replaceAll('0', "")) - 1}",
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    isAntiAlias: true,
                    opacity: _themeProvider.currentTheme == ThemeData.light()
                        ? 1
                        : 0.8,
                    scale: 1,
                    image: AssetImage(
                      "assets/images/${int.parse(_bookStateProvider.getSelectedBookId.toString().replaceAll('0', ""))}.png",
                    ),
                    fit: BoxFit.contain,
                  )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _icons(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return Positioned(
        top: 0,
        right: 20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                _addToFav();
              },
              child: _bookStateProvider.getSelectedBookListModel!.isFav!
                  ? Icon(
                      Icons.favorite,
                      color: AppColors.kPrimary,
                    )
                  : Icon(
                      Icons.favorite_border_outlined,
                      color: _themeProvider.currentTheme != ThemeData.light()
                          ? AppColors.white
                          : AppColors.black,
                    ),
            ),
            SizedBox(
              height: context.lowValue,
            ),
            GestureDetector(
              onTap: () {
                print("d");
                Share.share('check out my website https://erncncbk-13.web.app',
                    subject: 'Look what I made!');
              },
              child: Icon(
                Icons.ios_share,
                color: _themeProvider.currentTheme != ThemeData.light()
                    ? AppColors.white
                    : AppColors.black,
              ),
            ),
            SizedBox(
              height: context.lowValue,
            ),
            Container(
              child: GestureDetector(
                onTap: () {
                  navigation.navigateToPage(
                    path: NavigationConstants.shoppingCart,
                  );
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      color: _themeProvider.currentTheme != ThemeData.light()
                          ? AppColors.white
                          : AppColors.black,
                    ),
                    _bookStateProvider.getCartItem > 0
                        ? Positioned(
                            bottom: -4,
                            right: -2,
                            child: CircleAvatar(
                              radius: 6,
                              backgroundColor: AppColors.kPrimary,
                              child: FittedBox(
                                child: Text(
                                  _bookStateProvider.getCartItem.toString(),
                                  style: TextStyle(color: AppColors.white)
                                      .extraSmallStyle2,
                                ),
                              ),
                            ))
                        : SizedBox()
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget _actionWidget() {
    return IconButton(
        icon: Icon(Icons.more_horiz),
        onPressed: () => {print("xd")}).customIcon;
  }

  Widget _priceBarcodeRow(ThemeNotifier _themeProvider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: _themeProvider.currentTheme == ThemeData.light()
            ? AppColors.grey.withOpacity(0.1)
            : AppColors.grey.withOpacity(0.6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: 'Price',
                  textStyle: TextStyle(
                          color:
                              _themeProvider.currentTheme != ThemeData.light()
                                  ? AppColors.white
                                  : AppColors.black,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w800)
                      .smallStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: context.lowValue,
                ),
                TextWidget(
                  text:
                      '${_bookStateProvider!.getBookModel?.price} ${_bookStateProvider!.getBookModel?.currencyCode}',
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
          Container(
            child: BarcodeWidget(
              color: _themeProvider.currentTheme != ThemeData.light()
                  ? AppColors.white
                  : AppColors.black,
              barcode: Barcode.code128(),
              data: '${_bookStateProvider!.getBookModel?.isbn}',
            ),
          )
        ],
      ),
    );
  }

  _stars() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Center(
          child: Container(
        child: RatingBar(
          itemSize: 18,
          initialRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          ratingWidget: RatingWidget(
              half: Icon(Icons.star_half),
              full: Icon(Icons.star),
              empty: Icon(
                Icons.star_outline,
              )),
          itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
          onRatingUpdate: (rating) {},
        ),
      )),
    );
  }

  Widget _description(ThemeNotifier _themeProvider) {
    return Expanded(
      child: Scrollbar(
        thickness: 3,
        radius: Radius.circular(50),
        isAlwaysShown: true,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _themeProvider.currentTheme == ThemeData.light()
                  ? AppColors.white.withOpacity(0.6)
                  : AppColors.black.withOpacity(0.6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: "Description",
                      textStyle: TextStyle(
                              color: AppColors.kPrimary,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w600)
                          .normalStyle,
                      textAlign: TextAlign.left,
                    ),
                    GestureDetector(
                      onTap: () {
                        _addToBookMark();
                      },
                      child:
                          _bookStateProvider!.getSelectedBookModel!.isBookMark
                              ? Icon(
                                  Icons.bookmark,
                                  color: AppColors.kPrimary,
                                  size: 40,
                                )
                              : Icon(
                                  Icons.bookmark_outline,
                                  color: AppColors.kPrimary,
                                  size: 40,
                                ),
                    ),
                  ],
                ),
                TextWidget(
                  text: _bookStateProvider!.getBookModel?.description ?? "",
                  textStyle: TextStyle(
                    color: _themeProvider.currentTheme != ThemeData.light()
                        ? AppColors.white
                        : AppColors.black,
                    decoration: TextDecoration.none,
                  ).extraSmallStyle,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget quantityAndCartBtnWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: [
          Container(
            child: Expanded(
              flex: 1,
              child: HelperService.quantityWidget(
                  _bookStateProvider!.getQuantity, () {
                _bookStateProvider!.changeQuantity(1);
                print("increase");
              }, () {
                print("decrease");

                _bookStateProvider!.changeQuantity(-1);
              }, isTitle: false, buttonPaddingSize: 12),
            ),
          ),
          SizedBox(
            width: context.mediumValue,
          ),
          Expanded(
            flex: 1,
            child: CustomElevatedButton(
              isSmall: true,
              btnColor: AppColors.kPrimary,
              btnFunction: () {
                _addToCart();
              },
              text: "Add to Cart",
            ),
          )
        ],
      ),
    );
  }

  _addToCart() {
    if (_appStateProvider!.getToken != null) {
      _bookStateProvider!.addToCartList(
          _bookStateProvider!.getBookModel!, _bookStateProvider!.getQuantity);
    } else {
      showAlertDialog(context, "You must login first to add to cart.", () {
        Navigator.pop(context);
      });
    }
  }

  _addToBookMark() {
    if (_appStateProvider!.getToken != null) {
      _bookStateProvider!.setBookMarkList();
    } else {
      showAlertDialog(context, "You must login first to add to bookmark.", () {
        Navigator.pop(context);
      });
    }
  }

  _addToFav() {
    if (_appStateProvider!.getToken != null) {
      _bookStateProvider!.setFavList();
    } else {
      showAlertDialog(context, "You must login first to add to favorite.", () {
        Navigator.pop(context);
      });
    }
  }
}
