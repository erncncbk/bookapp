import 'package:bookapp/core/components/slider/custom_carousel_card.dart';
import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/app/app_constants.dart';
import 'package:bookapp/core/constants/models/book_model.dart';
import 'package:bookapp/core/extensions/context_extension.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotEmptyOrder extends StatefulWidget {
  const NotEmptyOrder({Key? key}) : super(key: key);

  @override
  State<NotEmptyOrder> createState() => _NotEmptyOrderState();
}

class _NotEmptyOrderState extends State<NotEmptyOrder> {
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

    return _notEmptyOrder(_bookStateProvider, _themeProvider);
  }

  Widget _notEmptyOrder(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: TextWidget(
              text: "Order History",
              textStyle: TextStyle(
                color: _themeProvider.currentTheme != ThemeData.light()
                    ? AppColors.white
                    : AppColors.black,
                decoration: TextDecoration.none,
              ).normalStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextWidget(
              text: "${_bookStateProvider.getOrderBookList.length} Order ",
              textStyle: TextStyle(
                color: AppColors.kPrimary,
                decoration: TextDecoration.none,
              ).normalStyle,
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
        itemCount: _bookStateProvider.getOrderBookList.length,
        itemBuilder: (context, index, _) {
          var value = _bookStateProvider.getOrderBookList[index];
          return Stack(
            children: [
              Container(
                height: 500,
                padding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(10),
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
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: value.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                child: _orderList(_bookStateProvider, value,
                                    index, _themeProvider),
                              );
                            }),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: TextWidget(
                          text:
                              "TOTAL: ${_bookStateProvider.getSubtotalList[index]}",
                          textStyle: TextStyle(
                            color:
                                _themeProvider.currentTheme != ThemeData.light()
                                    ? AppColors.white
                                    : AppColors.black,
                            decoration: TextDecoration.none,
                          ).normalStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                          x < _bookStateProvider.getOrderBookList.length;
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
          height: MediaQuery.of(context).size.height * 0.5,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          onPageChanged: ((index, reason) {
            setState(() {
              _current = index;
            });
          }),
          scrollDirection: Axis.horizontal,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          viewportFraction: 0.9,
          autoPlay: false,
        ));
  }

  Widget _orderList(
      BookStateProvider _bookStateProvider,
      Map<BookModel?, int?>? orderList,
      int index,
      ThemeNotifier _themeProvider) {
    BookModel? value = orderList!.keys.elementAt(index);
    int? quantity = orderList.values.elementAt(index);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
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
                          Constant.book_images[int.parse(
                                  value!.id.toString().replaceAll('0', "")) -
                              1],
                        ),
                        fit: BoxFit.contain,
                      )),
                ),
              ),
            ),
            SizedBox(
              width: context.mediumValue,
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextWidget(
                    text: "${value.title}",
                    textAlign: TextAlign.right,
                    textStyle: TextStyle(
                      color: _themeProvider.currentTheme != ThemeData.light()
                          ? AppColors.white
                          : AppColors.black,
                      decoration: TextDecoration.none,
                    ).extraSmallStyle,
                  ),
                  TextWidget(
                    text: "$quantity x ${value.price}",
                    textAlign: TextAlign.right,
                    textStyle: TextStyle(
                      color: AppColors.kPrimary,
                      decoration: TextDecoration.none,
                    ).extraSmallStyle,
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
