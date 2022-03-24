///Birden fazla sayfalarda aynı işlemler tekrar tekrar yapılmaması adına
///tüm API'ye giden istekler tek borudan geçirilmesi için bu service oluşturuldu.
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:bookapp/core/init/services/helper_service.dart';
import 'package:bookapp/core/init/services/permission_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../locator.dart';

///Birden fazla sayfalarda aynı işlemler tekrar tekrar yapılmaması adına
///tüm API'ye giden istekler tek borudan geçirilmesi için bu service oluşturuldu.
class ProcessService {
  final PermissionService _permissionService = locator<PermissionService>();
  final AppStateProvider _appStateProvider = locator<AppStateProvider>();

  ///Tüm API methodları bu boru(metod) üzerinden istekte bulunacaklar
  ///Loader'in durumunu günceller
  ///İzin kontrollerini yapar
  ///Hata kontrollerini yapar
  ///Loglama yapar
  Future<bool> getRepositoryAsync(
      {required BuildContext context, required Function function}) async {
    bool result = false;
    try {
      _appStateProvider.setIsProgressIndicatorVisible(true, isNotifier: true);

      //*İzinleri kontorl et
      bool isConnected = await checkConnectionAsync(context);
      if (isConnected) {
//*İstek at
        result = await function();

        print("Result:" + result.toString());
      } else {
        _appStateProvider.setIsProgressIndicatorVisible(
          false,
        );
      }

      return result;
    } catch (e) {
      print(' ProcessService. metodunda hata oluştu. Hata: ${e.toString()}');
      return false;
    } finally {
      //*Loader'i kapat
      _appStateProvider.setIsProgressIndicatorVisible(
        false,
      );
    }
  }

  ///Tüm izinlerin kontrol edildiği yer
  Future<bool> checkConnectionAsync(BuildContext context) async {
    var result = false;
    await _permissionService.isConnected().then(
      (onValue) {
        if (!onValue) {
          HelperService.showflushbar(
            context,
            title: "Connection Error",
            message: "No Internet Connection",
          );
        }

        result = onValue;
      },
      onError: (error) {
        print('İzinler kontrol edilirken hata oluştu. Hata: $error');
      },
    );

    return result;
  }
}
