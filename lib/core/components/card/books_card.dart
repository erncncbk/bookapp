import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/app/app_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BooksCard extends StatefulWidget {
  const BooksCard(
      {Key? key,
      this.index,
      this.price,
      this.title = "",
      this.currencyCode,
      this.height = 400,
      this.width = 240,
      this.imgHeight = 130,
      this.imgWidth = 130})
      : super(key: key);

  final int? index;
  final String? price;
  final String? title;
  final String? currencyCode;
  final double? height;
  final double? width;
  final double? imgHeight;
  final double? imgWidth;

  @override
  State<BooksCard> createState() => _BooksCardState();
}

class _BooksCardState extends State<BooksCard> {
  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeNotifier>(context);

    return Stack(
      children: [
        Container(
          height: widget.height,
          width: widget.width,
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.023,
              right: MediaQuery.of(context).size.width * 0.023),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // if you need this
              side: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.width * 0.047),
              child: Column(
                children: [
                  Hero(
                    tag: "img${widget.index}",
                    child: Container(
                      height: widget.imgHeight,
                      width: widget.imgWidth,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            image: AssetImage(
                              Constant.book_images[widget.index!],
                            ),
                            fit: BoxFit.contain,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Expanded(
                    child: TextWidget(
                      text: widget.title,
                      textStyle: TextStyle(
                              color: _themeProvider.currentTheme !=
                                      ThemeData.light()
                                  ? AppColors.white
                                  : AppColors.black,
                              decoration: TextDecoration.none,
                              overflow: TextOverflow.ellipsis)
                          .smallStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 10,
            left: 30,
            child: TextWidget(
              text: '${widget.price} ${widget.currencyCode}',
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
}
