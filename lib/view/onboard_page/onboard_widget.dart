import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardWidget extends StatefulWidget {
  const OnboardWidget(
      {Key? key, this.imagePath = "", this.title = "", this.description = ""})
      : super(key: key);
  final String imagePath;
  final String title;
  final String description;

  @override
  _OnboardWidgetState createState() => _OnboardWidgetState();
}

class _OnboardWidgetState extends State<OnboardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 10,
              right: MediaQuery.of(context).size.width / 10),
          child: SvgPicture.asset(
            widget.imagePath.toSVG,
            height: MediaQuery.of(context).size.height / 2.5,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 15,
        ),
        TextWidget(
          text: widget.title,
          textStyle: TextStyle(
            color: AppColors.kPrimary,
            decoration: TextDecoration.none,
          ).normalStyle,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 30,
        ),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 8,
              right: MediaQuery.of(context).size.width / 8),
          child: Container(
            alignment: Alignment.center,
            child: TextWidget(
              text: widget.description,
              textStyle: TextStyle(
                color: AppColors.grey,
                decoration: TextDecoration.none,
              ).extraSmallStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
