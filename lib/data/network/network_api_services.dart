import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:partymap/data/app_exceptions.dart';
import 'package:partymap/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    dynamic responseJson;

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOutException {
      throw RequestTimeOutException('');
    }

    return responseJson;
  }

  Future<dynamic> postApi(dynamic data, String url) async {
    dynamic responseJson;

    try {
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data))
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOutException {
      throw RequestTimeOutException('');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw InvalidUrlException('');
      default:
        throw FetchDataException(
            'Error occured while communicating with server ${response.statusCode}');
    }
  }
}
