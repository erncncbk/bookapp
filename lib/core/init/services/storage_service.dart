import 'package:bookapp/core/constants/app/app_constants.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:bookapp/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final AppStateProvider? _appStateProvider = locator<AppStateProvider>();

  /// Aydıt belleğindeki uygulama ile ilgili bilgileri temizler.
  Future<bool> clearStorageAsync() async {
    SharedPreferences instances = await SharedPreferences.getInstance();
    // instances.remove(Constant.firstOpen);

    await instances.remove(Constant.userToken);
    await instances.remove(Constant.theme);
    _appStateProvider!.clearToken();
    // await instances.clear();

    return true;
  }

  ///Bellekten Kullanıcı Tema bilgilerini alır.
  Future<String?> getThemeAsync() async {
    SharedPreferences instances = await SharedPreferences.getInstance();
    String? stringValue = instances.getString(Constant.theme);
    return stringValue;
  }

  ///Belleğe Kullanıcı Tema bilgilerini atar.
  Future<void> setThemeAsync(String theme) async {
    SharedPreferences instances = await SharedPreferences.getInstance();
    instances.setString(Constant.theme, theme);
  }

  ///Bellekten Kullanıcı Token bilgilerini alır.
  Future<String?> getTokenAsync() async {
    SharedPreferences instances = await SharedPreferences.getInstance();
    String? stringValue = instances.getString(Constant.userToken);
    return stringValue;
  }

  ///Belleğe Kullanıcı Token bilgilerini atar.
  Future<void> setTokenAsync(String token) async {
    SharedPreferences instances = await SharedPreferences.getInstance();
    instances.setString(Constant.userToken, token);
  }

  ///Kullanıcı Token'ının var olup olmadığını kontrol eder.
  Future<bool> userTokenDoesExist() async {
    String? token = await getTokenAsync();
    return token != null;
  }

  ///Bellekten ilk uygulama açılım durumunu sorgular
  Future<bool?> getFirstOpenAsync() async {
    SharedPreferences instances = await SharedPreferences.getInstance();
    bool? stringValue = instances.getBool(Constant.firstOpen);
    return stringValue ?? true;
  }

  ///Uygulamanın ilk açılışını setler
  Future<void> setFirstOpenAsync(bool value) async {
    SharedPreferences instances = await SharedPreferences.getInstance();
    instances.setBool(Constant.firstOpen, value);
  }
}
