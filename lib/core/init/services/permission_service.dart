import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'storage_service.dart';

///Uygulamada kullanılan cıhazların izinleri ile ilgili kontrolleri yapar
class PermissionService {
  ///Uygulamanın internete bağlı olup olmadığını kontrol eder.
  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  // ///Kullanıcının telefonundaki versiyon kontrolünü sağlar.
  // checkVersion(context) async {
  //   await Future.delayed(Duration(milliseconds: 50));
  //   ProcessService _processService = locator<ProcessService>();

  //   // await _processService.getRepositoryAsync(
  //   //     context: context,
  //   //     function: () async => await backend apisinden gelecek,
  //   //     funcitonName: "memberProvider.getVersionInfo()",
  //   //     isNotifier: false);

  //   String oldVersion = "";
  //   String newVersion = "";

  //   if (Platform.isIOS) {
  //     oldVersion = Constant.iOSVersion;
  //     newVersion = model.customer.ios.version.toString() +
  //         '.' +
  //         model.customer.ios.major.toString() +
  //         '.' +
  //         model.customer.ios.minor.toString();
  //   } else {
  //     oldVersion = Constant.androidVersion;
  //     newVersion = model.customer.android.version.toString() +
  //         '.' +
  //         model.customer.android.major.toString() +
  //         '.' +
  //         model.customer.android.minor.toString();
  //   }

  //   //Versiyon numarasının arasındaki noktalar temizleniyor.
  //   var oldVersions = oldVersion.split(".");
  //   var newVersions = newVersion.split(".");

  //   //Major-Minor değişiklikleri kontrol etmek için sayıların ilk iki haneleri ayrı ayrı alınıyor.
  //   var majorOld = oldVersions[0];
  //   var minorOld = oldVersions[1];
  //   var lastCharOld = oldVersions[2];

  //   var majorNew = newVersions[0];
  //   var minorNew = newVersions[1];
  //   var lastCharNew = newVersions[2];

  //   if (int.parse(majorNew) > int.parse(majorOld)) {
  //     //Versiyonda Değişiklik var ise güncelleştirme indirilmesi için popup açılıyor
  //     Platform.isIOS
  //         ? showDialog(
  //             context: context, child: cupertinoAlertDialog(true, context), builder: (BuildContext context) {
  //               return
  //              })
  //         : showDialog(context: context, child: alertDialog(true, context));
  //   } else if ((int.parse(majorNew) >= int.parse(majorOld) &&
  //           int.parse(minorNew) > int.parse(minorOld)) ||
  //       int.parse(majorNew) >= int.parse(majorOld) &&
  //           int.parse(minorNew) >= int.parse(minorOld) &&
  //           int.parse(lastCharNew) > int.parse(lastCharOld)) {
  //     if (popupShowedCount == null || popupShowedCount < 5) {
  //       popupShowedCount = popupShowedCount == null ? 1 : popupShowedCount += 1;
  //       _storageService.setisUpdatePopupShowed(popupShowedCount);
  //       //Major değişiklik var ise popup açılıp isteğe bağlı indirmeye yönlendirilebiliyor.
  //       Platform.isIOS
  //           ? showDialog(
  //               context: context, child: cupertinoAlertDialog(false, context))
  //           : showDialog(context: context, child: alertDialog(false, context));
  //     }
  //   } else
  //     return;
  // }

  // ///Android için alert dialog
  // WillPopScope alertDialog(bool isMajor, context) {
  //   return WillPopScope(
  //     onWillPop: () async => false,
  //     child: AlertDialog(
  //       title: Text("Güncelleme Mevcut!"),
  //       content: Text("Güncellemeyi indir!"),
  //       actions: <Widget>[
  //         FlatButton(
  //           child: Text("İndir"),
  //           onPressed: () => _launchURL(
  //               "https://play.google.com/store/apps/details?id=com.gelal.customer1"),
  //         ),
  //         !isMajor
  //             ? FlatButton(
  //                 child: Text("Sonra"),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 })
  //             : Container()
  //       ],
  //     ),
  //   );
  // }

  // //iOS için alert dialog
  // WillPopScope cupertinoAlertDialog(bool isMajor, context) {
  //   return WillPopScope(
  //     onWillPop: () async => false,
  //     child: CupertinoAlertDialog(
  //       title: Text("Güncelleme Mevcut!"),
  //       content: Padding(
  //         padding: const EdgeInsets.only(top: 15.0),
  //         child: Text("Güncellemeyi indir!"),
  //       ),
  //       actions: <Widget>[
  //         FlatButton(
  //           child: Text("İndir"),
  //           onPressed: () => _launchURL(
  //               "https://apps.apple.com/us/app/gelal/id1499609997?l=tr&ls=1"),
  //         ),
  //         !isMajor
  //             ? FlatButton(
  //                 child: Text("Sonra"),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 })
  //             : Container()
  //       ],
  //     ),
  //   );
  // }

  // ///Kullanılan cihazın bilgilerini alıp locale storage'e kaydeder
  // Future<void> getDeviceInfoAsync(BuildContext context) async {
  //   try {
  //     String deviceInfoStr;
  //     StorageService _storageService = locator<StorageService>();
  //     //MemberRepository _memberRepository = locator<MemberRepository>();
  //     //if (deviceInfoStr != null) return;

  //     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  //     var token = _memberProvider.notificationToken;

  //     viewModel.token = token;
  //     if (Platform.isAndroid) {
  //       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

  //       viewModel.os = 'Android';
  //       viewModel.height = context.size.height;
  //       viewModel.width = context.size.width;
  //       viewModel.model = androidInfo.model;
  //       viewModel.identity = androidInfo.androidId;
  //       viewModel.systemVersion = androidInfo.version.sdkInt.toString();
  //       viewModel.systemVersion += "#" + Constant.androidVersion;
  //     } else if (Platform.isIOS) {
  //       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

  //       viewModel.os = 'IOS';
  //       viewModel.model = iosInfo.model;
  //       viewModel.identity = iosInfo.identifierForVendor;
  //       viewModel.height = context.size.height;
  //       viewModel.width = context.size.width;
  //       viewModel.systemVersion = iosInfo.systemVersion;
  //       viewModel.systemVersion += "#" + Constant.iOSVersion;
  //     }

  //     deviceInfoStr = deviceViewModelToJson(viewModel);
  //     print(deviceInfoStr);

  //     await _storageService.setDeviceInfoAsync(deviceInfoStr);

  //     //await _memberRepository.saveUserDevice(deviceInfoStr);
  //   } catch (e) {
  //     print(
  //         'PermissionService.getDeviecInfoAsync metodunda cihaz bilgileri alınırken hata oluştu. Hata: $e');

  //   }
  // }

  // ///Helper Methods
  // _launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
