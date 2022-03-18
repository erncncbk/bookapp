import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/app/app_constants.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomCarouselCard extends StatefulWidget {
  const CustomCarouselCard({
    Key? key,
  }) : super(key: key);

  @override
  _CustomCarouselCardState createState() => _CustomCarouselCardState();
}

class _CustomCarouselCardState extends State<CustomCarouselCard> {
  int _current = 0;
  List<int> items = [1, 2, 3];
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeNotifier>(context);

    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.917,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                    enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    viewportFraction: 1,
                    autoPlay: true,
                    height: MediaQuery.of(context).size.height),
                items: Constant.images.map((e) {
                  return Builder(builder: (BuildContext context) {
                    return Image.asset(e,
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width * 0.987);
                  });
                }).toList(),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (var x = 0; x < Constant.images.length; x++)
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
            ],
          ),
        ),
      ],
    );
  }
}
