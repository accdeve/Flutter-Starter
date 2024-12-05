// ignore_for_file: prefer_typing_uninitialized_variables

class ApiException implements Exception {
  final String? _message;
  final String? _prefix;
  final Map<String, dynamic>? _data; // Untuk menyimpan detail tambahan dari response

  ApiException([this._message, this._prefix = "", this._data]);

  @override
  String toString() {
    return "$_prefix$_message";
  }

  // Getter untuk mengambil data tambahan
  Map<String, dynamic>? get data => _data;
  String? get message => _message;
}

class FetchDataException extends ApiException {
  FetchDataException([String? message, Map<String, dynamic>? data]) : super(message, "Error During Communication: ", data);
}

class BadRequestException extends ApiException {
  BadRequestException([String? message, Map<String, dynamic>? data]) : super(message, "Invalid Request: ", data);
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([String? message, Map<String, dynamic>? data]) : super(message, "Unauthorised: ", data);
}

class InvalidInputException extends ApiException {
  InvalidInputException([String? message, Map<String, dynamic>? data]) : super(message, "Invalid Input: ", data);
}

class NetworkException extends ApiException {
  NetworkException([super.message]);
}

class GeneralException extends ApiException {
  GeneralException([super.message]);
}

class ClientException extends ApiException {
  ClientException([super.message]);
}

class ServerException extends ApiException {
  ServerException([super.message]);
}

