import 'package:bookapp/core/components/animations/bottomAnimation.dart';
import 'package:bookapp/core/components/appbar/custom_app_two.dart';
import 'package:bookapp/core/components/scaffold/custom_scaffold.dart';
import 'package:bookapp/core/constants/app/app_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GiftCard extends StatelessWidget {
  const GiftCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeNotifier>(context);
    // return Scaffold(
    //   body: _bookStateProvider?.getBookListModel?.isNotEmpty ?? false
    //       ? _body(_bookStateProvider!, _themeProvider)
    //       : SizedBox(),
    // );

    return CustomScaffold(
        appbarWidget: CustomAppBarTwo(
          title: "Gift Card",
          actionWidget: _actionWidget(),
        ),
        contentWidget: _body(_themeProvider),
        context: context);
  }

  Widget _body(ThemeNotifier _themeProvider) {
    return SingleChildScrollView(
      child: _giftCard(),
    );
  }

  Widget _giftCard() {
    return WidgetAnimator(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                scale: 1,
                image: AssetImage(
                  Constant.giftCard.first,
                ),
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }

  Widget _actionWidget() {
    return IconButton(
        icon: Icon(Icons.more_horiz),
        onPressed: () => {print("xd")}).customIcon;
  }
}
