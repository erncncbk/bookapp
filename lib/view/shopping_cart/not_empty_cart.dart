import 'package:bookapp/core/components/alert/alert_dialog.dart';
import 'package:bookapp/core/components/buttons/custom_elevated_button.dart';
import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/app/app_constants.dart';
import 'package:bookapp/core/constants/models/book_model.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
import 'package:bookapp/core/init/services/helper_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotEmptyCart extends StatefulWidget {
  const NotEmptyCart({Key? key}) : super(key: key);

  @override
  State<NotEmptyCart> createState() => _NotEmptyCartState();
}

class _NotEmptyCartState extends State<NotEmptyCart> {
  NavigationService navigation = NavigationService.instance;

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
    _bookStateProvider.findFavItems(isNotifier: false);

    return _notEmptyCart(_bookStateProvider, _themeProvider);
  }

  Widget _notEmptyCart(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: TextWidget(
                text:
                    "Cart ( ${_bookStateProvider.getCartBookMap.length} Item ) ",
                textStyle: TextStyle(
                  color: _themeProvider.currentTheme != ThemeData.light()
                      ? AppColors.white
                      : AppColors.black,
                  decoration: TextDecoration.none,
                ).normalStyle,
                textAlign: TextAlign.left,
              ),
            ),
            _cartList(_bookStateProvider, _themeProvider),
            SizedBox(
              height: 20,
            ),
            _orderSummary(_bookStateProvider, _themeProvider),
          ],
        ),
      ),
    );
  }

  Widget _cartList(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return ListView.builder(
        itemCount: _bookStateProvider.getCartBookMap.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          BookModel value =
              _bookStateProvider.getCartBookMap.keys.elementAt(index);
          int? quantity =
              _bookStateProvider.getCartBookMap.values.elementAt(index);
          return Container(
            padding: EdgeInsets.all(10),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag:
                          "img${int.parse(value.id.toString().replaceAll('0', "")) - 1}",
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
                                Constant.book_images[int.parse(value.id
                                        .toString()
                                        .replaceAll('0', "")) -
                                    1],
                              ),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        //Title
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: TextWidget(
                                      text: value.title,
                                      textStyle: TextStyle(
                                        color: _themeProvider.currentTheme !=
                                                ThemeData.light()
                                            ? AppColors.white
                                            : AppColors.black,
                                        decoration: TextDecoration.none,
                                      ).smallStyle,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  //Author
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: TextWidget(
                                      text: "by ${value.author}",
                                      textStyle: TextStyle(
                                        color: AppColors.kPrimary,
                                        decoration: TextDecoration.none,
                                      ).extraSmallStyle,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundColor: AppColors.white,
                                    foregroundColor: AppColors.grey,
                                    child: Container(
                                      child: GestureDetector(
                                          onTap: () {
                                            _bookStateProvider
                                                .setSelectedBookId(value.id);
                                            _bookStateProvider.setFavList();
                                          },
                                          child: _bookStateProvider
                                                  .getFavBookList.isNotEmpty
                                              ? value.isFav!
                                                  ? Icon(
                                                      Icons.favorite,
                                                      size: 20,
                                                      color: AppColors.kPrimary,
                                                    )
                                                  : const Icon(
                                                      Icons
                                                          .favorite_border_outlined,
                                                      size: 20,
                                                    )
                                              : const Icon(
                                                  Icons
                                                      .favorite_border_outlined,
                                                  size: 20,
                                                )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CircleAvatar(
                                    foregroundColor: AppColors.grey,
                                    radius: 14,
                                    backgroundColor: AppColors.white,
                                    child: Container(
                                      child: GestureDetector(
                                        onTap: () {
                                          print("Secili Urun Silindi");
                                          _bookStateProvider.removeList(value);
                                          showAlertDialogNoButton(context,
                                              "Selected book removed from cart");
                                        },
                                        child: Icon(
                                          Icons.delete_outline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Counter
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              height: 40,
                              child:
                                  HelperService.quantityWidget(quantity!, () {
                                _bookStateProvider.increaseSubtotal(value, 1);

                                ///Update must last
                                _bookStateProvider
                                    .updateCartBookQuantitiyFromMap(
                                        value, quantity + 1);
                                _bookStateProvider.changeQuantity(1);
                                _bookStateProvider.changeCartItem(1);
                                print("increase");
                              }, () {
                                print("decrease");

                                _bookStateProvider.decreaseSubtotal(value, -1);

                                _bookStateProvider
                                    .updateCartBookQuantitiyFromMap(
                                        value, quantity - 1);
                                if (quantity > 1) {
                                  _bookStateProvider.changeQuantity(-1);
                                  _bookStateProvider.changeCartItem(-1);
                                }

                                ///Update must last
                              }, isTitle: false, buttonPaddingSize: 12),
                            ),

                            //Price
                            TextWidget(
                              text: '${value.price} ${value.currencyCode}',
                              textStyle: TextStyle(
                                color: AppColors.kPrimary,
                                decoration: TextDecoration.none,
                              ).smallStyle,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          );
        });
  }

  Widget _orderSummary(
      BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(10),
          // color: _themeProvider.currentTheme != ThemeData.light()
          //     ? AppColors.white.withOpacity(0.13)
          //     : AppColors.grey.withOpacity(0.13),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: "Order Summary",
              textStyle: TextStyle(
                color: _themeProvider.currentTheme != ThemeData.light()
                    ? AppColors.white
                    : AppColors.black,
                decoration: TextDecoration.none,
              ).normalStyle,
              textAlign: TextAlign.left,
            ),
            TextWidget(
              text: "${_bookStateProvider.getCartBookMap.length} Item",
              textStyle: TextStyle(
                color: _themeProvider.currentTheme != ThemeData.light()
                    ? AppColors.white.withOpacity(0.5)
                    : AppColors.grey.withOpacity(0.5),
                decoration: TextDecoration.none,
              ).extraSmallStyle,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: "Subtotal",
                  textStyle: TextStyle(
                    color: _themeProvider.currentTheme != ThemeData.light()
                        ? AppColors.white
                        : AppColors.black,
                    decoration: TextDecoration.none,
                  ).smallStyle,
                  textAlign: TextAlign.left,
                ),
                TextWidget(
                  text: "${_bookStateProvider.getSubtotal}",
                  textStyle: TextStyle(
                    color: AppColors.kPrimary,
                    decoration: TextDecoration.none,
                  ).smallStyle,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: CustomElevatedButton(
                btnColor: AppColors.kPrimary,
                btnFunction: () {
                  showAlertDialogWOptions(
                      context, "Oooooo", "Do you want to add buy items", () {
                    _bookStateProvider
                        .addToOrderList(_bookStateProvider.getCartBookMap);
                    Navigator.pop(context);
                  });
                },
                text: "Buy",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
