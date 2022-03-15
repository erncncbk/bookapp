import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProvider {
  static AppProvider? _instance;
  static AppProvider? get instance {
    _instance ??= AppProvider._init();
    return _instance;
  }

  AppProvider._init();
  List<SingleChildWidget> singleItem = [];
  List<SingleChildWidget> dependItem = [
    ChangeNotifierProvider(create: (context) => AppStateProvider()),
    ChangeNotifierProvider(create: (context) => BookStateProvider()),
    ChangeNotifierProvider(create: (context) => ThemeNotifier()),
    Provider.value(value: NavigationService.instance)
  ];
  List<SingleChildWidget> uiChangesItem = [];
}
