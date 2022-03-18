// ignore_for_file: prefer_collection_literals

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bookapp/core/constants/app/app_constants.dart';
import 'package:bookapp/core/constants/enums/alert_type_enum.dart';
import 'package:bookapp/core/constants/enums/base_model.dart';
import 'package:bookapp/core/constants/enums/http_request_enum.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:bookapp/locator.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RequestHelper {
  ///HTTP POST, GET, PUT, DELETE requests
  static Future requestAsync(
    RequestType requestType,
    String baseUrl, {
    String? body,
    bool moreTimeOut = false,
  }) async {
    AppStateProvider? _appStateProvider = locator<AppStateProvider>();
    http.Response? response;

    print('Request Url => ' + baseUrl);

    var client = http.Client();
    FutureOr<Response> timeOutFunc = http.Response("Timeout Error", 598);

    try {
      //*Get Header
      Map<String, String> headers = await _getHeaderAsync();

      //*Log Request
      var requestStr =
          'Request --> ${requestType.toString()}, Url: $baseUrl, Header: $headers, Body: $body';
      print(requestStr);
      var url = Uri.parse(baseUrl);

      switch (requestType) {
        case RequestType.Post:
          response = await http.post(url, headers: headers, body: body).timeout(
              const Duration(seconds: Constant.TIMEOUTPERIOD),
              onTimeout: () => timeOutFunc);

          break;
        case RequestType.Put:
          response = await http.put(url, headers: headers, body: body).timeout(
              const Duration(seconds: Constant.TIMEOUTPERIOD),
              onTimeout: () => timeOutFunc);

          break;
        case RequestType.Get:
          response = await http.get(url, headers: headers).timeout(
              const Duration(seconds: Constant.TIMEOUTPERIOD),
              onTimeout: () => timeOutFunc);

          break;
        case RequestType.Delete:
          response = await http
              .delete(url, headers: headers, body: body)
              .timeout(const Duration(seconds: Constant.TIMEOUTPERIOD),
                  onTimeout: () => timeOutFunc);

          break;
      }

      //*Log Response
      // print(
      //     'Response --> StatusCode: ${response.statusCode}, Body: ${response.toString()}');

      //*İşlemin status koduna göre AlertType güncelle
      _appStateProvider.setAlertType(AlertType.None);
      _setAlertType(response.statusCode, _appStateProvider);
      print("STATUS CODE => " + response.statusCode.toString());

      if (_appStateProvider.alertType == AlertType.Success) {
        var jsonbody = jsonDecode(response.body);
        return jsonbody;
        // if (jsonbody["message"] != null) {
        //   _appStateProvider.setErrorMessage(jsonbody["message"]);
        // }

        // if (!jsonbody["success"]) {
        //   _appStateProvider.setAlertType(AlertType.Error);
        //   return null;
        // } else {
        //   if (jsonbody["data"] == null || jsonbody["data"] == []) {
        //     return jsonbody;
        //   } else {
        //     return jsonbody;
        //   }
        // }
      } else {
        var jsonbody = jsonDecode(response.body);

        /// Unexpected Route
        NavigationService navigation = NavigationService.instance;
        _appStateProvider.setErrorMessage(jsonbody["message"]);
        navigation.navigateToPage(path: NavigationConstants.homeView);
        return null;
      }
    } on TimeoutException catch (e) {
      print('TimeoutException $e');
      _appStateProvider.setErrorMessage('İşlem zaman aşımına uğradı.');
      // LogHelper.error("error url: " + url + "//" + e.toString());
      _setAlertType(response!.statusCode, _appStateProvider);
      return null;
    } on PlatformException catch (e) {
      print('PlatformException $e');
      _setAlertType(response!.statusCode, _appStateProvider);
      return null;
    } on SocketException catch (e) {
      print('SocketException $e');
      _appStateProvider.setErrorMessage('Bağlantı sorunu oluştu.');
      _setAlertType(response!.statusCode, _appStateProvider);
      return null;
    } catch (e) {
      print('requestAsync methodunda hata oluştu: $e');
      _setAlertType(response!.statusCode, _appStateProvider);
      return null;
    } finally {
      client.close();
    }
  }

  ///Prepare header before request
  static Future<Map<String, String>> _getHeaderAsync() async {
    Map<String, String> header = Map<String, String>();
    header["Content-Type"] = "Content-Type:application/json";
    return header;
  }

  ///Set AlertType by Status Code after get response
  static void _setAlertType(
      int statusCode, AppStateProvider _appStateProvider) {
    switch (statusCode) {
      case 200:
      case 201:
      case 202:
      case 204:
        _appStateProvider.setAlertType(AlertType.Success);
        break;

      case 401:
        _appStateProvider.setAlertType(AlertType.NoAuthentication);
        //exit(0);
        break;
      case 400:
        _appStateProvider.setAlertType(AlertType.Error);

        //checkResponseMessage(result, context);
        break;
      default:
        _appStateProvider.setAlertType(AlertType.Error);
    }
  }

  // ///API'den gelen hata mesajını ekrana basmak için yardımcı eder
  // static void _setErrorMessage(String body) {
  //   if (body == null || body.isEmpty) return;

  //   Map<String, dynamic> map = json.decode(body);

  //   BaseResponseModel model = BaseResponseModel.fromJson(map);

  //   if (model.isSuccess == null || model.isSuccess) return;

  //   if (model.error.isUiException) {
  //     _appStateProvider.setAlertType(Enum.AlertType.UIException);
  //     _appStateProvider.setErrorMessage(model.error.message);
  //   } else {
  //     _appStateProvider.setErrorMessage('Bir sorun oluştu.');
  //   }
  //   _appStateProvider.setCustomExcType(model.error.customExceptionType);

  //   //*exceptionType = 1 ServiceException
  //   //*exceptionType = 2 DatabaseException
  //   //*exceptionType = 3 PaymentException
  //   print('exceptionType: ${model.error.exceptionType}');
  // }

  R? responseParser<R, T>(BaseModel model, dynamic data) {
    if (data is List) {
      return data.map((e) => model.fromJson(e)).toList().cast<T>() as R;
    } else if (data is Map) {
      return model.fromJson(data as Map<String, Object>) as R;
    }
    return data as R?;
  }
}
