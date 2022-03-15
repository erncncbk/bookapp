import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:flutter/foundation.dart';

class RedirectService {
  static final RedirectService _instance = RedirectService._init();
  static RedirectService get instance => _instance;

  RedirectService._init();

  NavigationService navigation = NavigationService.instance;

  // void redirectForAccountType(String? accountTypeId) {
  //   switch (accountTypeId) {
  //     case "1":
  //       !kIsWeb
  //           ? navigation.navigateToPageClear(
  //               path: NavigationConstants.homePageClient,
  //             )
  //           : navigation.navigateToPageClear(
  //               path: NavigationConstants.webTerapistHome,
  //             );
  //       break;
  //     case "2":
  //       !kIsWeb
  //           ? navigation.navigateToPageClear(
  //               path: NavigationConstants.therapistHomePage,
  //             )
  //           : navigation.navigateToPageClear(
  //               path: NavigationConstants.webTerapistHome);
  //       break;
  //     default:
  //       !kIsWeb
  //           ? navigation.navigateToPageClear(
  //               path: NavigationConstants.homePageClient,
  //             )
  //           : navigation.navigateToPageClear(
  //               path: NavigationConstants.webLogin,
  //             );
  //   }
  // }
}
