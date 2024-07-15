import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_demo/libraries/data/api_data.dart';
import 'package:pokemon_demo/services/helpers/exceptions.dart';

abstract class ApiBase {
  late String serverUrl;
  late String request;
  late Map<String, String> headers;
}

///***************************************************************************
/// ApiService
///***************************************************************************
class ApiService extends ApiBase {
  /// Singleton constructor
  static final ApiService _instance = ApiService._internal();

  factory ApiService({required String url, String? token, required String request}) {
    _instance.serverUrl = api + url;
    _instance.request = request;

    /// For the body json
    _instance.headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    if (token != null) {
      /// Add token if existing
      _instance.headers[HttpHeaders.authorizationHeader] = "JWT $token";
    }

    return _instance;
  }

  factory ApiService.baseUrl(String url, {String? token}) {
    _instance.serverUrl = url;

    /// For the body json
    _instance.headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    if (token != null) {
      /// Add token if existing
      _instance.headers[HttpHeaders.authorizationHeader] = "JWT $token";
    }

    return _instance;
  }

  ApiService._internal();

  ///*************** apiGetRequest ***************
  Future<dynamic> apiGetRequest() async {
    var responseJson;

    try {
      final int startTime = DateTime.now().millisecondsSinceEpoch;

      final response = (headers == null) ? await http.get(Uri.parse(serverUrl)) : await http.get(Uri.parse(serverUrl), headers: headers);
      debugPrint("Url ->$request: $serverUrl");
      responseJson = _returnResponse(response);
      final endTime = DateTime.now().millisecondsSinceEpoch;

      debugPrint("Response GET ${response.statusCode}->$request: ${jsonEncode(responseJson)}");
      debugPrint('Execution Time Request apiGetRequest $request: ${endTime - startTime} milliseconds.');
    } on SocketException {
      throw FetchDataException();
    }
    return responseJson;
  }

  ///*************** apiPostRequest ***************
  Future<dynamic> apiPostRequest(String body) async {
    var responseJson;

    try {
      final int startTime = DateTime.now().millisecondsSinceEpoch;
      debugPrint("Url ->$request: $serverUrl");
      final response =
          (headers == null) ? await http.post(Uri.parse(serverUrl), body: body) : await http.post(Uri.parse(serverUrl), headers: headers, body: body);
      responseJson = _returnResponse(response);
      final endTime = DateTime.now().millisecondsSinceEpoch;

      debugPrint("Response POST ${response.statusCode}->$request: ${jsonEncode(responseJson)}");
      debugPrint('Execution Time Request apiPostRequest: ${endTime - startTime} milliseconds.');
    } on SocketException {
      throw FetchDataException();
    }

    return responseJson;
  }

  ///*************** apiPutRequest ***************
  Future<dynamic> apiPutRequest(String body) async {
    var responseJson;

    try {
      final int startTime = DateTime.now().millisecondsSinceEpoch;
      debugPrint("Url ->$request: $serverUrl");
      final response =
          (headers == null) ? await http.put(Uri.parse(serverUrl), body: body) : await http.put(Uri.parse(serverUrl), body: body, headers: headers);
      responseJson = _returnResponse(response);
      final endTime = DateTime.now().millisecondsSinceEpoch;

      debugPrint("Response PUT ${response.statusCode}->$request: ${jsonEncode(responseJson)}");
      debugPrint('Execution Time Request apiPutRequest: ${endTime - startTime} milliseconds.');
    } on SocketException {
      throw FetchDataException();
    }

    return responseJson;
  }

  ///*************** apiDeleteRequest ***************
  Future<dynamic> apiDeleteRequest() async {
    var responseJson;

    try {
      final int startTime = DateTime.now().millisecondsSinceEpoch;
      debugPrint("Url ->$request: $serverUrl");
      final response = (headers == null) ? await http.delete(Uri.parse(serverUrl)) : await http.delete(Uri.parse(serverUrl), headers: headers);
      responseJson = _returnResponse(response);
      final endTime = DateTime.now().millisecondsSinceEpoch;

      debugPrint("Response DELETE ${response.statusCode}->$request: ${jsonEncode(responseJson)}");
      debugPrint('Execution Time Request apiDeleteRequest: ${endTime - startTime} milliseconds.');
    } on SocketException {
      throw FetchDataException();
    }

    return responseJson;
  }

  ///*************** _returnResponse ***************
  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201: // For the POST

        debugPrint("##API: Status code -> ${response.statusCode}");
        //debugPrint("##API: Status Body -> ${response.body}");
        /// Content-Type http header sent by the server is missing the
        /// encoding tag. This causes the Dart http client to decode the
        /// body as Latin-1 instead of utf-8.
        final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
        return responseJson;

      case 400:
        throw BadRequestException(utf8.decode(response.bodyBytes));
      case 401:
      case 403:
        throw UnauthorizedException(utf8.decode(response.bodyBytes));

      case 500:
        throw FetchDataException('Error occurred while Communication with Server with Status code: ${response.statusCode}');
      case 502:
        throw FetchDataException('Bad Gateway with Server with Status code: ${response.statusCode}');
    }
  }

//ApiService apiServer = new ApiService(url, token: token);
//     var response = await apiServer.apiGetRequest();
}
