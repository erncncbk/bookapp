import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:bookapp/locator.dart';
import 'package:bookapp/view/account/account_page_animator.dart';
import 'package:bookapp/view/account/fav/fav_page.dart';
import 'package:bookapp/view/authentication/forgot_password_page.dart';
import 'package:bookapp/view/authentication/login_page.dart';
import 'package:bookapp/view/authentication/register_page.dart';
import 'package:bookapp/view/book_detail.dart';
import 'package:bookapp/view/bookmark/bookmark_page.dart';
import 'package:bookapp/view/campaigns/campaigns_page.dart';
import 'package:bookapp/view/discover/discover_page.dart';
import 'package:bookapp/view/discover/discover_detail.dart';
import 'package:bookapp/view/gift/gift_card.dart';
import 'package:bookapp/view/home_view.dart';
import 'package:bookapp/view/notification/notification.dart';
import 'package:bookapp/view/onboard_page/onboard_page.dart';
import 'package:bookapp/view/order/order_page.dart';
import 'package:bookapp/view/search_page/search_page.dart';
import 'package:bookapp/view/settings/notification_options.dart';
import 'package:bookapp/view/settings/settings.dart';
import 'package:bookapp/view/shopping_cart/shopping_cart_page.dart';
import 'package:bookapp/view/splash/splash_page.dart';
import 'package:flutter/material.dart';

class NavigationRoute {
  static NavigationRoute? _instance;
  static NavigationRoute? get instance {
    _instance ??= NavigationRoute._init();
    return _instance;
  }

  NavigationRoute._init();
  final AppStateProvider? _appStateProvider = locator<AppStateProvider>();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      //Splash Page
      case NavigationConstants.splahPage:
        return normalNavigate(const SplashPage());
      //Home Page
      case NavigationConstants.homeView:
        return normalNavigate(const HomeView());
      //Onboard Page
      case NavigationConstants.onBoardView:
        return normalNavigate(const OnboardPage());
      //Book Detail
      case NavigationConstants.bookDetail:
        return normalNavigate(const BookDetail());
      //Register Page
      case NavigationConstants.registerPage:
        return normalNavigate(const RegisterPage());
      //Login Page
      case NavigationConstants.loginPage:
        return normalNavigate(const LoginPage());
      //Forgot Password
      case NavigationConstants.forgotPassword:
        return normalNavigate(const ForgotPasswordPage());
      //Account Page
      case NavigationConstants.accountPage:
        return normalNavigate(const AccountPageAnimator(), loginRequired: true);
      //Campaigns Page
      case NavigationConstants.campaignsPage:
        return normalNavigate(const CampaignsPage(), loginRequired: true);
      //GiftCard Page
      case NavigationConstants.giftCardPage:
        return normalNavigate(GiftCard(), loginRequired: true);
      //Settings Page
      case NavigationConstants.settings:
        return normalNavigate(SettingsPage(), loginRequired: true);
      //Notification Options
      case NavigationConstants.notificationOptions:
        return normalNavigate(NotificationOptions(), loginRequired: true);
      //Favorites
      case NavigationConstants.favorites:
        return normalNavigate(const FavPage(), loginRequired: true);
      //Shopping Cart
      case NavigationConstants.shoppingCart:
        return normalNavigate(const ShoppingCart(), loginRequired: true);
      //Bookmarks
      case NavigationConstants.bookmarks:
        return normalNavigate(const BookmarkPage(), loginRequired: true);
      //Notification
      case NavigationConstants.notificationPage:
        return normalNavigate(const NotificationPage(), loginRequired: true);
      //Discover
      case NavigationConstants.discoverPage:
        return normalNavigate(const DiscoverPage());
      //DiscoverDetail
      case NavigationConstants.discoverDetail:
        return normalNavigate(const DiscoverDetail(), fullScreenDialog: true);
      //Search Page
      case NavigationConstants.searchPage:
        return normalNavigate(const SearchPage(), fullScreenDialog: true);
      //Orders Page
      case NavigationConstants.orderPage:
        return normalNavigate(const OrderPage(), fullScreenDialog: true);
      default:
        return MaterialPageRoute(builder: (context) => const SplashPage());
    }
  }

  MaterialPageRoute normalNavigate(
    Widget widget, {
    bool fullScreenDialog = false,
    bool loginRequired = false,
  }) {
    return MaterialPageRoute(
        builder: (context) =>
            loginRequired && _appStateProvider!.getToken == null
                ? const LoginPage()
                : widget,
        fullscreenDialog: fullScreenDialog);
  }
}
