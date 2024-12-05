// Source:
// https://medium.com/flutter-community/handling-network-calls-like-a-pro-in-flutter-31bd30c86be1

// ignore_for_file: prefer_typing_uninitialized_variables, library_prefixes

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:t_quiz/api/api_exceptions.dart';
import 'package:t_quiz/utils/constants.dart' as AppConst;

class ApiProvider {
  final String _baseUrl = AppConst.API_URL;
  Map<String, String> headers = {"Content-type": "application/json"};
  // LoginSuccess? loginSuccess;
  String? otp;

  // ApiProvider({this.loginSuccess, this.otp});

Future<dynamic> get(String url, {Map<String, String>? headers, Map<String, dynamic>? queryParams}) async {
  var responseJson;
  try {
    final uri = Uri.parse(_baseUrl + url).replace(queryParameters: queryParams?.map((key, value) => MapEntry(key, value.toString())));
    
    final response = await http.get(
      uri,
      headers: headers,
    );

    responseJson = _returnResponse(response);
  } on SocketException {
    throw NetworkException('Tidak ada koneksi internet');
  }
  return responseJson;
}


  Future<dynamic> getWithoutBaseurl(dynamic url, {Map<String, String>? headers}) async {
    var responseJson;
    try {
      final response = await http.get(url, headers: headers);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, {dynamic body, Map<String, String>? headers}) async {
    try {
      final response = await http.post(Uri.parse(_baseUrl + url), body: body, headers: headers);
      return _returnResponse(response);
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    } catch (e) {
      if (e is http.Response) {
        final responseJson = json.decode(e.body);
        throw FetchDataException(
          responseJson['message'],
          responseJson['data'],
        );
      } else {
        rethrow;
      }
    }
  }

  Future<dynamic> put(String url, {dynamic body, Map<String, String>? headers}) async {
    var responseJson;
    try {
      final response = await http.put(Uri.parse(_baseUrl + url), body: body, headers: headers);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, {Map<String, String>? headers}) async {
    var responseJson;
    try {
      final response = await http.delete(Uri.parse(_baseUrl + url), headers: headers);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return responseJson;
  }

  Future<dynamic> postMultipart(String url, {required List<File> files, Map<String, String>? headers, required Map<String, dynamic> body, required String pathFiles}) async {
    var responseJson;
    try {
      var uri = Uri.parse(_baseUrl + url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(
          headers ?? {},
        );

      body.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      for (var file in files) {
        request.files.add(await http.MultipartFile.fromPath(pathFiles, file.path));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return responseJson;
  }

  Future<dynamic> putMultipart(
    String url, {
    required File profilePicture,
    required Map<String, dynamic> body,
    required Map<String, String> headers,
  }) async {
    var responseJson;
    try {
      var uri = Uri.parse(_baseUrl + url);
      var request = http.MultipartRequest('PUT', uri)..headers.addAll(headers);

      body.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Menambahkan gambar profil (jika ada)
      var pic = await http.MultipartFile.fromPath(
        'profile_picture',
        profilePicture.path,
      );
      
      request.files.add(pic);
    
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw NetworkException('Tidak ada koneksi internet');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    final responseJson = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
      case 201:
        return responseJson;
      case 400:
        throw BadRequestException(responseJson['message'], responseJson['data']);
      case 401:
        throw UnauthorisedException(responseJson['message'], responseJson['data']);
      case 422:
        throw FetchDataException(responseJson['message'], responseJson['data']);
      case 500:
        throw ServerException(responseJson['message']);
      default:
        throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
          responseJson,
        );
    }
  }
}
