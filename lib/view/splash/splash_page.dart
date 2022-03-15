import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/enums/app_theme_enum.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/extensions/context_extension.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:bookapp/core/init/services/storage_service.dart';
import 'package:bookapp/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final StorageService? _storageService = locator<StorageService>();
  final AppStateProvider? _appStateProvider = locator<AppStateProvider>();
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!.addObserver();
    checkReadOnlyAsync(context);
  }

  Future checkReadOnlyAsync(BuildContext context) async {
    ///Kullanıcı bilgilerini çeker. Sayfa açılışında istekte bulunur
    NavigationService navigation = NavigationService.instance;
    final _themeProvider = Provider.of<ThemeNotifier>(context, listen: false);

    // await _storageService!.setFirstOpenAsync(true);

    //Ek hizmet listesini çekme işlemi
    await _storageService!.getFirstOpenAsync().then((ress) async {
      if (ress!) {
        Future.delayed(const Duration(seconds: 1), () {
          navigation.navigateToPageClear(
            path: NavigationConstants.onBoardView,
          );
        });
      } else {
        await _storageService!.getTokenAsync().then((value) async {
          /// Set Token
          _appStateProvider!.setToken(value);
        });
        await _storageService!.getThemeAsync().then((value) async {
          /// Set Theme
          if (value == "dark") {
            _themeProvider.changeValue(AppThemes.DARK);
          } else {
            _themeProvider.changeValue(AppThemes.LIGHT);
          }
        });

        Future.delayed(const Duration(seconds: 1), () {
          navigation.navigateToPageClear(
            path: NavigationConstants.homeView,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kSecondary,
      body: Container(
        padding: context.paddingZero,
        width: context.width,
        height: context.height,
        // color: AppColors.wasabi,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("splash".toPng), fit: BoxFit.cover)),
      ),
    );
  }
}
