import 'package:bookapp/core/components/appbar/custom_app_two.dart';
import 'package:bookapp/core/components/scaffold/custom_scaffold.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
import 'package:bookapp/core/init/services/helper_service.dart';
import 'package:bookapp/view/order/empty_order.dart';
import 'package:bookapp/view/order/not_empty_order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  NavigationService navigation = NavigationService.instance;

  @override
  Widget build(BuildContext context) {
    BookStateProvider _bookStateProvider =
        Provider.of<BookStateProvider>(context);

    return CustomScaffold(
        appbarWidget: CustomAppBarTwo(
          title: "Orders",
          actionWidget: HelperService.moreHoriz(),
        ),
        contentWidget: _bookStateProvider.getOrderedItem == 0
            ? const EmptyOrder()
            : const NotEmptyOrder(),
        context: context);
  }
}
