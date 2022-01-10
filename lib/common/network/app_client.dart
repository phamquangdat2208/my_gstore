import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:my_gstore/common/constants/key_save_local_constant.dart';
import 'package:my_gstore/common/constants/string_const.dart';
import 'package:my_gstore/common/exception/connect_exception.dart';
import 'package:my_gstore/common/exception/server_exception.dart';
import 'package:my_gstore/common/exception/timeout_exception.dart';
import 'package:my_gstore/common/exception/token_expired_exception.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/local/local_app.dart';
import 'package:my_gstore/common/network/app_header.dart';
import 'package:my_gstore/common/network/configs.dart';
import 'package:my_gstore/common/ultils/log_util.dart';

class AppClient {
  AppHeader? header;
  final GlobalAppCache globalAppCatch;
  final LocalApp localApp;
  bool _runOnce = true;

  AppClient(this.globalAppCatch, this.localApp);

  void setHeader(AppHeader header) {
    this.header = header;
  }


  Future<Map> get(String endPoint,{bool handleData = true}) async {
    await _checkConnectionAndPosition();
    var url = Uri.parse('${Configurations.host}$endPoint');
    Response? response = await http
        .get(url, headers: header?.toJson() ?? {})
        .timeout(Duration(seconds: Configurations.connectTimeout),
        onTimeout: () {
          throw TimeOutException();
        });
    String fullRequets = 'endPoint: ${Configurations.host}$endPoint \n'
        'Token: ${header?.accessToken} \n'
        'Response: ${response.body} \n';
    final data = json.decode(response.body);
    if(!handleData){
      return data;
    }
    bool checkExpired =
    _handleErrorCode(data, fullRequest: fullRequets, isPost: false);
    if (checkExpired && _runOnce) {
      await _makeRefreshToken();
      var url = Uri.parse('${Configurations.host}$endPoint');
      Response? newResponse = (await http
          .get(url, headers: header?.toJson() ?? {})
          .timeout(Duration(seconds: Configurations.connectTimeout),
          onTimeout: () {
            throw TokenExpiredException(errorText: fullRequets);
          }));
      _runOnce = true;
      Map<String, dynamic> dataNew = json.decode(newResponse.body);
      bool checkExpired =
      _handleErrorCode(dataNew, fullRequest: fullRequets, isPost: false);
      if (checkExpired) {
        throw TokenExpiredException(errorText: fullRequets);
      }
      return dataNew;
    }
    return data;
  }

  Future<Map> post(
    String endPoint, {
    dynamic body,
    String? contentType,
    bool handleResponse = true,
    bool encodeBody = true,
  }) async {
    await _checkConnectionAndPosition();
    var url = Uri.parse('${Configurations.host}$endPoint');
    Response? response = await http
        .post(url,
            body: body != null ? (encodeBody ? json.encode(body) : body) : null,
            headers: header?.toJson() ?? {})
        .timeout(Duration(seconds: Configurations.connectTimeout),
            onTimeout: () {
      throw TimeOutException();
    });

    Map<String, dynamic> data = json.decode(response.body);
    if (!handleResponse) {
      return data;
    }
    String fullRequets = 'endPoint: ${Configurations.host}$endPoint\n'
        'Token: ${header?.accessToken}\n'
        'body: $body\n'
        'Response: ${response.body}\n';

    // check expired token
    // bool checkExpired = _handleErrorCode(data, fullRequest: fullRequets);
    // if (checkExpired && _runOnce) {
    //   await _makeRefreshToken();
    //   var url = Uri.parse('${Configurations.host}$endPoint');
    //   Response? newResponse = await http
    //       .post(url,
    //           body: body != null ? json.encode(body) : null,
    //           headers: header?.toJson() ?? {})
    //       .timeout(Duration(seconds: Configurations.connectTimeout),
    //           onTimeout: () {
    //     throw TokenExpiredException(errorText: fullRequets);
    //   });
    //   _runOnce = true;
    //   Map<String, dynamic> dataNew = json.decode(newResponse.body);
    //   bool checkExpired = _handleErrorCode(dataNew, fullRequest: fullRequets);
    //   if (checkExpired) {
    //     throw TokenExpiredException(errorText: fullRequets);
    //   }
    //   return dataNew;
    // }
    return data;
  }

  Future _makeRefreshToken() async {
    _runOnce = false;
    String? refreshToken = localApp
        .getStringSharePreference(KeySaveLocalConstant.saveRefreshToken);

    String? newAccessToken;
    try {
      // newAccessToken = await _getNewAccessToken(refreshToken);
      if (newAccessToken == null) {
        throw TokenExpiredException();
      }
    } catch (e) {
      throw TokenExpiredException();
    }
    header
      ?..accessToken = newAccessToken
      ..lat = globalAppCatch.gspPosition?.latitude ?? 0
      ..lng = globalAppCatch.gspPosition?.longitude ?? 0;
  }

  bool _handleErrorCode(Map<String, dynamic> body,
      {String? fullRequest, bool isPost = true}) {
    String typeRequest = isPost ? 'REQUEST_POST:' : 'REQUEST_GET:';
    if (body['Code'] == 401) {
      return true;
    }
    if (body['Code'] != 200) {
      LOG.e('$typeRequest $fullRequest');
      throw ServerException(
        message: body['Message'],
        errorCode: body['Code'],
        errorText: '$fullRequest',
      );
    }
    LOG.w('$typeRequest $fullRequest');
    return false;
  }

  Future<dynamic> getResponseFromApiNonToken({required String api}) async {
    await _checkConnectionAndPosition();
    try {
      var url = Uri.parse(api);
      final Response response = await http.get(url);
      return json.decode(response.body);
    } catch (e) {
      throw ServerException();
    }
  }

  Future _checkConnectionAndPosition() async {
    try {
      if (header?.lat == null || header?.lng == null) {
        header?.lat = globalAppCatch.gspPosition?.latitude ?? 0;
        header?.lng = globalAppCatch.gspPosition?.longitude ?? 0;
      }
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
    } catch (_) {
      throw ConnectException(message: StringConst.connectError);
    }
  }

  Future logBug({dynamic exception, String? functionName, String? text}) async {
    // try {
    //   String inforDevice = await CommonUtil.getInforDevice();
    //   String content = text ??
    //       'ExceptionString: ${exception.toString()} <||>'
    //           'ExceptionType: ${exception.runtimeType} <||> '
    //           'FunctionName: $functionName <||> '
    //           'Time: ${DateFormat('HH:mm dd/MM/yyyy').format(DateTime.now())} <||> '
    //           'Device Info: $inforDevice <||> '
    //           'Error: ${(exception is AppException) ? exception.errorText : exception.toString()} <||> '
    //           'Version:${Platform.isAndroid ? Configurations.versionAndroid : Configurations.versionIos} <||> '
    //           'CustomerId: ${globalAppCatch.profileModel?.iD}';
    //   await post('Log/AddLog', body: {
    //     'Title': 'Bug G-Store',
    //     'Source': '${Platform.isAndroid ? 'AndroidOS' : 'AppiOS'}',
    //     'Details': '$content'
    //   });
    // } catch (e) {
    //   LOG.e('logBugError');
    // }
  }
}
