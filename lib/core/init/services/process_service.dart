///Birden fazla sayfalarda aynı işlemler tekrar tekrar yapılmaması adına
///tüm API'ye giden istekler tek borudan geçirilmesi için bu service oluşturuldu.

import 'dart:io';

import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:bookapp/core/init/services/permission_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../locator.dart';

///Birden fazla sayfalarda aynı işlemler tekrar tekrar yapılmaması adına
///tüm API'ye giden istekler tek borudan geçirilmesi için bu service oluşturuldu.
class ProcessService {
  final PermissionService _permissionService = locator<PermissionService>();

  ///Tüm API methodları bu boru(metod) üzerinden istekte bulunacaklar
  ///Loader'in durumunu günceller
  ///İzin kontrollerini yapar
  ///Hata kontrollerini yapar
  ///Loglama yapar
  Future<bool> getRepositoryAsync(
      {required BuildContext context,
      required Function function,
      AppStateProvider? appStateProvider,
      bool isNotifier = true,
      bool setLoader = true}) async {
    AppStateProvider _appStateProvider =
        appStateProvider ?? locator<AppStateProvider>();

    try {
      if (setLoader) {
        _appStateProvider.setIsProgressIndicatorVisible(true,
            isNotifier: isNotifier);
      }

      //*İzinleri kontorl et
      await _checkPermissionAsync(context);

      //*İstek at
      bool result = await function();
      print("Result:" + result.toString());

      if ((!result)) {
        String? erro = _appStateProvider.errorMessage!;

        showDialogw(context, erro);
        _appStateProvider.setIsProgressIndicatorVisible(false);

        return false;
      }

      if (!result) {
        // WidgetService.flushBarErrorWidget(context,
        //     title: "Error", description: _appStateProvider.errorMessage);
        _appStateProvider.setIsProgressIndicatorVisible(false);

        return false;
      }

      return result;
    } catch (e) {
      print(' ProcessService. metodunda hata oluştu. Hata: ${e.toString()}');
      return false;
    } finally {
      //*Loader'i kapat
      _appStateProvider.setIsProgressIndicatorVisible(false);
    }
  }

  ///Tüm izinlerin kontrol edildiği yer
  Future<void> _checkPermissionAsync(BuildContext context) async {
    // gps kontrolü yapar
    // await checkGps(context);
    await _permissionService.isConnected().then(
      (onValue) {
        if (!onValue) {
          // WidgetService.flushBarErrorWidget(context,
          //     title: "Connection Error",
          //     description: "Check Your Internet Connection");
        }
      },
      onError: (error) {
        print('İzinler kontrol edilirken hata oluştu. Hata: $error');
      },
    );
  }

  void showDialogw(BuildContext context, String? title) {
    showCupertinoDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
            insetAnimationCurve: Curves.easeInBack, title: Text("$title")
            // content: const Text("Are you sure you want to delete the file?"),
            );
      },
    );
  }
}
