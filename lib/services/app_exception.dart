import 'dart:convert';

class AppException implements Exception {
  final String message;
  final String prefix;
  final String url;

  AppException([this.message, this.prefix, this.url]);

  String toString() {
    return "$prefix $message $url";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message, String url]) : super(message, "Error During Communication: ", url);
}

class BadRequestException extends AppException {
  BadRequestException([String message, String url]) : super(message, "Bad Request: ", url);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String message, String url]) : super(message, "Unauthorised: ", url);
}

class NotFoundException extends AppException {
  NotFoundException([String message, String url]) : super(message, "Not Found: ", url);
}

class InvalidInputException extends AppException {
  InvalidInputException([String message, String url]) : super(message, "Invalid Input: ", url);
}

class TimeOutException extends AppException {
  TimeOutException([String message, String url]) : super(message, "Time Out Exception: ", url);
}

class ConflictException extends AppException {
  ConflictException([String message, String url]) : super(message, "Conflict Exception: ", url);
}

class InternalServerErrorException extends AppException {
  InternalServerErrorException([String message, String url]) : super(message, "Internal Server Error Exception: ", url);
}

class ServiceUnavailableException extends AppException {
  ServiceUnavailableException([String message, String url]) : super(message, "Service Unavailable Exception: ", url);
}