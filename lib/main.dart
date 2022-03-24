import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/init/navigation/navigation_route.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/provider_list.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/firebase_options.dart';
import 'package:bookapp/locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  setupLocator();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [...AppProvider.instance!.dependItem],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Books",
      theme: Provider.of<ThemeNotifier>(context).currentTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: NavigationConstants.splahPage,
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoute.instance!.generateRoute,
    );
  }
}
