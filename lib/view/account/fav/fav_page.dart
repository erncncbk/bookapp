import 'package:bookapp/core/components/appbar/custom_app_bar.dart';
import 'package:bookapp/core/components/appbar/custom_app_two.dart';
import 'package:bookapp/core/components/bottomnavbar/custom_bottom_navigation_bar.dart';
import 'package:bookapp/core/components/scaffold/custom_scaffold.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
import 'package:bookapp/view/account/fav/empty_fav.dart';
import 'package:bookapp/view/account/fav/not_empty_fav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavPage extends StatefulWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  NavigationService navigation = NavigationService.instance;

  @override
  Widget build(BuildContext context) {
    BookStateProvider _bookStateProvider =
        Provider.of<BookStateProvider>(context);
    AppStateProvider _appStateProvider = Provider.of<AppStateProvider>(context);

    _appStateProvider.setSelectedBottomIndex(2, isNotifier: false);
    return CustomScaffold(
        isAsyncCall: _appStateProvider.isProgressIndicatorVisible,
        appbarWidget: CustomAppBarTwo(
          title: "Favorites",
          actionWidget: _actionWidget(),
        ),
        contentWidget: _bookStateProvider.getFavCount == 0
            ? const EmptyFav()
            : NotEmptyFav(),
        bottomNavigatorBar: CustomBottomNavigationBar(),
        context: context);
  }

  Widget _actionWidget() {
    return IconButton(
        icon: Icon(Icons.more_horiz),
        onPressed: () => {print("xd")}).customIcon;
  }
}
