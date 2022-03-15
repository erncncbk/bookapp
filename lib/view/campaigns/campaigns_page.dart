import 'package:bookapp/core/components/animations/bottomAnimation.dart';
import 'package:bookapp/core/components/appbar/custom_app_two.dart';
import 'package:bookapp/core/components/scaffold/custom_scaffold.dart';
import 'package:bookapp/core/constants/app/app_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CampaignsPage extends StatelessWidget {
  const CampaignsPage({Key? key}) : super(key: key);

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
          title: "Campaigns",
          actionWidget: _actionWidget(),
        ),
        contentWidget: _body(_themeProvider),
        context: context);
  }

  Widget _body(ThemeNotifier _themeProvider) {
    return Column(
      children: [
        // SearchContainer(),

        // SearchBar(
        //   isEnable: false,
        //   searchFunction: () {
        //     navigation.navigateToPage(path: NavigationConstants.searchPage);
        //   },
        // ),

        __verticalDiscoverList(_themeProvider),
      ],
    );
  }

  Widget __verticalDiscoverList(ThemeNotifier _themeProvider) {
    return Expanded(
      child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 1,
          crossAxisSpacing: 0,
          mainAxisSpacing: 4.0,
          childAspectRatio: 2,
          children: List.generate(Constant.campaignsImages.length, (index) {
            return GestureDetector(
              onTap: () {},
              // child: _bookCard(_bookStateProvider, _themeProvider, index),
              child: WidgetAnimator(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(
                            Constant.campaignsImages[index],
                          ),
                          fit: BoxFit.contain,
                        )),
                  ),
                ),
              ),
            );
          })),
    );
  }

  Widget _actionWidget() {
    return IconButton(
        icon: Icon(Icons.more_horiz),
        onPressed: () => {print("xd")}).customIcon;
  }
}
