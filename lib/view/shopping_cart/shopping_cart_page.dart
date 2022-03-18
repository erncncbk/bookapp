import 'package:bookapp/core/components/appbar/custom_app_bar.dart';
import 'package:bookapp/core/components/appbar/custom_app_two.dart';
import 'package:bookapp/core/components/bottomnavbar/custom_bottom_navigation_bar.dart';
import 'package:bookapp/core/components/scaffold/custom_scaffold.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
import 'package:bookapp/view/shopping_cart/empty_cart.dart';
import 'package:bookapp/view/shopping_cart/not_empty_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  NavigationService navigation = NavigationService.instance;

  @override
  Widget build(BuildContext context) {
    BookStateProvider _bookStateProvider =
        Provider.of<BookStateProvider>(context);
    AppStateProvider _appStateProvider = Provider.of<AppStateProvider>(context);

    _appStateProvider.setSelectedBottomIndex(3, isNotifier: false);

    return CustomScaffold(
        appbarWidget: CustomAppBarTwo(
          title: "Shopping Cart",
          actionWidget: _actionWidget(),
        ),
        contentWidget: _bookStateProvider.getCartItem == 0
            ? const EmptyCart()
            : const NotEmptyCart(),
        bottomNavigatorBar: CustomBottomNavigationBar(),
        context: context);
  }

  Widget _actionWidget() {
    return IconButton(
        icon: Icon(Icons.more_horiz),
        onPressed: () => {print("xd")}).customIcon;
  }
}
