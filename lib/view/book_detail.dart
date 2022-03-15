import 'package:barcode_widget/barcode_widget.dart';
import 'package:bookapp/core/components/appbar/custom_app_two.dart';
import 'package:bookapp/core/components/scaffold/custom_scaffold.dart';
import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
import 'package:bookapp/core/init/services/process_service.dart';
import 'package:bookapp/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetail extends StatefulWidget {
  const BookDetail({Key? key}) : super(key: key);

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  final ProcessService? _processService = locator<ProcessService>();
  AppStateProvider? _appStateProvider = locator<AppStateProvider>();
  BookStateProvider? _bookStateProvider = locator<BookStateProvider>();
  var num;

  @override
  void initState() {
    // getListTherapistClientMatch();

    super.initState();

    main();
  }

  @override
  void dispose() {
    _bookStateProvider!.setBookModel(null, isNotifier: false);
    _bookStateProvider!.setSelectedBookId(null, isNotifier: false);

    super.dispose();
  }

  Future main() async {
    await getBookAsync();
    num = _bookStateProvider!.getSelectedBookId.toString().replaceAll('0', "");
  }

  Future getBookAsync() async {
    await _processService!.getRepositoryAsync(
        context: context,
        function: () async => await _bookStateProvider!.getBook(),
        setLoader: true,
        isNotifier: true);
  }

  @override
  Widget build(BuildContext context) {
    _bookStateProvider = Provider.of<BookStateProvider>(context);
    final _themeProvider = Provider.of<ThemeNotifier>(context);
    // return Scaffold(
    //   body: _bookStateProvider?.getBookListModel?.isNotEmpty ?? false
    //       ? _body(_bookStateProvider!, _themeProvider)
    //       : SizedBox(),
    // );

    return CustomScaffold(
        height: 40,
        appbarWidget: _bookStateProvider?.getBookModel != null
            ? CustomAppBarTwo(
                title: "Book Detail",
                actionWidget: _actionWidget(),
              )
            : SizedBox(),
        contentWidget: _bookStateProvider?.getBookModel != null
            ? _body(_bookStateProvider!, _themeProvider)
            : SizedBox(),
        isAsyncCall: _appStateProvider!.isProgressIndicatorVisible,
        context: context);
  }

  Widget _body(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Center(
          child: Container(
            width: 250,
            height: 350,
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
                padding: EdgeInsets.all(15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: "img${int.parse(num) - 1}",
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        isAntiAlias: true,
                        opacity:
                            _themeProvider.currentTheme == ThemeData.light()
                                ? 1
                                : 0.8,
                        scale: 1,
                        image: AssetImage(
                          "assets/images/$num.png",
                        ),
                        fit: BoxFit.cover,
                      )),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
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
        SizedBox(
          height: 20,
        ),
        Container(
          width: width * 0.9,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _themeProvider.currentTheme == ThemeData.light()
                ? AppColors.grey.withOpacity(0.1)
                : AppColors.grey.withOpacity(0.6),
          ),
          padding: EdgeInsets.symmetric(horizontal: 40),
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
                              color: _themeProvider.currentTheme !=
                                      ThemeData.light()
                                  ? AppColors.white
                                  : AppColors.black,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w800)
                          .smallStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      text:
                          '${_bookStateProvider.getBookModel?.price} ${_bookStateProvider.getBookModel?.currencyCode}',
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
              // Container(
              //   width: 140,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Container(
              //         height: 20,
              //         decoration: BoxDecoration(
              //             color: AppColors.white,
              //             image: DecorationImage(
              //               scale: 1,
              //               image: AssetImage(
              //                 "assets/images/isbn.png",
              //               ),
              //               fit: BoxFit.cover,
              //             )),
              //       ),
              //       SizedBox(
              //         height: 5,
              //       ),
              //       FittedBox(
              //         child: TextWidget(
              //           text:
              //               '${_bookStateProvider.getBookModel?.price} ${_bookStateProvider.getBookModel?.isbn}',
              //           textStyle: TextStyle(
              //             color:
              //                 _themeProvider.currentTheme != ThemeData.light()
              //                     ? AppColors.white
              //                     : AppColors.black,
              //             decoration: TextDecoration.none,
              //           ).smallStyle,
              //           textAlign: TextAlign.center,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                padding: EdgeInsets.all(8),
                child: BarcodeWidget(
                  color: _themeProvider.currentTheme != ThemeData.light()
                      ? AppColors.white
                      : AppColors.black,
                  barcode: Barcode.code128(),
                  data: '${_bookStateProvider.getBookModel?.isbn}',
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Scrollbar(
            thickness: 3,
            radius: Radius.circular(50),
            isAlwaysShown: true,
            child: SingleChildScrollView(
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
                        Container(
                          child: IconButton(
                            icon: _bookStateProvider.getBookModel!.isBookMark!
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
                            onPressed: () {
                              print("ok");
                              _bookStateProvider
                                  .setBookMark(_bookStateProvider.getBookModel);
                            },
                          ),
                        ),
                      ],
                    ),
                    TextWidget(
                      text: _bookStateProvider.getBookModel?.description ?? "",
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
        )
      ],
    );
  }

  Widget _actionWidget() {
    return IconButton(
        icon: Icon(Icons.more_horiz),
        onPressed: () => {print("xd")}).customIcon;
  }
}
