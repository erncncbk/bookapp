import 'package:bookapp/core/components/appbar/custom_app_two.dart';
import 'package:bookapp/core/components/scaffold/custom_scaffold.dart';
import 'package:bookapp/core/components/search/search_bar.dart';
import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/app/app_constants.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
import 'package:bookapp/core/init/services/helper_service.dart';
import 'package:bookapp/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  BookStateProvider? _bookStateProvider = locator<BookStateProvider>();
  NavigationService navigation = NavigationService.instance;
  TextEditingController? _textController = TextEditingController();
  FocusNode? __textControllerFocus;

  void _searchTextFunc(String query) {
    _bookStateProvider!.findSearchBooks(query);
  }

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    __textControllerFocus = FocusNode();
  }

  @override
  void dispose() {
    _bookStateProvider!.clearSearchedBooks(isNotifier: false);
    __textControllerFocus!.dispose();
    _textController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bookStateProvider = Provider.of<BookStateProvider>(context);
    final _themeProvider = Provider.of<ThemeNotifier>(context);

    return CustomScaffold(
        appbarWidget: CustomAppBarTwo(
          title: "Search Book",
          actionWidget: _actionWidget(),
        ),
        contentWidget: _body(_themeProvider),
        isAsyncCall: false,
        context: context);
    // return Scaffold(
    //     body: Container(
    //   child: SearchBar(),
    // ));
  }

  Widget _body(ThemeNotifier _themeProvider) {
    return Column(
      children: [
        SearchBar(
          autoFocus: true,
          controller: _textController,
          focusNode: __textControllerFocus,
          onChanged: (value) => {_searchTextFunc(value)},
          isEnable: true,
          // suffixIcon: Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     GestureDetector(
          //       child: Icon(Icons.settings_overscan_rounded),
          //       onTap: () async {
          //         String barcodeScanRes =
          //             await FlutterBarcodeScanner.scanBarcode(
          //                 "#ff6666", "Cancel", false, ScanMode.BARCODE);
          //         print(barcodeScanRes.toString());
          //       },
          //     ),

          //   ],
          // ),
          suffixIcon: GestureDetector(
              child: Icon(
                Icons.clear,
                color: _themeProvider.currentTheme != ThemeData.light()
                    ? AppColors.white
                    : AppColors.black,
              ),
              onTap: () {
                _textController!.clear();
                _searchTextFunc(_textController!.text);
                /* Clear the search field */
              }),
        ),
        _searchedBooks(_bookStateProvider!, _themeProvider),
      ],
    );
  }

  Widget _searchedBooks(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bookStateProvider.getSearchedBooks?.isNotEmpty ?? false
                ? TextWidget(
                    text: "Books",
                    textStyle: TextStyle(
                            color:
                                _themeProvider.currentTheme != ThemeData.light()
                                    ? AppColors.white
                                    : AppColors.black,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w500)
                        .smallStyle,
                    textAlign: TextAlign.left,
                  )
                : SizedBox(),
            _bookStateProvider.getSearchedBooks?.isNotEmpty ?? false
                ? Container(
                    child: ListView.builder(
                      // scrollDirection: Axis.vertial,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _bookStateProvider.getSearchedBooks?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // if you need this
                            side: BorderSide(
                              color: AppColors.grey.withOpacity(0.8),
                              width: 1,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              _bookStateProvider.setSelectedBookId(
                                  _bookStateProvider
                                      .getSearchedBooks![index].id);
                              navigation.navigateToPage(
                                path: NavigationConstants.bookDetail,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            Constant.book_images[index],
                                          ),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: RichText(
                                        text: TextSpan(
                                          children: HelperService
                                              .highlightOccurrences(
                                                  _bookStateProvider
                                                      .getSearchedBooks?[index]
                                                      .title!,
                                                  _textController!.text),
                                          style: TextStyle(
                                            color:
                                                _themeProvider.currentTheme !=
                                                        ThemeData.light()
                                                    ? AppColors.white
                                                    : AppColors.black,
                                          ).extraSmallStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _actionWidget() {
    return IconButton(
            icon: Icon(
              Icons.more_horiz,
            ),
            onPressed: () {})
        .customIcon;
  }
}
