import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as Http;
import 'package:million/utils/app_constants.dart';
import 'package:million/utils/error_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static const String noInternetMessage =
      'Connection to API server failed due to internet connection';
  final int timeoutInSeconds = 30;

  String? token;
  String? reToken;
  Map<String, String>? _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.TOKEN);
    reToken = sharedPreferences.getString(AppConstants.REFRESH_TOKEN);
    debugPrint('Token: $token');
    debugPrint('ReToken: $reToken');
    // try {
    //   _addressModel = AddressModel.fromJson(jsonDecode(
    //       sharedPreferences.getString(AppConstants.USER_NAME).toString()));
    //   print('-------------');
    //   print(_addressModel.toJson());
    // } catch (e) {}
    if (token != null && reToken != null) {
      updateHeader(
        token,
        reToken,
      );
    } else {
      updateHeader("", "");
    }
  }

  void updateHeader(String? reToken, String? token) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": 'Bearer ' + token!,
      "x-refresh": 'Bearer ' + reToken!,
    };
  }

  Future<Response> getData(String uri,
      {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $appBaseUrl$uri\nHeader: $_mainHeaders');
      print(token);
      Http.Response _response = await Http.get(
        Uri.parse(appBaseUrl + uri),
        headers: headers != null ? headers : _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response response, String uri) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    } catch (e) {}
    Response _response = Response(
      body: _body != null ? _body : response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _errorResponse.errors[0].message);
      } else if (_response.body.toString().startsWith('{message')) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      }
    } else if (_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: noInternetMessage);
    }
    debugPrint(
        '====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
    return _response;
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      debugPrint('====> API Body: $body');
      Http.Response _response = await Http.post(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      debugPrint('====> API Body: $body');
      Http.Response _response = await Http.put(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri,
      {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      Http.Response _response = await Http.delete(
        Uri.parse(appBaseUrl + uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteDataBody(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      Http.Response _response = await Http.delete(Uri.parse(appBaseUrl + uri),
              headers: headers ?? _mainHeaders, body: body)
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Http.Response> appUserUploadFileAsyncProfile(
      dynamic filePath, String? base64Image) async {
    print("========CallFile UPLOAD_FILE=======");
    print(AppConstants.BASE_URL + AppConstants.UPLOAD_FILE);
    final postUri = Uri.parse(AppConstants.BASE_URL + AppConstants.UPLOAD_FILE);

    Http.MultipartRequest request = Http.MultipartRequest('POST', postUri);

    print('api client token');
    token = '';
    reToken = '';
    print(filePath!);
    Map<String, String> headers = {
      "Authorization": 'Bearer ' + token!,
      "x-refresh": 'Bearer ' + reToken!,
    };
    request.headers.addAll(headers);

    print(filePath);
    Http.MultipartFile multipartFile =
        await Http.MultipartFile.fromPath('file', filePath);

    request.files.add(multipartFile);

    request.fields["file"] = filePath;
    print(request.fields);
    print(request.headers);

    var res = await request.send().catchError((error) {
      debugPrint("error $error");
    });
    print('statusCode');

    print(res.statusCode);
    var resmmain = await res.stream.transform(utf8.decoder);
    final response = await Http.Response.fromStream(res);
    print(response.body);
    return response;
  }

  Future<Http.Response> appUserUploadFileAsyncProfileUpload(
      dynamic filePath, String? base64Image) async {
    print("========CallFile UPLOAD_FILE=======");
    print(AppConstants.BASE_URL + AppConstants.UPLOAD_DOCS);
    final postUri = Uri.parse(AppConstants.BASE_URL + AppConstants.UPLOAD_DOCS);

    Http.MultipartRequest request = Http.MultipartRequest('POST', postUri);

    print('api client token');
    token = '';
    reToken = '';
    print(filePath!);
    Map<String, String> headers = {
      "Authorization": 'Bearer ' + token!,
      "x-refresh": 'Bearer ' + reToken!,
    };
    request.headers.addAll(headers);

    print(filePath);
    Http.MultipartFile multipartFile =
    await Http.MultipartFile.fromPath('file', filePath);

    request.files.add(multipartFile);

    request.fields["file"] = filePath;
    print(request.fields);
    print(request.headers);

    var res = await request.send().catchError((error) {
      debugPrint("error $error");
    });
    print('statusCode');

    print(res.statusCode);
    var resmmain = await res.stream.transform(utf8.decoder);
    final response = await Http.Response.fromStream(res);
    print(response.body);
    return response;
  }
}



