import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/app/app_constants.dart';
import 'package:bookapp/core/constants/models/book_model.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotEmptyBookmark extends StatefulWidget {
  const NotEmptyBookmark({Key? key}) : super(key: key);

  @override
  State<NotEmptyBookmark> createState() => _NotEmptyBookmarkState();
}

class _NotEmptyBookmarkState extends State<NotEmptyBookmark> {
  NavigationService navigation = NavigationService.instance;
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BookStateProvider _bookStateProvider =
        Provider.of<BookStateProvider>(context);
    final _themeProvider = Provider.of<ThemeNotifier>(context);

    return _notEmptyBookmark(_bookStateProvider, _themeProvider);
  }

  Widget _notEmptyBookmark(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: TextWidget(
              text: "Bookmark ( ${_bookStateProvider.getBookMarkCount} Book ) ",
              textStyle: TextStyle(
                color: _themeProvider.currentTheme != ThemeData.light()
                    ? AppColors.white
                    : AppColors.black,
                decoration: TextDecoration.none,
              ).normalStyle,
              textAlign: TextAlign.left,
            ),
          ),
          // Container(
          //   child: BookmarksCarousel(
          //       bookmarkWidgets: SingleChildScrollView(
          //           child: _bookmarkList(_bookStateProvider, _themeProvider))),
          // ),
          _carousel(_bookStateProvider, _themeProvider)
        ],
      ),
    );
  }

  Widget _carousel(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return CarouselSlider.builder(
        carouselController: _controller,
        itemCount: _bookStateProvider.getBookMarkList.length,
        itemBuilder: (context, index, _) {
          BookModel value = _bookStateProvider.getBookMarkList[index];

          return Stack(
            children: [
              _bookmarkList(_bookStateProvider, value, _themeProvider),
              Positioned(
                bottom: 0,
                right: 40,
                left: 40,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (var x = 0;
                          x < _bookStateProvider.getBookMarkList.length;
                          x++)
                        Container(
                          height: MediaQuery.of(context).size.height * 0.01,
                          width: MediaQuery.of(context).size.width *
                              0.7248 /
                              Constant.images.length,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              color: _current == x
                                  ? AppColors.kPrimary
                                  : _themeProvider.currentTheme !=
                                          ThemeData.light()
                                      ? AppColors.white.withAlpha(40)
                                      : AppColors.grey.withAlpha(40)),
                        )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        options: CarouselOptions(
          enableInfiniteScroll: false,
          onPageChanged: ((index, reason) {
            setState(() {
              _current = index;
            });
          }),
          height: MediaQuery.of(context).size.height * 0.8,
          scrollDirection: Axis.horizontal,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          viewportFraction: 1,
          autoPlay: false,
        ));
  }

  Widget _bookmarkList(BookStateProvider _bookStateProvider, BookModel value,
      ThemeNotifier _themeProvider) {
    return Container(
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
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                child: Hero(
                  transitionOnUserGestures: true,
                  tag:
                      "img${int.parse(value.id.toString().replaceAll('0', "")) - 1}",
                  child: Container(
                    height: 150,
                    width: 120,
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
                            Constant.book_images[int.parse(
                                    value.id.toString().replaceAll('0', "")) -
                                1],
                          ),
                          fit: BoxFit.contain,
                        )),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: TextWidget(
                              text: "Description",
                              textStyle: TextStyle(
                                color: AppColors.kPrimary,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none,
                              ).normalStyle,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _bookStateProvider.setBookModel(value);
                              _bookStateProvider.setBookMarkList();
                            },
                            child: value.isBookMark
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
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: TextWidget(
                          text: "${value.description}",
                          textStyle: TextStyle(
                            color:
                                _themeProvider.currentTheme != ThemeData.light()
                                    ? AppColors.white
                                    : AppColors.black,
                            decoration: TextDecoration.none,
                          ).extraSmallStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      //Author
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: TextWidget(
                          text: "by ${value.author}",
                          textStyle: TextStyle(
                            color: AppColors.kPrimary,
                            decoration: TextDecoration.none,
                          ).extraSmallStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
