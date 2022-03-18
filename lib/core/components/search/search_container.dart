import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
import 'package:bookapp/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

class SearchContainer extends StatefulWidget {
  const SearchContainer({Key? key}) : super(key: key);

  @override
  State<SearchContainer> createState() => _SearchContainerState();
}

class _SearchContainerState extends State<SearchContainer> {
  NavigationService navigation = NavigationService.instance;
  BookStateProvider? _bookStateProvider = locator<BookStateProvider>();

  @override
  Widget build(BuildContext context) {
    _bookStateProvider = Provider.of<BookStateProvider>(context);

    final _themeProvider = Provider.of<ThemeNotifier>(context);
    Color themeColor = _themeProvider.currentTheme != ThemeData.light()
        ? AppColors.white
        : AppColors.black;
    return Container(
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: themeColor,
              width: .5,
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Icon(Icons.search, color: themeColor),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      navigation.navigateToPage(
                          path: NavigationConstants.searchPage);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: SizedBox(
                        height: 16,
                        width: double.infinity,
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: TextWidget(
                            text: "Search...",
                            textStyle:
                                TextStyle(color: themeColor).extraSmallStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.settings_overscan_rounded,
                          size: 26,
                        ),
                        onTap: () async {
                          String barcodeScanRes =
                              await FlutterBarcodeScanner.scanBarcode(
                                  "#ff6666", "Cancel", false, ScanMode.DEFAULT);
                          _bookStateProvider!.checkBarcodExist(
                            barcodeScanRes.toString(),
                          );
                          if (_bookStateProvider!.getIsBarcodExist) {
                            if (_bookStateProvider!.getSelectedBookId != null) {
                              navigation.navigateToPage(
                                  path: NavigationConstants.bookDetail);
                            }
                            print(barcodeScanRes.toString());
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
