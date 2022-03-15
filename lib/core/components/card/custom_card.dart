import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatefulWidget {
  const CustomCard(
      {Key? key,
      this.images,
      this.isFav = false,
      this.favFunction,
      this.selectFunction,
      this.addressName = "Maslak 42 Towers",
      this.adressDescription = "Maslak Mahallesi, Levent, İstanbul",
      this.scrollImage = false})
      : super(key: key);
  final List<String>? images;
  final bool? isFav;
  final VoidCallback? favFunction;
  final VoidCallback? selectFunction;
  final String? addressName;
  final String? adressDescription;
  final bool? scrollImage;

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  final CarouselController _controller = CarouselController();

  int _current = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.selectFunction!,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3250,
        width: MediaQuery.of(context).size.width * 0.917,
        child: Stack(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Positioned(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                                color: AppColors.grey.withOpacity(0.3),
                                height: MediaQuery.of(context).size.height *
                                    0.221875,
                                width:
                                    MediaQuery.of(context).size.width * 0.917,
                                child: CarouselSlider(
                                  carouselController: _controller,
                                  options: CarouselOptions(
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _current = index;
                                        });
                                      },
                                      enlargeStrategy:
                                          CenterPageEnlargeStrategy.scale,
                                      viewportFraction: 1,
                                      autoPlay: widget.scrollImage!,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3125),
                                  items: widget.images!.map((e) {
                                    return Builder(
                                        builder: (BuildContext context) {
                                      return Image.asset("assets/images/1.png",
                                          fit: BoxFit.contain,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.221875,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.917);
                                    });
                                  }).toList(),
                                )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.01,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              for (var x = 0; x < widget.images!.length; x++)
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                  width: MediaQuery.of(context).size.width *
                                      0.7248 /
                                      widget.images!.length,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(20),
                                      color: _current == x
                                          ? AppColors.kPrimary
                                          : Colors.white.withAlpha(80)),
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                    child: Column(
                      children: [
                        Center(
                          child: TextWidget(
                            text: widget.addressName,
                            textStyle: TextStyle(
                              color: AppColors.black,
                              decoration: TextDecoration.none,
                            ).smallStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextWidget(
                                  text: widget.adressDescription,
                                  textStyle: TextStyle(
                                    color: AppColors.black,
                                    decoration: TextDecoration.none,
                                  ).smallStyle,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.14),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width * 0.12,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: InkWell(
                    onTap: () {
                      print("Fav");
                    },
                    child: Icon(
                      Icons.star_outline_rounded,
                      size: 30,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
