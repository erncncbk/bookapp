import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
import 'package:bookapp/core/init/services/helper_service.dart';
import 'package:get_it/get_it.dart';

import 'core/init/services/permission_service.dart';
import 'core/init/services/process_service.dart';
import 'core/init/services/storage_service.dart';

GetIt locator = GetIt.instance;

///Projede kullanılan veya kullanılacak Service, Provider ve Repository'lerin
///proje başlatıldığında ayağa kaldırılmasını sağlar.
void setupLocator() async {
  //*Providers
  locator.registerLazySingleton(() => AppStateProvider());
  locator.registerLazySingleton(() => BookStateProvider());
  locator.registerLazySingleton(() => ThemeNotifier());

  // //Repositories
  // locator.registerLazySingleton(() => InformationRepository());
  // locator.registerLazySingleton(() => LocationRepository());
  // locator.registerLazySingleton(() => ReservationRepository());

  //Services
  locator.registerLazySingleton(() => PermissionService());
  locator.registerLazySingleton(() => ProcessService());
  locator.registerLazySingleton(() => StorageService());
  locator.registerLazySingleton(() => HelperService());
  // locator.registerLazySingleton(() => WidgetService());
}
